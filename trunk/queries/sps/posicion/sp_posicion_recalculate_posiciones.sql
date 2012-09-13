
delimiter &&

DROP PROCEDURE IF EXISTS sp_posicion_recalculate_posiciones &&

CREATE PROCEDURE sp_posicion_recalculate_posiciones (idPartidoSP INT, scoreEquipSP1 INT, scoreEquipSP2 INT)
BEGIN
    DECLARE posEquip1 INT;
    DECLARE posEquip2 INT;
    DECLARE puntajeGanador INT;
    DECLARE nombreEtapa VARCHAR(50);
    
    SET nombreEtapa = ( SELECT nombreEtapa 
                        FROM etapa
                        JOIN partido
                            ON idEtapa = juegaEnEtapa
                        WHERE
                            idPartido = @idPartidoSP );
     
    IF (nombreEtapa = 'FASE_GRUPOS') THEN
        SET puntajeGanador = 1;    
    ELSE
        IF (nombreEtapa = '5T0_PUESTO') THEN
            SET puntajeGanador = 3;
        ELSE
            IF (nombreEtapa = '3ER_PUESTO') THEN
                SET puntajeGanador = 7;
            ELSE
                IF (nombreEtapa = 'SEMIFINAL') THEN
                    SET puntajeGanador = 11;
                ELSE
                    -- ES LA FINAL
                    SET puntajeGanador = 19;
                END IF;
            END IF;
        END IF;
    END IF;
  
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
        call `gano el puto equipo 1`;
        UPDATE posicion
        SET
              puntos = puntos + @puntajeGanador
            , partidosJugados = partidosJugados + 1
            , partidosGanados = partidosGanados + 1
            -- partidosPerdidos += 0
            , tantosAFavor = tantosAFavor + @scoreEquip1
            , tantosEnContra = tantosEnContra + @scoreEquipSP2
        WHERE
            idPosicion = posEquip1;

        UPDATE posicion
        SET
            -- puntos += 0
              partidosJugados = partidosJugados + 1
            -- partidosGanados += 0
            , partidosPerdidos  = partidosPerdidos + 1
            , tantosAFavor      = tantosAFavor   + @scoreEquipSP2
            , tantosEnContra    = tantosEnContra + @scoreEquipSP1
        WHERE
            idPosicion = posEquip2;

    ELSE
        -- ------------- --
        -- Gano equipo 2 --
        -- ------------- --
        call `gano el forro de los del equipo 2`;
        UPDATE posicion
        SET
              puntos = puntos + @puntajeGanador
            , partidosJugados = partidosJugados + 1
            , partidosGanados = partidosGanados + 1
            -- , partidosPerdidos += 0
            , tantosAFavor   = tantosAFavor   + @scoreEquipSP2
            , tantosEnContra = tantosEnContra + @scoreEquipSP1
        WHERE
            idPosicion = posEquip2;

        UPDATE posicion
        SET
             -- puntos += 0
              partidosJugados = partidosJugados + 1
             -- partidosGanados += 0
            , partidosPerdidos = partidosPerdidos + 1
            , tantosAFavor   = tantosAFavor   + @scoreEquipSP1
            , tantosEnContra = tantosEnContra + @scoreEquipSP2
        WHERE
            idPosicion = posEquip1;
    
    END IF;

        
END&&

delimiter ;

