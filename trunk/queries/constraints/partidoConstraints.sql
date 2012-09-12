-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
Select "Acá van las constraints de partido" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_partido $$

CREATE TRIGGER check_partido
BEFORE INSERT ON partido
FOR EACH ROW BEGIN

      CALL sp_partido_distintas_selecciones(NEW.equipoSeleccion1, NEW.equipoSeleccion2);

      CALL sp_valor_positivo (NEW.duracion, 'partido', 'duracion');

      CALL sp_valor_en_rango (NEW.horario, 0, 23, 'partido', 'horario');
        
      CALL sp_partido_mismo_equipos_misma_etapa (NEW.equipoSeleccion1, NEW.equipoSeleccion2, NEW.juegaEnEtapa);
    
      CALL sp_partido_cantidad_por_fase (NEW.juegaEnEtapa);

      CALL sp_partido_fase_anterior_completa (NEW.juegaEnEtapa); --  (SI ESTO NO VA ORDENADO CON EL DE ABAJO, SE ROMPE TODO)

      CALL sp_partido_ordenados_por_fecha (NEW.juegaEnEtapa, NEW.fecha, NEW.horario);

      CALL sp_partido_mismo_grupo_fase_grupo (NEW.juegaEnEtapa, NEW.equipoSeleccion1, NEW.equipoSeleccion2);
 
      CALL sp_partido_mismo_horario (NEW.horario, NEW.fecha);
    
    CALL logOk('insert', CONCAT('ok insert partido con id: ', 'dsp concatenar el id partido'));-- (NEW.idPartido AS CHAR)));

END$$
DELIMITER ;





