CREATE DATABASE cursos_db;
USE cursos_db;

CREATE TABLE carreras (
  id_carrera INT(11) NOT NULL AUTO_INCREMENT,
  nombre_carrera VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_carrera),
  UNIQUE KEY nombre_carrera (nombre_carrera)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE cursos (
  id_curso INT(11) NOT NULL AUTO_INCREMENT,
  id_carrera INT(11) NOT NULL,
  codigo_curso VARCHAR(20) NOT NULL,
  nombre_curso VARCHAR(150) NOT NULL,
  descripcion TEXT DEFAULT NULL,
  espacio VARCHAR(100) DEFAULT NULL,
  total_horas INT(11) DEFAULT NULL,
  dias_atencion VARCHAR(100) DEFAULT NULL,
  horario VARCHAR(50) DEFAULT NULL,
  cupo INT(11) NOT NULL,
  url_imagen_principal VARCHAR(150) DEFAULT NULL,
  PRIMARY KEY (id_curso),
  UNIQUE KEY codigo_curso (codigo_curso),
  KEY fk_cursos_carreras (id_carrera),
  CONSTRAINT fk_cursos_carreras FOREIGN KEY (id_carrera) REFERENCES carreras (id_carrera) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE imagenes_curso (
  id_imagen INT(11) NOT NULL AUTO_INCREMENT,
  id_curso INT(11) NOT NULL,
  url_imagen VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_imagen),
  KEY fk_imagenes_cursos (id_curso),
  CONSTRAINT fk_imagenes_cursos FOREIGN KEY (id_curso) REFERENCES cursos (id_curso) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE alumnos (
  id_alumno INT(11) NOT NULL AUTO_INCREMENT,
  matricula VARCHAR(20) NOT NULL,
  nombre_alumno VARCHAR(150) NOT NULL,
  grado INT(11) NOT NULL,
  grupo VARCHAR(5) NOT NULL,
  correo VARCHAR(150) NOT NULL,
  PRIMARY KEY (id_alumno),
  UNIQUE KEY matricula (matricula)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE inscripciones (
  id_inscripcion INT(11) NOT NULL AUTO_INCREMENT,
  id_curso INT(11) NOT NULL,
  matricula VARCHAR(20) NOT NULL,
  fecha_registro DATE NOT NULL,
  PRIMARY KEY (id_inscripcion),
  UNIQUE KEY curso_alumno (id_curso,matricula),
  KEY fk_inscripciones_cursos (id_curso),
  KEY fk_inscripciones_alumnos (matricula),
  CONSTRAINT fk_inscripciones_cursos FOREIGN KEY (id_curso) REFERENCES cursos (id_curso) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_inscripciones_alumnos FOREIGN KEY (matricula) REFERENCES alumnos (matricula) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar Registros
INSERT INTO carreras(id_carrera,nombre_carrera) VALUES
(1,'Ingeniería en Sistemas'),
(2,'Arquitectura'),
(3,'Ingeniería Civil'),
(4,'Contaduría'),
(5,'Gastronomía');

INSERT INTO cursos(id_curso,id_carrera,codigo_curso,nombre_curso,descripcion,espacio,total_horas,dias_atencion,horario,cupo,url_imagen_principal) VALUES
(1,1,'IS102','Programación Avanzada','Estructuras de datos, recursividad, manejo de archivos y buenas prácticas de programación orientada a objetos.','Edificio C, Salón C-101',80,'Lunes, Miércoles, Viernes','10:00 - 12:00 hrs',50,'upload/cursos/principales/programacion.png'),
(2,1,'IS201','Bases de Datos II','Diseño avanzado de bases de datos, normalización, procedimientos almacenados y transacciones.','Edificio C, Laboratorio C-102',60,'Martes, Jueves','08:00 - 10:00 hrs',50,'upload/cursos/principales/bases_datos.png'),
(3,1,'IS301','Inteligencia Artificial','Introducción al aprendizaje automático, redes neuronales y procesamiento de datos.','Edificio C, Salón C-201',60,'Lunes, Miércoles, Viernes','14:00 - 16:00 hrs',40,'upload/cursos/principales/ia.png'),
(4,1,'IS202','Redes de Computadoras','Modelo OSI, direccionamiento IP, subredes y configuración de redes locales.','Edificio C, Laboratorio C-202',60,'Martes, Jueves','12:00 - 14:00 hrs',50,'upload/cursos/principales/redes.png');

INSERT INTO imagenes_curso(id_imagen,id_curso,url_imagen) VALUES
(1,1,'upload/cursos/galeria/programacion1.png'),
(2,1,'upload/cursos/galeria/programacion2.png'),
(3,2,'upload/cursos/galeria/bases_datos1.png'),
(4,2,'upload/cursos/galeria/bases_datos2.png'),
(5,3,'upload/cursos/galeria/ia1.png'),
(6,3,'upload/cursos/galeria/ia2.png'),
(7,4,'upload/cursos/galeria/redes1.png'),
(8,4,'upload/cursos/galeria/redes2.png');

INSERT INTO alumnos(id_alumno,matricula,nombre_alumno,grado,grupo,correo) VALUES
(1,'20240001','Ana López Martínez',4,'A','20240001@uthh.edu.mx'),
(2,'20240002','Carlos Hernández Cruz',4,'A','20240002@uthh.edu.mx'),
(3,'20240003','María Fernanda Reyes',4,'B','20240003@uthh.edu.mx'),
(4,'20240004','José Luis Bautista',4,'B','20240004@uthh.edu.mx'),
(5,'20240005','Daniela Torres Ramírez',4,'C','20240005@uthh.edu.mx'),
(6,'20240006','Miguel Ángel Santiago',4,'C','20240006@uthh.edu.mx'),
(7,'20240007','Laura Martínez Flores',2,'A','20240007@uthh.edu.mx'),
(8,'20240008','Jorge Ramírez Pérez',2,'A','20240008@uthh.edu.mx'),
(9,'20240009','Valeria Cruz Hernández',2,'B','20240009@uthh.edu.mx'),
(10,'20240010','Ricardo Gómez Díaz',6,'A','20240010@uthh.edu.mx'),
(11,'20240011','Sofía Morales Castillo',6,'A','20240011@uthh.edu.mx'),
(12,'20240012','Fernando Ortiz Vargas',6,'B','20240012@uthh.edu.mx');

INSERT INTO inscripciones(id_inscripcion,id_curso,matricula,fecha_registro) VALUES
(1,1,'20240001','2026-10-20'),
(2,1,'20240002','2026-10-20'),
(3,1,'20240003','2026-10-21'),
(4,1,'20240004','2026-10-21'),
(5,1,'20240005','2026-10-22'),
(6,2,'20240006','2026-10-20'),
(7,2,'20240007','2026-10-21'),
(8,2,'20240001','2026-10-22'),
(9,3,'20240008','2026-10-21'),
(10,3,'20240009','2026-10-22'),
(11,3,'20240010','2026-10-22'),
(12,4,'20240011','2026-10-22'),
(13,4,'20240012','2026-10-22');
