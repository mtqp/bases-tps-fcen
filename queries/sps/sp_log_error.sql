
delimiter &&

DROP PROCEDURE IF EXISTS logError &&

CREATE PROCEDURE logError (caller VARCHAR(50), msg VARCHAR(100))
BEGIN
    INSERT INTO LOG(nombre, msg)
    VALUES
    (
        caller,
        msg
    );
    
    CALL `[ERROR!] Ver LOG para mas detalles`;
END&&

delimiter ;
