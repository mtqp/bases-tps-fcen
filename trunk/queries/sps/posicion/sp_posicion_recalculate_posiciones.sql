
delimiter &&

DROP PROCEDURE IF EXISTS sp_posicion_recalculate_posiciones &&

CREATE PROCEDURE sp_posicion_recalculate_posiciones (idPartidoSP INT, scoreEquipSP1, scoreEquipoSP2 INT)
BEGIN
    DECLARE posEquip1 INT;
    DECLARE posEquip2 INT;
   
    SET posEquip1 = ( SELECT ubicaPosicion 
                        FROM seleccion 
                        JOIN partido
                            ON idSeleccion = equipoSeleccion1
                        WHERE
                            idPartido = idPartidoSP );

    SET posEquip2 = ( SELECT ubicaPosicion 
                        FROM seleccion 
                        JOIN partido
                            ON idSeleccion = equipoSeleccion2
                        WHERE
                            idPartido = idPartidoSP );

    IF (scoreEquipSP1 > scoreEquipSP2)
    THEN
        -- ------------- --
        -- Gano equipo 1 --
        -- ------------- --
        UPDATE posicion
        SET
              puntos = puntos + 1
            , partidosJugados = partidosJugados + 1
            , partidosGanados = partidosGanados + 1
            --partidosPerdidos += 0
            , tantosAFavor = tantosAFavor + scoreEquip1
            , tantosEnContra = tantosEnContra + scoreEquipSP2
        WHERE
            idPosicion = posEquip1;

        UPDATE posicion
        SET
            -- puntos += 0
              partidosJugados = partidosJugados + 1
            -- partidosGanados += 0
            , partidosPerdidos = partidosPerdidos + 1
            , tantosAFavor = tantosAFavor + scoreEquipSP2
            , tantosEnContra = tantosEnContra + scoreEquipSP1
        WHERE
            idPosicion = posEquip2;

    ELSE
        -- ------------- --
        -- Gano equipo 2 --
        -- ------------- --
        UPDATE posicion
        SET
              puntos = puntos + 1
            , partidosJugados = partidosJugados + 1
            , partidosGanados = partidosGanados + 1
            -- , partidosPerdidos += 0
            , tantosAFavor = tantosAFavor + scoreEquipSP2
            , tantosEnContra = tantosEnContra + scoreEquipSP1
        WHERE
            idPosicion = posEquip2;

        UPDATE posicion
        SET
            -- puntos += 0
              partidosJugados = partidosJugados + 1
             -- partidosGanados += 0
            , partidosPerdidos = partidosPerdidos + 1
            , tantosAFavor = tantosAFavor + scoreEquipSP1
            , tantosEnContra = tantosEnContra + scoreEquipSP2
        WHERE
            idPosicion = posEquip1;
    
    END IF;

        
END&&

delimiter ;

