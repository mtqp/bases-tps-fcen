
delimiter &&

DROP PROCEDURE IF EXISTS sp_valor_en_rango &&

CREATE PROCEDURE sp_valor_en_rango(valor INT, cotaInferior INT, cotaSuperior INT, caller VARCHAR(50), propiedad varchar(50))
BEGIN
    IF (valor < cotaInferior OR valor > cotaSuperior ) THEN
		CALL `propiedad no esta en rango`;
    END IF;
END&&

delimiter ;
