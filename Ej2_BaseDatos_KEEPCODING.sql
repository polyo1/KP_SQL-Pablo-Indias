DROP TABLE IF EXISTS contacto_alumnos;
DROP TABLE IF EXISTS facturacion;
DROP TABLE IF EXISTS carac_bootcamp;
DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS bootcamp;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS profesores;

-- Crear tabla profesores
CREATE TABLE profesores (
  profesor_id SERIAL PRIMARY KEY,
  nombre varchar NOT NULL,
  apellido1 varchar NOT NULL,
  apellido2 varchar NOT NULL,
  direccion varchar NOT NULL,
  telefono varchar NOT NULL
);

COMMENT ON TABLE profesores IS 'En esta tabla se almacenan los datos de los profesores';

-- Crear tabla cursos
CREATE TABLE cursos (
  curso_id SERIAL PRIMARY KEY,
  videos text,
  tema text
);

COMMENT ON TABLE cursos IS 'En esta tabla se almacenan todos los cursos disponibles en la plataforma';

-- Crear tabla bootcamp
CREATE TABLE bootcamp (
  bootcamp_id SERIAL PRIMARY KEY,
  nombre text,
  edicion integer,
  fecha_inicio date,
  fecha_fin date,
  curso_id integer,
  FOREIGN KEY (curso_id) REFERENCES cursos(curso_id)
);

COMMENT ON TABLE bootcamp IS 'En esta tabla se registran los bootcamp disponibles';

-- Crear tabla alumnos
CREATE TABLE alumnos (
  alumno_id SERIAL PRIMARY KEY,
  nombre text NOT NULL,
  apellido1 text NOT NULL,
  apellido2 text NOT NULL,
  dni text NOT NULL,
  bootcamp_id integer NOT NULL,
  FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id)
);

COMMENT ON TABLE alumnos IS 'En esta tabla se recopila la información de los alumnos, así como el bootcamp o bootcamp a los que están inscritos.';

-- Crear tabla carac_bootcamp
CREATE TABLE carac_bootcamp (
  carac_id SERIAL PRIMARY KEY,
  bootcamp_id integer NOT NULL,
  precio integer NOT NULL,
  profesor_id integer NOT NULL,
  FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id),
  FOREIGN KEY (profesor_id) REFERENCES profesores(profesor_id)
);

COMMENT ON TABLE carac_bootcamp IS 'En esta tabla se guardan las características de cada uno de los bootcamp';

-- Crear tabla facturacion
CREATE TABLE facturacion (
  factura_id SERIAL PRIMARY KEY,
  alumno_id integer NOT NULL,
  pagos_alumnos integer NOT NULL,
  gastos integer NOT NULL,
  FOREIGN KEY (alumno_id) REFERENCES alumnos(alumno_id)
);

COMMENT ON TABLE facturacion IS 'En esta tabla se almacenan los datos de facturacion';

-- Crear tabla contacto_alumnos
CREATE TABLE contacto_alumnos (
  alumno_id integer PRIMARY KEY REFERENCES alumnos(alumno_id),
  direccion text NOT NULL,
  telefono text NOT NULL
);

COMMENT ON TABLE contacto_alumnos IS 'Esta tabla almacena los datos de contacto de los alumnos. Creando esta tabla no es necesario que el alumno rellene de nuevo estos datos si se apunta a un nuevo bootcamp';

-- Insertar datos en profesores
INSERT INTO profesores (nombre, apellido1, apellido2, direccion, telefono) VALUES
('Javier', 'Fernández', 'Ruiz', 'Calle Mayor 1, Madrid', '612345678'),
('Ana', 'García', 'Pérez', 'Calle del Sol 5, Barcelona', '623456789');

-- Insertar datos en cursos
INSERT INTO cursos (videos, tema) VALUES
('https://video1.com,https://video2.com', 'Desarrollo Web'),
('https://video3.com,https://video4.com', 'Machine Learning');

-- Insertar datos en bootcamp
INSERT INTO bootcamp (edicion, nombre, fecha_inicio, fecha_fin, curso_id) VALUES
(1, 'BigData', '2024-01-10', '2024-04-10', 1),
(2, 'Web', '2024-05-15', '2024-08-15', 2);

-- Insertar datos en alumnos
INSERT INTO alumnos (nombre, apellido1, apellido2, dni, bootcamp_id) VALUES
('Juan', 'Pérez', 'García', '12345678A', 1),
('María', 'López', 'Martínez', '87654321B', 2),
('Carlos', 'Rodríguez', 'Sánchez', '45678912C', 1);

-- Insertar datos en carac_bootcamp
INSERT INTO carac_bootcamp (bootcamp_id, precio, profesor_id) VALUES
(1, 1500, 1),
(2, 1800, 2);

-- Insertar datos en facturacion
INSERT INTO facturacion (alumno_id, pagos_alumnos, gastos) VALUES
(1, 1500, 300),
(2, 1800, 400),
(3, 1500, 300);

-- Insertar datos en contacto_alumnos
INSERT INTO contacto_alumnos (alumno_id, direccion, telefono) VALUES
(1, 'Calle Falsa 123, Madrid', '611223344'),
(2, 'Avenida Siempreviva 742, Barcelona', '622334455'),
(3, 'Plaza del Sol 4, Valencia', '633445566');

--Obtener una lista de los alumnos con el nombre del bootcamp en el que están inscritos.

SELECT alumnos.nombre AS Nombre_Alumno,
       alumnos.apellido1 AS Primer_Apellido,
       alumnos.apellido2 AS Segundo_Apellido,
       bootcamp.edicion AS Edicion_Bootcamp,
       cursos.tema AS Tema_Curso
FROM alumnos
JOIN bootcamp 
  ON alumnos.bootcamp_id = bootcamp.bootcamp_id
JOIN cursos 
  ON bootcamp.curso_id = cursos.curso_id;

--Mostrar los pagos y los gastos de cada alumno, junto con su nombre completo.

SELECT alumnos.nombre AS Nombre_Alumno,
       alumnos.apellido1 AS Primer_Apellido,
       alumnos.apellido2 AS Segundo_Apellido,
       facturacion.pagos_alumnos AS Pagos,
       facturacion.gastos AS Gastos
FROM facturacion
JOIN alumnos 
  ON facturacion.alumno_id = alumnos.alumno_id;
		
		