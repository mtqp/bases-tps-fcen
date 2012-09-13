
DELIMITER &&

DROP PROCEDURE IF EXISTS partidosDeFase &&

CREATE PROCEDURE partidosDeFase(fase INT)
BEGIN
	
	IF (fase > 0) THEN
		SELECT partido.idPartido, p1.nombrePais as pais1, p2.nombrePais as pais2, etapa.nombreEtapa as etapa, tanteador.scoreEquip1 as puntaje1, tanteador.scoreEquip2 as puntaje2 
		FROM partido, seleccion s1, seleccion s2, pais p1, pais p2, etapa, tanteador 
		WHERE s1.idSeleccion = equipoSeleccion1 AND
		 	  s2.idSeleccion = equipoSeleccion2 AND
		 	  s1.representaPais = p1.idPais AND
		 	  s2.representaPais = p2.idPais AND
		 	  partido.juegaEnEtapa = etapa.idEtapa AND
			  partido.juegaEnEtapa = fase AND
			  tanteador.idPartido = partido.IdPartido
			  ORDER BY idPartido;
	ELSE
		SELECT partido.idPartido, p1.nombrePais as pais1, p2.nombrePais as pais2, etapa.nombreEtapa as etapa, tanteador.scoreEquip1 as puntaje1, tanteador.scoreEquip2 as puntaje2 
		FROM partido, seleccion s1, seleccion s2, pais p1, pais p2, etapa 
		WHERE s1.idSeleccion = equipoSeleccion1 AND
		 	  s2.idSeleccion = equipoSeleccion2 AND
		 	  s1.representaPais = p1.idPais AND
		 	  s2.representaPais = p2.idPais AND
		 	  partido.juegaEnEtapa = etapa.idEtapa
		 	  tanteador.idPartido = partido.IdPartido
		 	  ORDER BY idPartido;
	END IF;
	

END&&

DELIMITER ;

