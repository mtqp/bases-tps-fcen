
delimiter &&

CREATE PROCEDURE logError (caller VARCHAR(50), msg VARCHAR(100))
BEGIN
    INSERT INTO LOG(nombre, msg)
    VALUES
    (
        caller,
        msg
    );
END&&

delimiter ;
