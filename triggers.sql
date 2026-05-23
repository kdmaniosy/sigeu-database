-- ============================================================
-- SIGEU - Sistema de Reservas de Espacios Universitarios
-- TRIGGERS - Funciones y disparadores
-- Motor: PostgreSQL / Supabase
-- Schema: SIGEU
-- ============================================================

-- ------------------------------------------------------------
-- Trigger 1: Validar solapamiento de horarios
-- Evita que un mismo espacio tenga dos reservas activas
-- que se solapen en el mismo horario.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION sigeu.fn_validar_solapamiento()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM sigeu.reservation_detail
        WHERE space_id = NEW.space_id
          AND status = 'A'
          AND (NEW.start_time, NEW.end_time) OVERLAPS (start_time, end_time)
    ) THEN
        RAISE EXCEPTION 'El espacio ya tiene una reserva activa en ese horario.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_solapamiento
BEFORE INSERT ON sigeu.reservation_detail
FOR EACH ROW EXECUTE FUNCTION sigeu.fn_validar_solapamiento();


-- ------------------------------------------------------------
-- Trigger 2: Asignar fecha automática a la reserva
-- Si no se especifica fecha al insertar, asigna la fecha actual.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION sigeu.fn_fecha_reserva()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date IS NULL THEN
        NEW.date := CURRENT_DATE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fecha_reserva
BEFORE INSERT ON sigeu.reservation
FOR EACH ROW EXECUTE FUNCTION sigeu.fn_fecha_reserva();


-- ------------------------------------------------------------
-- Trigger 3: Cancelación en cascada de detalles
-- Al cancelar una reserva, cancela automáticamente
-- todos sus detalles asociados.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION sigeu.fn_cancelar_detalles()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'C' AND OLD.status != 'C' THEN
        UPDATE sigeu.reservation_detail
        SET status = 'C'
        WHERE reservation_number = NEW.reservation_number;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_cancelar_detalles
AFTER UPDATE ON sigeu.reservation
FOR EACH ROW EXECUTE FUNCTION sigeu.fn_cancelar_detalles();
