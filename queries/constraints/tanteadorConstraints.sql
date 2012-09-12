-- ACA VAN TODAS LAS CONSTRAINTS DE tanteador

select "creando constraints de tanteador" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_tanteador_bi $$

CREATE TRIGGER check_tanteador_bi
BEFORE INSERT ON tanteador
FOR EACH ROW BEGIN
    DECLARE totalCuartos INT;
    DECLARE cuartoRepetido INT;
    -- Los valores posibles de TANTEADOR.nroCuatro son = {1 ,2 , 3, 4}
    CALL sp_valor_en_rango (NEW.nroCuarto, 1, 4, 'tanteador', 'nroCuarto');

    -- TANTEADOR.scoreEquip1 >= 0
    CALL sp_valor_positivo (NEW.scoreEquip1, 'tanteador', 'scoreEquip1');

    -- TANTEADOR.scoreEquip2 >= 0
    CALL sp_valor_positivo (NEW.scoreEquip2, 'tanteador', 'scoreEquip2');

    -- Si TANTEADOR.nroCuarto = 4 => TANTEADOR.scoreEquip1 <> TANTEADOR.scoreEquip2 (no hay empates)
    IF ((NEW.nroCuarto = 4) AND (NEW.scoreEquip1 = NEW.scoreEquip2)) THEN
        CALL `un partido no puede terminar con el tanteador empatado`;
    END IF;

    -- TANTEADOR.nroCuarto no puede aparecer más de 4 veces por TANTEADOR.idPartido (el tanteador se genera con los 4 cuartos cuando se genera un partido)
    SET totalCuartos = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido);
    IF (totalCuartos > 4)  THEN
        CALL `el total de cuartos no puede ser superior a 4`;
    END IF;

    SET cuartoRepetido = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido AND nroCuarto = NEW.nroCuarto);
    IF (cuartoRepetido = 1)  THEN
        CALL `el cuarto correspondiente ya fue ingresado`;
    END IF; 

    CALL logOk('insert tanteador','insert tanteador exitoso');
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS check_tanteador_bu $$

CREATE TRIGGER check_tanteador_bu
BEFORE UPDATE ON tanteador
FOR EACH ROW BEGIN
    DECLARE totalCuartos INT;
    DECLARE cuartoRepetido INT;
    -- Los valores posibles de TANTEADOR.nroCuatro son = {1 ,2 , 3, 4}
    CALL sp_valor_en_rango (NEW.nroCuarto, 1, 4, 'tanteador', 'nroCuarto');

    -- TANTEADOR.scoreEquip1 >= 0
    CALL sp_valor_positivo (NEW.scoreEquip1, 'tanteador', 'scoreEquip1');

    -- TANTEADOR.scoreEquip2 >= 0
    CALL sp_valor_positivo (NEW.scoreEquip2, 'tanteador', 'scoreEquip2');

    -- Si TANTEADOR.nroCuarto = 4 => TANTEADOR.scoreEquip1 <> TANTEADOR.scoreEquip2 (no hay empates)
    IF ((NEW.nroCuarto = 4) AND (NEW.scoreEquip1 = NEW.scoreEquip2)) THEN
        CALL `un partido no puede terminar con el tanteador empatado`;
    END IF;

    -- TANTEADOR.nroCuarto no puede aparecer más de 4 veces por TANTEADOR.idPartido (el tanteador se genera con los 4 cuartos cuando se genera un partido)
    SET totalCuartos = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido);
    IF (totalCuartos > 4)  THEN
        CALL `el total de cuartos no puede ser superior a 4`;
    END IF;

    SET cuartoRepetido = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido AND nroCuarto = NEW.nroCuarto);
    IF (cuartoRepetido = 1)  THEN
        CALL `el cuarto correspondiente ya fue ingresado`;
    END IF; 

    CALL logOk('update tanteador','update tanteador exitoso');  
END$$

DELIMITER ;
