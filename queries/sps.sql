-- Script de Stored Procedures --

CREATE PROCEDURE sp_paises_todos_titulares
BEGIN
SELECT DISTINCT(nombrePais) Pais
FROM
(
	-- cuento todos los jugadores por pais que fueron titulares correspondientes a la primer seleccion
	SELECT COUNT (DISTINCT(participaJugador)) jugadores, seleccion1.representaPais representaPais
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
	WHERE esTitular = 1
	GROUP BY seleccion1.representaPais
	UNION 
	-- cuento todos los jugadores por pais que fueron titulares correspondientes a la segunda seleccion
	SELECT COUNT (DISTINCT(participaJugador)) jugadores, seleccion2.representaPais representaPais
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
	WHERE esTitular = 1
	GROUP BY seleccion2.representaPais
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
ON idJugadoresPais = idPais
END;


CREATE PROCEDURE sp_estadisticas_por_jugador
BEGIN
-- proyecto los campos pedidos
SELECT apellido Apellido, nombreIntegrante Nombre, cantidadPartidos Partidos, 
promedioPuntos [Promedio Puntos], promedioAsistencias [Promedio Asistencias], promedioRebotes [Promedio Rebotes]
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
ORDER BY cantidadPartidos
END;


declare  @idPartido int
declare  @equipo1   int
declare  @equipo2   int
 
select @equipo1 = equipoSeleccion1, @equipo2 = equipoSeleccion2 from partido where idPartido = @idPartido
set @idPartido = 4

	select equipoSeleccion1 equipo, idArbitro arbitro, count(1) partidos  from arbitro
	join arbitra 
	on idArbitroArb = idArbitro
	join partido
	on idPartido = idPartidoArb
	join tanteador
	on tanteador.idPartido = partido.idPartido
	and nroCuarto = 4 -- el ultimo 4 tiene el resultado del partido
	-- es el equipo que quiero y gano
	where equipoSeleccion1 = @equipo1 and scoreEquip1 > scoreEquip2
	group by idArbitro, equipoSeleccion1
	-- que haya ganado mas de 1 partido
	having count(1) >= 2
	
--and equipoSeleccion2 in (@equipo1, @equipo2)

