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
	WHERE esTitular = 1
	GROUP BY seleccion1.representaPais
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
ORDER BY cantidadPartidos;
END&&

delimiter ;

-- declare  @idPartido int
-- declare  @equipo1   int
-- declare  @equipo2   int
 
-- select @equipo1 = equipoSeleccion1, @equipo2 = equipoSeleccion2 from partido where idPartido = @idPartido
-- set @idPartido = 4

-- Dirigió a alguno de los equipos 2 o más veces, y en todos los partidos el
-- equipo obtuvo el mismo resultado (ganó o perdió, no hay empate)

	-- select * 
	-- from arbitro
	-- join arbitra 
	-- on idArbitroArb = idArbitro
	-- join partido
	-- on idPartido = idPartidoArb
	-- and
	-- (
	--	select * from tanteador
	--	where tanteador.idPartido = partido.idPartido
	--	and nroCuarto = 4 -- el ultimo cuarto tiene el resultado del partido
		
	-- )


	-- select equipoSeleccion1 equipo, idArbitro arbitro 
	-- from arbitro
	-- join arbitra 
	-- on idArbitroArb = idArbitro
	-- join partido
	-- on idPartido = idPartidoArb
	-- join tanteador
	-- on tanteador.idPartido = partido.idPartido
	-- and nroCuarto = 4 -- el ultimo cuarto tiene el resultado del partido
	-- -- es el equipo que quiero
	-- where (equipoSeleccion1 = @equipo1 or equipoSeleccion1 = @equipo2)
	-- group by idArbitro, equipoSeleccion1
	-- -- donde lo haya dirigido en mas de 1 partido count(1) equivale a la cantidad de partidos ya que hay 1 registro por partido
	-- having (count(1) >= 2 and
	-- -- que perdio todos o gano todos
	-- (count(case when scoreEquip1 > scoreEquip2 then 1 else 0 end) = 0 or count(case when scoreEquip1 > scoreEquip2 then 1 else 0 end) = count(1)))
	-- union 
	-- select equipoSeleccion2 equipo, idArbitro arbitro 
	-- from arbitro
	-- join arbitra 
	-- on idArbitroArb = idArbitro
	-- join partido
	-- on idPartido = idPartidoArb
	-- join tanteador
	-- on tanteador.idPartido = partido.idPartido
	-- and nroCuarto = 4 -- el ultimo cuarto tiene el resultado del partido
	-- -- es el equipo que quiero
	-- where (equipoSeleccion2 = @equipo1 or equipoSeleccion2 = @equipo2)
	-- group by idArbitro, equipoSeleccion2
	-- -- donde lo haya dirigido en mas de 1 partido count(1) equivale a la cantidad de partidos ya que hay 1 registro por partido
	-- having (count(1) >= 2 and
	-- -- que perdio todos o gano todos
	-- (count(case when scoreEquip2 > scoreEquip1 then 1 else 0 end) = 0 or count(case when scoreEquip2 > scoreEquip1 then 1 else 0 end) = count(1)))
	
	-- -- idem para la otra relacion con seleccion
	-- select equipoSeleccion2 equipo, idArbitro arbitro  from arbitro
	-- join arbitra 
	-- on idArbitroArb = idArbitro
	-- join partido
	-- on idPartido = idPartidoArb
	-- join tanteador
	-- on tanteador.idPartido = partido.idPartido
	-- and nroCuarto = 4 -- el ultimo cuarto tiene el resultado del partido
	-- -- es el equipo que quiero
	-- where (equipoSeleccion2 = @equipo1 or equipoSeleccion2 = @equipo2)
	-- group by idArbitro, equipoSeleccion2
	-- -- donde lo haya dirigido en mas de 1 partido count(1) equivale a la cantidad de partidos ya que hay 1 registro por partido
	-- having (count(1) >= 2 and
	-- -- que perdio todos o gano todos
	-- (count(case when scoreEquip1 > scoreEquip2 then 1 else 0 end) > 0 and count(case when scoreEquip1 > scoreEquip2 then 1 else 0 end) < count(1)))

	-- select * from arbitro
	-- join arbitra
	-- on idArbitroArb = idArbitro




