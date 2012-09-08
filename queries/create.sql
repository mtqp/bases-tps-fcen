-- DDL --

USE db_tp1;

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

-- seleccion --
-- FK = { (hospedaHospedaje), (representaPais), (concentraEstadio), (ubicaPosicion) }
ALTER TABLE seleccion ADD CONSTRAINT fkSeleccionHospedaje FOREIGN KEY(hospedaHospedaje)   REFERENCES lugarhospedaje(idHospedaje);
ALTER TABLE seleccion ADD CONSTRAINT fkSeleccionPais      FOREIGN KEY(representaPais)     REFERENCES pais(idPais);
ALTER TABLE seleccion ADD CONSTRAINT fkSeleccionEstadio   FOREIGN KEY(concentraEstadio)   REFERENCES estadio(idEStadio);
ALTER TABLE seleccion ADD CONSTRAINT fkSeleccionPosicion  FOREIGN KEY(ubicaPosicion)      REFERENCES posiciones(idPosicion);

-- integrante --
-- FK = { (perteneceSeleccion) }
ALTER TABLE integrante ADD CONSTRAINT fkIntegranteSeleccion FOREIGN KEY(perteneceSeleccion) REFERENCES seleccion(idSeleccion);

-- jugador --
-- FK = { (estaEnEquipo) }
ALTER TABLE jugador ADD CONSTRAINT fkJugadorEquipo FOREIGN KEY(estaEnEquipo) REFERENCES equipo(idEquipo);

-- cuerpotecnico --
-- FK = { (cumpleFuncion) }
ALTER TABLE cuerpotecnico ADD CONSTRAINT fkTecnicoFuncion FOREIGN KEY(cumpleFuncion) REFERENCES funcion(idFuncion);

-- partido --
-- FK = { (juegaEnEtapa), (equipoSeleccion1), (equipoSeleccion2), (juegaEnEstadio) };
ALTER TABLE partido ADD CONSTRAINT fkPartidoEtapa       FOREIGN KEY(juegaEnEtapa)     REFERENCES etapa(idEtapa);
ALTER TABLE partido ADD CONSTRAINT fkPartidoSeleccion1  FOREIGN KEY(equipoSeleccion1) REFERENCES seleccion(idSeleccion);
ALTER TABLE partido ADD CONSTRAINT fkPartidoSeleccion2  FOREIGN KEY(equipoSeleccion2) REFERENCES seleccion(idSeleccion);
ALTER TABLE partido ADD CONSTRAINT fkPartidoEstadio     FOREIGN KEY(juegaEnEstadio)   REFERENCES estadio(idEstadio);

-- tanteador --
-- FK = { (idPartido) }
ALTER TABLE tanteador ADD CONSTRAINT fkTanteadorPartido FOREIGN KEY(idPartido) REFERENCES partido(idPartido);

-- arbitro --
-- FK = { (pertenecePais) }
ALTER TABLE arbitro ADD CONSTRAINT fkArbitroPais    FOREIGN KEY(pertenecePais) REFERENCES pais(idPais);

-- arbitra --
-- FK = { (idArbitroArb), (idPartidoArb) }
ALTER TABLE arbitra ADD CONSTRAINT fkArbitraArbitro FOREIGN KEY(idArbitroArb) REFERENCES arbitro(idArbitro);
ALTER TABLE arbitra ADD CONSTRAINT fkArbitraPartido FOREIGN KEY(idPartidoArb) REFERENCES partido(idPartido);

-- participacion --
-- FK = { (juegoPartido), (participaJugador) }
ALTER TABLE participacion ADD CONSTRAINT fkParticipacionPartido FOREIGN KEY(jugoPartido)     REFERENCES partido(idPartido);
ALTER TABLE participacion ADD CONSTRAINT fkParticipacionJugador FOREIGN KEY(participaJugador) REFERENCES jugador(idJugador);

-- sancion --
-- FK = { (aplicaParticipacion) , (sancionadaPorArbitro), (esDeTipo)};
ALTER TABLE sancion ADD CONSTRAINT fkSancionParticipacion   FOREIGN KEY(aplicaParticipacion)  REFERENCES participacion(idParticipacion);
ALTER TABLE sancion ADD CONSTRAINT fkSancionArbitro         FOREIGN KEY(sancionadaPorArbitro) REFERENCES arbitro(idArbitro);
ALTER TABLE sancion ADD CONSTRAINT fkSancionTipo            FOREIGN KEY(esDeTipo)             REFERENCES tiposancion(idTipoSancion);

