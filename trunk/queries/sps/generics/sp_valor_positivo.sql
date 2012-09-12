
delimiter &&

DROP PROCEDURE IF EXISTS sp_valor_positivo &&

CREATE PROCEDURE sp_valor_positivo (valor INT, caller VARCHAR(50), propiedad varchar(50))
BEGIN
    IF (valor <= 0) THEN
		CALL `La propiedad debe menor que 0`;
    END IF;
END&&

delimiter ;
