-- Script de Stored Pedidos por catedra --
delimiter &&

DROP PROCEDURE IF EXISTS sp_paises_todos_titulares &&

CREATE PROCEDURE sp_paises_todos_titulares()
BEGIN
SELECT DISTINCT(nombrePais) Pais
FROM
(
	-- cuento todos los jugadores por pais que fueron titulares correspondientes a la primer seleccion
	SELECT COUNT(DISTINCT(participaJugador)) jugadores, seleccion1.representaPais representaPais
	FROM seleccion
	JOIN partido
	    ON equipoSeleccion1 = idSeleccion
	JOIN participacion
	    ON jugoPartido = idPartido
	JOIN jugador
	    ON participaJugador = idJugador
	JOIN integrante
	    ON idJugador = idIntegrante
	JOIN seleccion seleccion1
	    ON seleccion1.idSeleccion = perteneceSeleccion
	    AND equipoSeleccion1 = seleccion1.idSeleccion
	WHERE 
	    esTitular = 1
	GROUP BY 
	    seleccion1.representaPais
	UNION 
	-- cuento todos los jugadores por pais que fueron titulares correspondientes a la segunda seleccion
	SELECT COUNT(DISTINCT(participaJugador)) jugadores, seleccion2.representaPais representaPais
	FROM seleccion
	JOIN partido
	    ON equipoSeleccion2 = idSeleccion
	JOIN participacion
    	ON jugoPartido = idPartido
	JOIN jugador
	    ON participaJugador = idJugador
	JOIN integrante
	    ON idJugador = idIntegrante
	JOIN seleccion seleccion2
	    ON seleccion2.idSeleccion = perteneceSeleccion
	    AND equipoSeleccion2 = seleccion2.idSeleccion
	WHERE 
	    esTitular = 1
	GROUP BY 
	    seleccion2.representaPais
) selecciones 
JOIN
(
	-- cuento todos los jugadores por pais
	SELECT COUNT(idIntegrante) total_jugadores, representaPais idJugadoresPais FROM seleccion
	JOIN integrante 
	    ON perteneceseleccion = idseleccion AND tipoIntegrante = 'JUGADOR'
	GROUP BY representaPais
) equipos
-- que el total de jugadores se igual al total de titulares
ON total_jugadores = jugadores
-- del mismo pais
AND representaPais = idJugadoresPais
JOIN pais 
    ON idJugadoresPais = idPais;
END&&

-- delimiter &&

DROP PROCEDURE IF EXISTS sp_estadisticas_por_jugador &&

CREATE PROCEDURE sp_estadisticas_por_jugador()
BEGIN
-- proyecto los campos pedidos
SELECT apellido Apellido, nombreIntegrante Nombre, cantidadPartidos Partidos, 
promedioPuntos Promedio_Puntos, promedioAsistencias Promedio_Asistencias, promedioRebotes Promedio_Rebotes
FROM 
(
	-- agrupo todos las estadisticas por jugador (no uso el nombre porque pueden haber dos jugadores con el mismo nombre)
	SELECT participaJugador participaJugador, SUM(1) cantidadPartidos, AVG(puntos) promedioPuntos, 
	AVG(asistencias) promedioAsistencias, AVG(rebotes) promedioRebotes
	FROM participacion
	GROUP BY (participaJugador)
) estadisticas
JOIN jugador
ON participaJugador = idJugador
JOIN integrante
ON idJugador = idIntegrante
ORDER BY cantidadPartidos desc;
END&&

DROP PROCEDURE IF EXISTS sp_posibles_arbitros_por_partidos &&

CREATE PROCEDURE sp_posibles_arbitros_por_partidos(idPartidoSP INT)
BEGIN
DECLARE  equipo1   INT;
DECLARE  equipo2   INT;
DECLARE  fechaSP   DATE;
 
SET equipo1 = (SELECT 
  equipoSeleccion1
  FROM partido WHERE idPartido = idPartidoSP);

SET equipo2 = (SELECT 
  equipoSeleccion2
  FROM partido WHERE idPartido = idPartidoSP);

SET fechaSP = (SELECT 
  fecha
  FROM partido WHERE idPartido = idPartidoSP);

SELECT arbitro.idArbitro, arbitro.nombreArbitro 
FROM arbitro
LEFT JOIN
(
    SELECT 
        SUM(CASE WHEN scOReEquip1 > scOReEquip2 THEN 1 ELSE 0 END) AS ganados,
        COUNT(1) AS total,
        equipoSelecciON1 AS equipo,
        arbitra.idArbitroArb AS arbitro
    FROM tanteador
    JOIN partido 
    ON tanteador.idPartido = partido.idPartido
    AND nroCuarto = 4
    JOIN arbitra
    ON arbitra.idPartidoArb = partido.idPartido
    WHERE equipoSelecciON1 = equipo1
    GROUP BY equipoSelecciON1, arbitra.idArbitroArb
    UNION
    SELECT 
        SUM(CASE WHEN scoreEquip1 < scoreEquip2 THEN 1 ELSE 0 END) AS ganados,
        COUNT(1) AS total,
        equipoSeleccion2 AS equipo,
        arbitra.idArbitroArb AS arbitro 
    FROM tanteador
    JOIN partido 
    ON tanteador.idPartido = partido.idPartido
    AND nroCuarto = 4
    JOIN arbitra
    ON arbitra.idPartidoArb = partido.idPartido
    WHERE equipoSeleccion2 = equipo1
    GROUP BY equipoSeleccion2, arbitra.idArbitroArb
) AS resultadosEquipo1
ON 
resultadosEquipo1.arbitro = arbitro.idArbitro
LEFT JOIN 
(
    SELECT 
        SUM(CASE WHEN scOReEquip1 > scOReEquip2 THEN 1 ELSE 0 END) AS ganados,
        COUNT(1) AS total,
        equipoSelecciON1 AS equipo,
        arbitra.idArbitroArb AS arbitro
    FROM tanteador
    JOIN partido 
    ON tanteador.idPartido = partido.idPartido
    AND nroCuarto = 4
    JOIN arbitra
    ON arbitra.idPartidoArb = partido.idPartido
    WHERE equipoSelecciON1 = equipo2
    GROUP BY equipoSelecciON1, arbitra.idArbitroArb
    UNION
    SELECT 
        SUM(CASE WHEN scOReEquip1 < scOReEquip2 THEN 1 ELSE 0 END) AS ganados,
        COUNT(1) AS total,
        equipoSeleccion2 AS equipo,
        arbitra.idArbitroArb AS arbitro
    FROM tanteador
    JOIN partido 
    ON tanteador.idPartido = partido.idPartido
    AND nroCuarto = 4
    JOIN arbitra
    ON arbitra.idPartidoArb = partido.idPartido
    WHERE equipoSeleccion2 = equipo2
    GROUP BY equipoSeleccion2, arbitra.idArbitroArb
) AS resultadosEquipo2
ON resultadosEquipo2.arbitro = arbitro.idArbitro
WHERE 
-- chequeo la primer condicion (que si a ambos los dirigio mas de dos partidos, que no hayan ganado ni perdidos todos, 
-- es decir que al menos hayan ganado 1 y que no hayan ganado todos los jugados
(
  (
  arbitro.idArbitro =
      CASE WHEN resultadosEquipo1.arbitro IS NOT NULL THEN
        CASE WHEN resultadosEquipo1.total >= 2 THEN
          CASE WHEN (resultadosEquipo1.ganados < resultadosEquipo1.total) AND (resultadosEquipo1.ganados > 0) then
            arbitro.idArbitro
          ELSE
            -1
          END
        ELSE
          arbitro.idArbitro
        END
      ELSE
        arbitro.idArbitro
      END
  )
  AND
  (
  arbitro.idArbitro =
      CASE WHEN resultadosEquipo2.arbitro IS NOT NULL THEN
        CASE WHEN resultadosEquipo2.total >= 2 THEN
          CASE WHEN (resultadosEquipo2.ganados < resultadosEquipo2.total) AND (resultadosEquipo2.ganados > 0) then
            arbitro.idArbitro
          ELSE
            -1
          END
        ELSE
          arbitro.idArbitro
        END
      ELSE
        arbitro.idArbitro
      END
  )
)
-- chequeo la segunda condicion (si ambos jugaron 1 solo partido con dicho arbitro tienen que tener resultados iguales)
AND
(
  arbitro.idArbitro = (
    CASE WHEN resultadosEquipo2.arbitro IS NOT NULL AND resultadosEquipo1.arbitro IS NOT NULL THEN
      CASE WHEN resultadosEquipo2.total = 1 AND resultadosEquipo1.total = 1 THEN
        CASE WHEN resultadosEquipo2.ganados = resultadosEquipo1.ganados THEN
          arbitro.idArbitro			
        ELSE
          -1
        END
      ELSE
        arbitro.idArbitro
      END
    ELSE
      arbitro.idArbitro
    END
  )
)
-- chequeo la condicion 3 (si el arbitro esta asignado en la misma fecha)
AND NOT EXISTS (
  SELECT * FROM partido 
  JOIN arbitra
  ON arbitra.idPartidoArb = partido.idPartido
  WHERE arbitra.idArbitroArb = arbitro.idArbitro
  AND partido.fecha = fechaSP
)
GROUP BY arbitro.idArbitro, arbitro.nombreArbitro;
END&&

delimiter ;

