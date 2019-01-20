/* Cw 17 DELETE CASCADE*/
CREATE DATABASE bldg;
USE bldg;

CREATE TABLE buildings (
building_no INT PRIMARY KEY AUTO_INCREMENT,
building_name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL
);

CREATE TABLE rooms (
room_no INT PRIMARY KEY AUTO_INCREMENT,
room_name VARCHAR(255) NOT NULL,
building_no INT NOT NULL,
FOREIGN KEY (building_no)
REFERENCES buildings (building_no)
ON DELETE CASCADE
);

INSERT INTO buildings(building_name,address)
VALUES
('Tower 1', 'Warsaw'),
('Tower 2', 'Poznan'),
('Tower 1', 'Cracow');

INSERT INTO rooms(room_name,building_no)
VALUES
('room 1',1),
('room 2',1),
('room 3',1),
('room 4',1),
('room 5',1);

INSERT INTO rooms(room_name,building_no)
VALUES
('room 1',2),
('room 2',2),
('room 3',2),
('room 4',2),
('room 5',2);

SELECT * FROM rooms;

DELETE FROM buildings WHERE building_name='Tower 1';