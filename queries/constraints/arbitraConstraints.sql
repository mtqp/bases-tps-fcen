-- ACA VAN TODAS LAS CONSTRAINTS DE ARBITRA

select "creando constraints de arbitra" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_arbitra_bi $$

CREATE TRIGGER check_arbitra_bi
BEFORE INSERT ON arbitra
FOR EACH ROW BEGIN
    -- Un árbitro en un partido no puede ser de un pais que sea el mismo país que alguno de los equipos.
    DECLARE idPaisArbitro INT;
    DECLARE idPaisEquipo1 INT;
    DECLARE idPaisEquipo2 INT;

    SET idPaisArbitro = ( SELECT idPais 
                        FROM arbitro 
                        JOIN pais 
                            ON pertenecePais = idPais 
                        WHERE idArbitro = NEW.idArbitroArb );
				       
    SET idPaisEquipo1 = ( SELECT idPais 
                        FROM partido 
                        JOIN seleccion S 
                            ON equipoSeleccion1 = idSeleccion 
                        JOIN pais 
                            ON representaPais = idPais 
                        WHERE idPartido = NEW.idPartidoArb );

    SET idPaisEquipo2 = ( SELECT idPais 
                        FROM partido 
                        JOIN seleccion S 
                            ON equipoSeleccion2 = idSeleccion 
                        JOIN pais 
                            ON representaPais = idPais 
                        WHERE idPartido = NEW.idPartidoArb);

    IF (idPaisArbitro = idPaisEquipo1 OR  idPaisArbitro = idPaisEquipo2)  THEN
        CALL `El arbitro no puede ser del mismo pais que alguno de los equipos`;
    END IF;

    CALL logOk('insert arbitra', 'insert arbitra exitoso');

END$$

DROP TRIGGER IF EXISTS check_arbitra_bu $$

CREATE TRIGGER check_arbitra_bu
BEFORE UPDATE ON arbitra
FOR EACH ROW BEGIN
    -- Un árbitro en un partido no puede ser de un pais que sea el mismo país que alguno de los equipos.
    DECLARE idPaisArbitro INT;
    DECLARE idPaisEquipo1 INT;
    DECLARE idPaisEquipo2 INT;

    SET idPaisArbitro = ( SELECT idPais 
                        FROM arbitro 
                        JOIN pais 
                            ON pertenecePais = idPais 
                        WHERE idArbitro = NEW.idArbitroArb );
				       
    SET idPaisEquipo1 = ( SELECT idPais 
                        FROM partido 
                        JOIN seleccion S 
                            ON equipoSeleccion1 = idSeleccion 
                        JOIN pais 
                            ON representaPais = idPais 
                        WHERE idPartido = NEW.idPartidoArb );

    SET idPaisEquipo2 = ( SELECT idPais 
                        FROM partido 
                        JOIN seleccion S 
                            ON equipoSeleccion2 = idSeleccion 
                        JOIN pais 
                            ON representaPais = idPais 
                        WHERE idPartido = NEW.idPartidoArb);

    IF (idPaisArbitro = idPaisEquipo1 OR  idPaisArbitro = idPaisEquipo2)  THEN
        CALL `El arbitro no puede ser del mismo pais que alguno de los equipos`;
    END IF;

    CALL logOk('update arbitra', 'update arbitra exitoso');

END$$

DELIMITER ;
