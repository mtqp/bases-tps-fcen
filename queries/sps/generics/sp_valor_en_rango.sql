
delimiter &&

DROP PROCEDURE IF EXISTS sp_valor_en_rango &&

CREATE PROCEDURE sp_valor_en_rango(valor INT, cotaInferior INT, cotaSuperior INT, caller VARCHAR(50), propiedad varchar(50))
BEGIN
    IF (cotaInferior < valor OR cotaSuperior > valor ) THEN
		CALL CONCAT('La propiedad ', propiedad, 'no esta en rango');
    END IF;
END&&

delimiter ;
