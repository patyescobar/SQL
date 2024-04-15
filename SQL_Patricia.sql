-- Creación del esquema
CREATE SCHEMA IF NOT EXISTS evaluacionAlkemyIntegradora;
USE evaluacionAlkemyIntegradora;

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL, -- Mejorando seguridad con mayor longitud
    saldo DECIMAL(10,2) DEFAULT 0
);

-- Tabla de Monedas
CREATE TABLE IF NOT EXISTS Moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(50),
    currency_symbol VARCHAR(5)
);

-- Tabla de Transacciones
CREATE TABLE IF NOT EXISTS Transaccion (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    importe DECIMAL(10,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id)
);

-- Inserción de valores en Usuario (agregando comprobación de existencia)
INSERT INTO Usuario (nombre, correo_electronico, contrasena, saldo) VALUES
('Juan Pérez', 'juan@example.com', 'hashContrasena', 100000),
('María García', 'maria@example.com', 'hashContrasena', 75000),
('Luis Martínez', 'luis@example.com', 'hashContrasena', 150000),
('Ana Rodríguez', 'ana@example.com', 'hashContrasena', 200000),
('Carlos Sánchez', 'carlos@example.com', 'hashContrasena', 50000),
('Laura López', 'laura@example.com', 'hashContrasena', 80000),
('Pedro González', 'pedro@example.com', 'hashContrasena', 120000),
('Sofía Díaz', 'sofia@example.com', 'hashContrasena', 30000),
('Pablo Fernández', 'pablo@example.com', 'hashContrasena', 90000),
('Carmen Ruiz', 'carmen@example.com', 'hashContrasena', 60000),
('Javier Gómez', 'javier@example.com', 'hashContrasena', 110000),
('Elena Vázquez', 'elena@example.com', 'hashContrasena', 85000)
ON DUPLICATE KEY UPDATE saldo = VALUES(saldo);

-- Inserción de valores en Transaccion
INSERT INTO Transaccion (sender_user_id, receiver_user_id, importe) VALUES
(1, 2, 5000),
(3, 1, 10000),
(2, 3, 2500),
(4, 1, 20000),
(2, 5, 7550),
(6, 4, 3025),
(7, 2, 8000),
(3, 6, 4050),
(5, 7, 6075),
(8, 1, 9025),
(4, 9, 12000),
(10, 2, 4500);

-- Actualización de saldos usando transacciones
START TRANSACTION;
-- De María García a Juan Pérez
UPDATE Usuario SET saldo = saldo - 5000 WHERE user_id = 2;
UPDATE Usuario SET saldo = saldo + 5000 WHERE user_id = 1;
-- De Luis Martínez a Ana Rodríguez
UPDATE Usuario SET saldo = saldo - 7500 WHERE user_id = 3;
UPDATE Usuario SET saldo = saldo + 7500 WHERE user_id = 4;
-- De Ana Rodríguez a Carlos Sánchez
UPDATE Usuario SET saldo = saldo - 6000 WHERE user_id = 4;
UPDATE Usuario SET saldo = saldo + 6000 WHERE user_id = 5;
-- De Carlos Sánchez a Laura López
UPDATE Usuario SET saldo = saldo - 5500 WHERE user_id = 5;
UPDATE Usuario SET saldo = saldo + 5500 WHERE user_id = 6;
COMMIT;

-- Consultas
SELECT DISTINCT nombre FROM Usuario;
SELECT * FROM Usuario ORDER BY user_id ASC;
SELECT * FROM Usuario ORDER BY user_id DESC;
SELECT * FROM Transaccion WHERE sender_user_id = 3 OR receiver_user_id = 3;
SELECT * FROM Transaccion JOIN Usuario ON Transaccion.sender_user_id = Usuario.user_id;
