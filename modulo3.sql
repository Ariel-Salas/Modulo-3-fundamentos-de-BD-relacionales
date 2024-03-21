create database wa;
use wa;

CREATE TABLE Usuario (
    user_id INT PRIMARY KEY auto_increment,
    nombre VARCHAR(100),
    correo_electronico VARCHAR(100),
    contrasena VARCHAR(100),
    saldo DECIMAL(10, 2)
);



CREATE TABLE Transaccion (
    transaction_id INT PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    importe DECIMAL(10, 2),
    transaction_date DATE,
    currency_id INT,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);

CREATE TABLE Moneda (
    currency_id INT PRIMARY KEY,
    currency_name VARCHAR(100),
    currency_symbol VARCHAR(10)
);

CREATE TABLE Historial_Transacciones (
    transaction_id INT PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    importe DECIMAL(10, 2),
    transaction_date DATE,
    currency_id INT,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);


-- Insertar datos de ejemplo en la tabla Usuario
INSERT INTO Usuario (user_id, nombre, correo_electronico, contrasena, saldo) VALUES
(1, 'Juan', 'juan@example.com', 'contraseña123', 1000.00),
(2, 'María', 'maria@example.com', 'clave456', 2000.00),
(3, 'Pedro', 'pedro@example.com', 'secreto789', 1500.00);

-- Insertar datos de ejemplo en la tabla Moneda
INSERT INTO Moneda (currency_id, currency_name, currency_symbol) VALUES
(1, 'Dólar', '$'),
(2, 'Euro', '€'),
(3, 'Libra esterlina', '£');

-- Insertar datos de ejemplo en la tabla Transaccion
INSERT INTO Transaccion (transaction_id, sender_user_id, receiver_user_id, importe, transaction_date, currency_id) VALUES
(1, 1, 2, 500.00, '2024-03-10', 1),
(2, 2, 1, 300.00, '2024-03-09', 2),
(3, 1, 3, 200.00, '2024-03-08', 3);


-- Insertar datos de ejemplo en la tabla Historial_Transacciones
INSERT INTO Historial_Transacciones (transaction_id, sender_user_id, receiver_user_id, importe, transaction_date, currency_id) VALUES
(1, 1, 2, 500.00, '2024-03-10', 1),
(2, 2, 1, 300.00, '2024-03-09', 2),
(3, 1, 3, 200.00, '2024-03-08', 3);


-- Consulta para obtener el nombre de la moneda elegida por un usuario específico, moneda que a recibido y a enviado:
SELECT m.currency_name
FROM Usuario u
JOIN Transaccion t ON u.user_id = t.sender_user_id OR u.user_id = t.receiver_user_id
JOIN Moneda m ON t.currency_id = m.currency_id
WHERE u.user_id = 3;


-- igual a la de arriba borrar
SELECT m.currency_name
FROM Usuario u
JOIN Transaccion t ON u.user_id = t.sender_user_id OR u.user_id = t.receiver_user_id
JOIN Moneda m ON t.currency_id = m.currency_id
WHERE u.user_id = 3;


-- que moneda eligio el usuario solamante para el envio
SELECT m.currency_name
FROM Usuario u
JOIN Transaccion t ON u.user_id = t.sender_user_id 
JOIN Moneda m ON t.currency_id = m.currency_id
WHERE u.user_id = 3;


-- que moneda recibio el usuario para enviar
SELECT m.currency_name
FROM Usuario u
JOIN Transaccion t ON u.user_id = t.receiver_user_id 
JOIN Moneda m ON t.currency_id = m.currency_id
WHERE u.user_id = 3;


-- Consulta para obtener todas las transacciones registradas:
SELECT *
FROM Transaccion;


-- Consulta para obtener todas las transacciones realizadas por un usuario específico:
SELECT *
FROM Transaccion
WHERE sender_user_id = 3 OR receiver_user_id = 3;


-- Consulta para obtener todos los envios de dinero de un usuario especifico:

SELECT *
FROM Transaccion
WHERE sender_user_id = 1;


-- Consulta para obtener todos los recibos de dinero 

SELECT *
FROM Transaccion
WHERE receiver_user_id = 3;


-- Sentencia DML para modificar el campo correo electrónico de un usuario específico:

UPDATE Usuario
SET correo_electronico = 'nuevo_correo@example.com'
WHERE user_id = 1;


-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa):

DELETE FROM Transaccion
WHERE transaction_id = 2;