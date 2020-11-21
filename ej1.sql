USE viveros;

DELIMITER //

CREATE PROCEDURE crear_email(IN nombre VARCHAR(45), IN dominio VARCHAR(45), OUT email VARCHAR(45))
BEGIN
    DECLARE Nomb VARCHAR(45);
    DECLARE EmailAux VARCHAR(45);
    SET @Nomb = SUBSTRING(nombre, 1, 3);
    SET @EmailAux = CONCAT(@Nomb, '@', dominio);
    SET email = @EmailAux;
END //

CREATE TRIGGER trigger_crear_email_before_insert BEFORE INSERT ON CLIENTE FOR EACH ROW
BEGIN
    IF NEW.email IS NULL THEN

        CALL crear_email(NEW.NOMBRE, 'mejorvivero.com', @emailAux);
        set NEW.email = @emailAux;
    END IF;
END //

DELIMITER ;