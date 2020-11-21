USE viveros;
DELIMITER //

CREATE TRIGGER trigger_actualizar_stock AFTER INSERT ON PEDIDO FOR EACH ROW
BEGIN
    UPDATE PRODUCTO, PEDIDO SET PRODUCTO.STOCK = PRODUCTO.STOCK - NEW.CANTIDAD
    WHERE PRODUCTO.COD_BARRAS = NEW.ID_PRODUCTO;
END //

DELIMITER ;