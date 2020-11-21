USE catastro;
DELIMITER //

CREATE TRIGGER trigger_insert_persona_vive_en_una_unica_vivienda BEFORE INSERT ON PERSONA FOR EACH ROW
BEGIN
    IF NEW.PISO_CALLE IS NOT NULL and NEW.VIVIENDA_CALLE IS NOT NULL  THEN
        signal sqlstate '45000' set message_text = 'No puede tener dos domicilios';
    END IF;

END //

CREATE TRIGGER trigger_update_persona_vive_en_una_unica_vivienda BEFORE UPDATE ON PERSONA FOR EACH ROW
BEGIN
    IF NEW.PISO_CALLE IS NOT NULL and NEW.VIVIENDA_CALLE IS NOT NULL  THEN
        signal sqlstate '45000' set message_text = 'No puede tener dos domicilios';
    END IF;


END //

