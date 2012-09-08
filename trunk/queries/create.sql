-- DDL --

-- Creacion de tablas --

CREATE TABLE seleccion
(
      idSeleccion       INT NOT NULL AUTO_INCREMENT
    , hospedaHospedaje  INT NOT NULL
    , representaPais    INT NOT NULL
    , concentraEstadio  INT NOT NULL
    , ubicaPosicion     INT NOT NULL
    , cantIntegrantes   INT NOT NULL
    , fechaArribo       INT NOT NULL
    , grupo             CHAR(1) NOT NULL
    , PRIMARY KEY (idSeleccion)
);

CREATE TABLE posiciones
(
      idPosicion    INT NOT NULL AUTO_INCREMENT
    , puntos        INT NOT NULL
    , PRIMARY KEY (idPosicion)
);

CREATE TABLE lugarhospedaje
(   
      idHospedaje       INT NOT NULL AUTO_INCREMENT
    , nombreHospedaje   VARCHAR(50)
    , PRIMARY KEY (idHospedaje)
);

CREATE TABLE pais
(
      idPais        INT NOT NULL AUTO_INCREMENT
    , nombrePais    VARCHAR(50)
    , PRIMARY KEY (idPais)
);

CREATE TABLE integrante
(
      idIntegrante          INT NOT NULL AUTO_INCREMENT
    , perteneceSeleccion    INT NOT NULL
    , nroPasaporte          INT NOT NULL
    , nombreIntegrante      VARCHAR(50)
    , apellido              VARCHAR(50) 
    , edad                  INT NOT NULL
    , fechaNacimiento       DATE NOT NULL
    , tipoIntegrante        VARCHAR(15) NOT NULL
    , PRIMARY KEY (idIntegrante)
);

CREATE TABLE jugador
(
      idJugador    INT NOT NULL AUTO_INCREMENT
    , estaEnEquipo INT NOT NULL
    , PRIMARY KEY (idJugador)
);

CREATE TABLE cuerpotecnico
(
      idCuerpoTecnico   INT NOT NULL AUTO_INCREMENT
    , cumpleFuncion     INT NOT NULL
    , PRIMARY KEY (idCuerpoTecnico)
);

CREATE TABLE funcion
(
      idFuncion     INT NOT NULL AUTO_INCREMENT
    , nombreFuncion VARCHAR(50)
    , PRIMARY KEY (idFuncion)
);

CREATE TABLE equipo
(
      idEquipo      INT NOT NULL AUTO_INCREMENT
    , nombreEquipo  VARCHAR(50)
    , PRIMARY KEY (idEquipo)
);

CREATE TABLE partido
(
      idPartido         INT NOT NULL AUTO_INCREMENT
    , juegaEnEtapa      INT NOT NULL
    , equipoSeleccion1  INT NOT NULL
    , equipoSeleccion2  INT NOT NULL
    , juegaEnEstadio    INT NOT NULL
    , duracion          INT 
    , fecha             DATE NOT NULL
    , horario           INT  
    , PRIMARY KEY (idPartido)
);

CREATE TABLE estadio
(
      idEstadio     INT NOT NULL AUTO_INCREMENT
    , nombreEstadio VARCHAR(50)
    , PRIMARY KEY (idEstadio)
);

CREATE TABLE etapa
(
      idEtapa       INT NOT NULL AUTO_INCREMENT
    , nombreEtapa   VARCHAR(50)
    , PRIMARY KEY (idEtapa)
);

CREATE TABLE tanteador
(
      nroCuarto     INT NOT NULL
    , idPartido     INT NOT NULL
    , scoreEquip1   INT NOT NULL
    , scoreEquip2   INT NOT NULL
    , PRIMARY KEY (nroCuarto, idPartido)
);

CREATE TABLE arbitro
(
      idArbitro     INT NOT NULL AUTO_INCREMENT
    , pertenecePais INT NOT NULL
    , nombreArbitro VARCHAR(50)
    , PRIMARY KEY (idArbitro)
);

CREATE TABLE arbitra
(
      idArbitroArb  INT NOT NULL
    , idPartidoArb  INT NOT NULL
    , PRIMARY KEY (idArbitroArb, idPartidoArb)
);

CREATE TABLE participacion
(
      idParticipacion   INT NOT NULL AUTO_INCREMENT
    , jugoPartido       INT NOT NULL
    , participaJugador  INT NOT NULL
    , asistencias       INT DEFAULT 0
    , rebotes           INT DEFAULT 0
    , posicion          VARCHAR(10)
    , puntos            INT DEFAULT 0
    , esTitular         BIT NOT NULL
    , PRIMARY KEY (idParticipacion)
);

CREATE TABLE sancion
(
      idSancion             INT NOT NULL AUTO_INCREMENT
    , aplicaParticipacion   INT NOT NULL
    , sancionadaPorArbitro  INT NOT NULL
    , esDeTipo              INT NOT NULL
    , PRIMARY KEY (idSancion)
);

CREATE TABLE tiposancion
(
      idTipoSancion INT NOT NULL AUTO_INCREMENT
    , nombreSancion VARCHAR(50)
    , PRIMARY KEY (idTipoSancion)
);

-- Creacion de foreign keys --

