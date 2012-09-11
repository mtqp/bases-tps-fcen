
delimiter &&

DROP PROCEDURE IF EXISTS logOk &&

CREATE PROCEDURE logOk (caller VARCHAR(50), msg VARCHAR(100))
BEGIN
    INSERT INTO LOG(nombre, msg)
    VALUES
    (
        caller,
        msg
    );
END&&

delimiter ;
