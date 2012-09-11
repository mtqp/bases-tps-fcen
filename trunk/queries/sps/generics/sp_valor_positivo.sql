
delimiter &&

CREATE PROCEDURE sp_valor_positivo (valor INT, caller VARCHAR(50), propiedad varchar(50))
BEGIN
    IF (valor <= 0) THEN
        CALL logError(caller, CONCAT(propiedad, '-', 'debe ser mayor que 0') );
		CALL CONCAT('La propiedad ', propiedad, 'debe ser mayor que 0');
    END IF;
END&&

delimiter ;
