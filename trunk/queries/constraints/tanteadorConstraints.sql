-- ACA VAN TODAS LAS CONSTRAINTS DE SELECCION
-- select "Acá van las constraints de tanteador" from DUAL;

DELIMITER $$

DROP TRIGGER IF EXISTS check_maximo_cuatro_cuartos $$

CREATE TRIGGER check_maximo_cuatro_cuartos
BEFORE INSERT ON tanteador
FOR EACH ROW BEGIN
  -- Un árbitro en un partido no puede ser de un pais que sea el mismo país que alguno de los equipos.
  DECLARE totalCuartos INT;
  DECLARE cuartoRepetido INT;
  SET totalCuartos = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido);
  IF (totalCuartos >= 4)  THEN
    CALL `el total de cuartos no puede ser superior a 4`;
  END IF;
  
  SET cuartoRepetido = (SELECT count(1) FROM tanteador WHERE idPartido = NEW.idPartido and nroCuarto = NEW.nroCuarto);
  IF (cuartoRepetido = 1)  THEN
    CALL `el cuarto correspondiente ya fue ingresado`;
  END IF;
  
END$$
DELIMITER ;