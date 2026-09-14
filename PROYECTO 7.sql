CREATE DATABASE Trabajo_7

use Trabajo_7

create table Jugadores (
 ID_Jugador INT Not null,
 Nombre VARCHAR(50) Not null,
 Apellido VARCHAR(100) Not null,
 Edad INT,
 Altura FLOAT,
 Poaicion VARCHAR(50),
 
CONSTRAINT pk_Jugador
  PRIMARY KEY (id_Jugador),
CONSTRAINT chk_Jugador_Edad
  CHECK (Edad IS NULL OR Edad >= 0),
CONSTRAINT chk_Jugador_Altura
  CHECK (Altura IS NULL OR Altura > 0)
);

CREATE TABLE Categorias (
 id_Categoria INT Not null,
 Nombre VARCHAR(100) NOT NULL,
 Edad_min INT,
 Edad_max INT,
 Nivel VARCHAR(50),
CONSTRAINT pk_Categoria
 PRIMARY KEY (id_Categoria),
CONSTRAINT chk_Categoria_Edades
 CHECK (
  Edad_min IS NULL
  OR Edad_max IS NULL
  OR Edad_min <= Edad_max
        )
);

CREATE TABLE habilidad (
 id_habilidad INT Not null,
 nombre VARCHAR(100) NOT NULL,
CONSTRAINT pk_habilidad
 PRIMARY KEY (id_habilidad),
CONSTRAINT uq_habilidad_nombre
 UNIQUE (nombre)
);

CREATE TABLE Entrenamiento (
 id_Entrenamiento INT Not null,
 Fecha DATE Not null,
 Duracion TIME,
 Tipo VARCHAR(100),
 Intensidad VARCHAR(50),
 CONSTRAINT pk_Entrenamiento
  PRIMARY KEY (id_Entrenamiento)
);
 
CREATE TABLE Entrenador (
 id_Entrenador INT Not null,
 Nombre VARCHAR(50)Not null,
 Apellido VARCHAR(100)Not null,
 Edad INT,
 CONSTRAINT pk_Entrenador
  PRIMARY KEY (id_Entrenador),
 CONSTRAINT chk_Entrenador_Edad
  CHECK (Edad IS NULL OR Edad >= 18)
 );
 
CREATE TABLE Historial (
 id_Historial INT Not null,
 Rendimiento VARCHAR(100),
 Observacion VARCHAR(255),
 Fecha DATE NOT NULL,
 id_Jugador INT NOT NULL,
 CONSTRAINT pk_Historial
  PRIMARY KEY (id_Historial),
 CONSTRAINT fk_historial_jugador
  FOREIGN KEY (id_Jugador)
  REFERENCES Jugadores (id_Jugador)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE Prueba (
 id_Prueba INT NOT NULL,
 Fecha DATE NOT NULL,
 Tipo VARCHAR(100) NOT NULL,
 Duracion TIME,
 id_Jugador INT NOT NULL,
 CONSTRAINT pk_Prueba
  PRIMARY KEY (id_Prueba),
 CONSTRAINT fk_Prueba_Jugador
  FOREIGN KEY (id_Jugador)
  REFERENCES Jugadores (id_Jugador)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE Prueba_Habilidad (
 id_Prueba INT NOT NULL,
 id_Habilidad INT NOT NULL,
 CONSTRAINT pk_Prueba_Habilidad
  PRIMARY KEY (id_Prueba, id_Habilidad),
 CONSTRAINT fk_Prueba_Habilidad_Prueba
  FOREIGN KEY (id_Prueba)
  REFERENCES Prueba (id_Prueba)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
 CONSTRAINT fk_Prueba_Habilidad_Habilidad
  FOREIGN KEY (id_Habilidad)
  REFERENCES Habilidad (id_Habilidad)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE Evaluacion (
 id_Evaluacion INT NOT NULL,
 Puntaje FLOAT NOT NULL,
 Resultado FLOAT,
 id_Prueba INT NOT NULL,
 id_Categoria INT NOT NULL,
 CONSTRAINT pk_Evaluacion
  PRIMARY KEY (id_Evaluacion),
 CONSTRAINT fk_Evaluacion_Prueba
  FOREIGN KEY (id_Prueba)
  REFERENCES Prueba (id_Prueba)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  
 CONSTRAINT fk_Evaluacion_Categoria
  FOREIGN KEY (id_Categoria)
  REFERENCES Categorias (id_Categoria)
  ON UPDATE CASCADE
  ON DELETE CASCADE
  
);

CREATE TABLE Jugador_Entrenamiento (
 id_Jugador INT NOT NULL,
 id_Entrenamiento INT NOT NULL,
 CONSTRAINT pk_Jugador_Entrenamiento
  PRIMARY KEY (id_Jugador, id_Entrenamiento),
 CONSTRAINT fk_Jugador_Entrenamiento_Jugador
  FOREIGN KEY (id_Jugador)
  REFERENCES Jugadores (id_Jugador)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
 CONSTRAINT fk_Jugador_Entrenamiento_Entrenamiento
  FOREIGN KEY (id_Entrenamiento)
  REFERENCES Entrenamiento (id_Entrenamiento)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE Categoria_Entrenador (
 id_Categoria INT NOT NULL,
 id_Entrenador INT NOT NULL,
 CONSTRAINT pk_Categoria_Entrenador
  PRIMARY KEY (id_Categoria, id_Entrenador),
 CONSTRAINT fk_Categoria_Entrenador_Categoria
  FOREIGN KEY (id_Categoria)
  REFERENCES Categorias (id_Categoria)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
 CONSTRAINT fk_Categoria_Entrenador_Entrenador
  FOREIGN KEY (id_Entrenador)
  REFERENCES Entrenador (id_Entrenador)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);
 
