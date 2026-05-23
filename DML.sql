-- ============================================================
-- SIGEU - Sistema de Reservas de Espacios Universitarios
-- DML - Data Manipulation Language
-- Motor: PostgreSQL / Supabase
-- Schema: SIGEU
-- ============================================================

-- Tabla: USER_TYPE
INSERT INTO SIGEU.USER_TYPE (usertype_id, name) VALUES
    ('AD', 'ADMINISTRADOR'),
    ('DO', 'DOCENTE'),
    ('ES', 'ESTUDIANTE'),
    ('GU', 'INVITADO'),
    ('SV', 'SERVICIO');

-- Tabla: LOCATION
INSERT INTO SIGEU.LOCATION (location_id, name) VALUES
    ('L1', 'PRINCIPAL'),
    ('L2', 'PRIMAVERA');

-- Tabla: BUILDING
INSERT INTO SIGEU.BUILDING (building_id, name, location_id) VALUES
    ('E1', 'CIDIA',           'L1'),
    ('E2', 'BIBLIOTECA',      'L1'),
    ('E4', 'BLOQUE A',        'L1'),
    ('E5', 'EDIFICIO BUNKER', 'L1');

-- Tabla: SPACE_TYPE
INSERT INTO SIGEU.SPACE_TYPE (space_type_id, name) VALUES
    ('AU', 'AULA'),
    ('LA', 'LABORATORIO'),
    ('SA', 'SALA'),
    ('MR', 'SALA REUNION'),
    ('AP', 'AUDITORIO');

-- Tabla: USER
INSERT INTO SIGEU.USER (code, name1, name2, last_name1, last_name2, email, cellphone, usertype_id) VALUES
    ('0192231', 'Andrea', 'Camila', 'Carrascal', 'Ovallos',    'accarrascalo@ufpso.edu.co', '3167980503', 'ES'),
    ('0192345', 'Jose',   'Camilo', 'Hernandez', 'Contreras',  'jchernandezc@ufpso.edu.co', '3187632450', 'ES'),
    ('0185001', 'Carlos', NULL,     'Mendoza',   NULL,         'cmendoza@ufpso.edu.co',     '3001234567', 'DO'),
    ('0185002', 'Ana',    'Maria',  'Torres',    'Ruiz',       'amtorres@ufpso.edu.co',     '3154455667', 'AD'),
    ('0185003', 'Julio',  NULL,     'Vargas',    'Perez',      'jvargas@ufpso.edu.co',      '3007788990', 'DO');

-- Tabla: SPACE
INSERT INTO SIGEU.SPACE (space_id, name, capacity, space_type_id, building_id) VALUES
    ('S1', 'A101', 30, 'AU', 'E1'),
    ('S2', 'B107', 40, 'AU', 'E2'),
    ('S3', 'LAB1', 25, 'LA', 'E1'),
    ('S4', 'A101', 30, 'SA', 'E4'),
    ('S5', 'B107', 40, 'SA', 'E5');

-- Tabla: RESERVATION
INSERT INTO SIGEU.RESERVATION (reservation_number, date, code) VALUES
    ('R1', '2025-03-10 00:00:00', '0192231'),
    ('R2', '2025-03-11 00:00:00', '0192345'),
    ('R3', '2025-03-12 00:00:00', '0185001'),
    ('R4', '2025-03-13 00:00:00', '0185003'),
    ('R5', '2025-03-14 00:00:00', '0192231');

-- Tabla: RESERVATION_DETAIL
INSERT INTO SIGEU.RESERVATION_DETAIL (line_number, start_time, end_time, status, reservation_number, space_id) VALUES
    (1, '2025-03-10 08:00:00', '2025-03-10 10:00:00', 'A', 'R1', 'S1'),
    (2, '2025-03-11 10:00:00', '2025-03-11 12:00:00', 'A', 'R2', 'S2'),
    (3, '2025-03-12 14:00:00', '2025-03-12 16:00:00', 'C', 'R3', 'S3'),
    (4, '2025-03-13 07:00:00', '2025-03-13 09:00:00', 'A', 'R4', 'S4'),
    (5, '2025-03-14 11:00:00', '2025-03-14 13:00:00', 'P', 'R5', 'S5');
