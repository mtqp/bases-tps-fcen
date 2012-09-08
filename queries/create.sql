-- DDL --

CREATE TABLE seleccion
(
      idSeleccion       INT NOT NULL
    , hospedaHospedaje  INT NOT NULL
    , representaPais    INT NOT NULL
    , concentraEstadio  INT NOT NULL
    , ubicaPosicion     INT NOT NULL
    , cantIntegrantes   INT NOT NULL
    , fechaArribo       INT NOT NULL
    , grupo             CHAR(1) NOT NULL
);


SELECCION(idSeleccion, hospedaHospedaje, representaPais, concentraEstadio, ubicaPosicion, cantIntegrantes, fechaArribo, grupo)

PK = { (idSeleccion) }
CC = { (idSeleccion) }
FK = { (hospedaHospedaje), (representaPais), (concentraEstadio), (ubicaPosicion) }

References:
SELECCION.hospedaHospedaje debe estar en LUGARHOSPEDAJE.idHospedaje
SELECCION.representaPais debe estar en PAIS.idPais
SELECCION.concentraEstadio debe estar en ESTADIO.idEstadio
SELECCION.ubicaPosicion debe estar en POSICIONES.idPosicion

Constraints:
SELECCION.hospedaHospedaje no puede ser nulo
SELECCION.representaPais no puede ser nulo
SELECCION.concentraEstado no puede ser nulo
SELECCION.ubicaPosicion no puede ser nulo

----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE posiciones
(
      idPosicion    INT NOT NULL
    , puntos        INT NOT NULL
);

POSICIONES(idPosicion, puntos)

PK = { (idPosicion) }
CC = { (idPosicion) }
FK = {}

Constraints:
POSICIONES.puntos >= 0

----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE lugarhospedaje
(   
      idHospedaje       INT NOT NULL
    , nombreHospedaje   VARCHAR(50)
);

LUGARHOSPEDAJE(idHospedaje, nombreHospedaje)

PK = { (idHospedaje) }
CC = { (idHospedaje) }
FK = {}

Constraints:
NONE
----------------------------------------------------------------------------------------------------------------------------
-- 4 --
CREATE TABLE pais
(
      idPais        INT NOT NULL
    , nombrePais    VARCHAR(50)
);

PAIS(idPais, nombrePais)

PK = { (idPais) }
CC = { (idPais) }
FK = {}

Constraints:
NONE

----------------------------------------------------------------------------------------------------------------------------
-- 5 --
CREATE TABLE integrante
(
      idIntegrante          INT NOT NULL
    , perteneceSeleccion    INT NOT NULL
    , nroPasaporte          INT NOT NULL
    , nombreIntegrante      VARCHAR(50)
    , apellido              VARCHAR(50) 
    , edad                  INT NOT NULL
    , fechaNacimiento       DATE NOT NULL
    , tipoIntegrante        VARCHAR(15) NOT NULL
);

INTEGRANTE(idIntegrante, perteneceSeleccion, nroPasaporte, nombreIntegrante, apellido, edad, fechaNacimiento,tipoIntegrante)

PK = { (idIntegrante) }
CC = { (idIntegrante), (nroPasaporte)}
FK = { (perteneceSeleccion) }

References:
INTEGRANTE.perteneceSeleccion debe estar en SELECCION.idSeleccion

Constraints:
INTEGRANTE.perteneceSeleccion no puede ser nulo
INTEGRANTE.edad = AÑO(SYSDATE) - AÑO(INTEGRANTE.fechaNacimiento)
INTEGRANTE.tipoIntegrante IN { ‘Jugador’, ‘CuerpoTecnico’ }
INTEGRANTE.edad >= 18

----------------------------------------------------------------------------------------------------------------------------
-- 6 --
CREATE TABLE jugador
(
      idIntegrante INT NOT NULL
    , estaEnEquipo INT NOT NULL
);

JUGADOR(idIntegrante, estaEnEquipo)

PK = { (idIntegrante) }
CC = { (idIntegrante) }
FK = { (estaEnEquipo) }

References:
JUGADOR.estaEnEquipo debe estar en  EQUIPO.idEquipo

Constraints:
JUGADOR. estaEnEquipo no puede ser nulo

----------------------------------------------------------------------------------------------------------------------------
-- 7 --
CREATE TABLE cuerpotecnico
(
      idIntegrante  INT NOT NULL
    , cumpleFuncion INT NOT NULL
);

CUERPO_TECNICO(idIntegrante, cumpleFuncion)

PK = { (idIntegrante) }
CC = { (idIntegrante) }
FK = { (cumpleFuncion) }

References:
CUERPO_TECNICO.cumpleFuncion debe estar en FUNCION.idFuncion

Constraints:
CUERPO_TECNICO.cumpleFuncion no puede ser nulo

----------------------------------------------------------------------------------------------------------------------------
-- 8 --
CREATE TABLE funcion
(
      idFuncion     INT NOT NULL
    , nombreFuncion VARCHAR(50)
);

FUNCION(idFuncion, nombreFuncion)

PK = { (idFuncion) }
CC = { (idFuncion) }
FK = {}

Constraints:
NONE

----------------------------------------------------------------------------------------------------------------------------
-- 9 --
CREATE TABLE equipo
(
      idEquipo      INT NOT NULL
    , nombreEquipo  VARCHAR(50)
);

EQUIPO(idEquipo, nombreEquipo)

PK = { (idEquipo) }
CC = { (idEquipo) }
FK = {}

Constraints:

----------------------------------------------------------------------------------------------------------------------------
-- 10 --
CREATE TABLE partido
(
      idPartido         INT NOT NULL
    , juegaEnEtapa      INT NOT NULL
    , equipoSeleccion1  INT NOT NULL
    , equipoSeleccion2  INT NOT NULL
    , juegaEnEstadio    INT NOT NULL
    , duracion          -- que onda va?
    , fecha             DATE NOT NULL
    , horario           DATE NOT NULL
);

PARTIDO(idPartido, juegaEnEtapa, equipoSeleccion1, equipoSeleccion2, juegaEnEstadio, duracion, fecha, horario)

PK = { (idPartido) }
CC = { (idPartido) }
FK = { (juegaEnEtapa), (equipoSeleccion1), (equipoSeleccion1), (juegaEnEstadio) }

References:
PARTIDO.juegaEnEtapa debe estar en ETAPA.idEtapa
PARTIDO.equipoSeleccion1 debe estar en EQUIPO.idEquipo
PARTIDO.equipoSeleccion2 debe estar en EQUIPO.idEquipo
PARTIDO.juegaEnEstadio debe estar en ESTADIO.idEstadio

Constraints:
PARTIDO.juegaEnEtapa no puede ser nulo
PARTIDO.equipoSeleccion1 no puede ser nulo
PARTIDO.equipoSeleccion2 no puede ser nulo
PARTIDO.juegaEnEstado no puede ser nulo
PARTIDO.equipoSeleccion1 <> PARTIDO.equipoSeleccion2

Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’ entonces 
PARTIDO.equipoSeleccion1.grupo = PARTIDO.equipoSeleccion2.grupo 

Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’ and PARTIDO.equipoSeleccion1.grupo = “A” ⇒ #PARTIDO <= 6

Si PARTIDO.juegaEnEtapa = ‘FASE_GRUPOS’’ and PARTIDO.equipoSeleccion1.grupo = “B” ⇒ #PARTIDO <= 6

Si PARTIDO.juegaEnEtapa = ‘5TO_PUESTO’ ⇒ #PARTIDO <= 1

Si PARTIDO.juegaEnEtapa = ‘3ER_PUESTO’ ⇒ #PARTIDO <= 1

Si PARTIDO.juegaEnEtapa = ‘SEMIFINAL’ ⇒ #PARTIDO <= 2

Si PARTIDO.juegaEnEtapa = ‘FINAL’ ⇒ #PARTIDO <= 1

----------------------------------------------------------------------------------------------------------------------------
-- 11 --
CREATE TABLE estadio
(
      idEstadio     INT NOT NULL
    , nombreEstadio VARCHAR(50)
);

ESTADIO(idEstadio, nombreEstadio)

PK = { (idEstadio) }
CC = { (idEstadio) }
FK = {}

Constraints:
NONE

----------------------------------------------------------------------------------------------------------------------------
-- 12 --

CREATE TABLE etapa
(
      idEtapa       INT NOT NULL
    , nombreEtapa
);

ETAPA(idEtapa, nombreEtapa)
PK = { (idEtapa) }
CC = { (idEtapa) }
FK = {}

Constraints:
ETAPA.nombreEtapa debe ser o bien FASE_GRUPOS o 5TO_PUESTO, o 3ER_PUESTO o SEMIFINAL, o FINAL

----------------------------------------------------------------------------------------------------------------------------
-- 13 --

CREATE TABLE tanteador
(
      nroCuarto     INT NOT NULL
    , idPartido     INT NOT NULL
    , scoreEquip1   INT NOT NULL
    , scoreEquip2   INT NOT NULL
);

TANTEADOR(nroCuarto, idPartido, scoreEquip1, scoreEquip2)
PK = { (nroCuatro, idPartido) }
CC = { (nroCuarto,idPartido) }
FK = { (idPartido) }

References:
TANTEADOR.idPartido debe estar en PARTIDO.idPartido

Constraints:
TANTEADOR.idPartido no puede ser nulo

TANTEADOR.nroCuarto no puede aparecer más de 4 veces por TANTEADOR.idPartido
Los valores posibles de TANTEADOR.nroCuatro son = {1 ,2 , 3, 4}

----------------------------------------------------------------------------------------------------------------------------
-- 14 --
CREATE TABLE arbitro
(
      idArbitro     INT NOT NULL
    , pertenecePais INT NOT NULL
    , nombreArbitro
);

ARBITRO (idArbitro, pertenecePais, nombreArbitro)
PK = { (idArbitro) }
CC = { (idArbitro) }
FK = { (pertenecePais) }

References:
ARBITRO.pertenecePais debe estar en PAIS.idPais

Constraints:
ARBITRO.pertenecePais no puede ser nulo
(ARBITRO.idArbitro = ARBITRA.idArbitroArb) and (ARBITRA.idPartidoArb = PARTIDO.idPartido) ⇒  ARBITRO.pertenecePais <> PARTIDO.seleccionEquipo1.representaPais and ARBITRO.pertenecePais <> PARTIDO.seleccionEquipo2.representaPais

----------------------------------------------------------------------------------------------------------------------------
-- 15 --
CREATE TABLE arbitra
(
      idArbitroArb  INT NOT NULL
    , idPartidoArb  INT NOT NULL
);

ARBITRA(idArbitroArb, idPartidoArb)
PK = { (idArbitroArb, idPartidoArb) }
CC = { (idArbitroArb, idPartidoArb) }
FK = { (idArbitroArb), (idPartidoArb) }

References:
ARBITRA.idArbitroArb debe estar en ARBITRO.idArbitro
ARBITRA.idPartidoArb debe estar en PARTIDO.idPartido

Constraints:
NONE
----------------------------------------------------------------------------------------------------------------------------
-- 16 --
CREATE TABLE participacion
(
      idParticipacion   INT NOT NULL
    , jugoPartido       INT NOT NULL
    , participaJugador  INT NOT NULL
    , asistencias       INT DEFAULT 0
    , rebotes           INT DEFAULT 0
    , posicion          VARCHAR(10)
    , puntos            INT DEFAULT 0
    , esTitular         BIT NOT NULL
);

PARTICIPACION(idParticipacion, jugoPartido, participaJugador, asistencias, rebotes, posicion, puntos, esTitular)
PK = { (idParticipacion) }
CC = { (idParticipacion) }
FK = { (juegoPartido), (participaJugador) }

References:
PARTICIPACION.jugoPartido debe estar en PARTIDO.idPartido
PARTICIPACION.participaJugador debe estar en JUGADOR.idIntegrante
PARTICIPACION.posicion puede ser o bien BASE o ESCOLTA o ALERO o ALA-PIVOT o PIVOT o nulo.

Constraints:
PARTICIPACION.jugoPartido no puede ser nulo
PARTICIPACION.participaJugador no puede ser nulo

PARTICIPACION.jugoPartido.equipoSeleccion1 puede aparecer a lo sumo 5 veces con PARTICIPACION.esTitular = true
PARTICIPACION.jugoPartido.equipoSeleccion2 puede aparecer a lo sumo 5 veces con PARTICIPACION.esTitular = true
No puede haber dos PARTICIPACION.participaJugador tal que PARTICIPACION.esTitular = true y  PARTICIPACION.participaJugador.IdIntegrante.perteneceSeleccion  sean iguales.

PARTICIPACION.participaJugador debe ser único por PARTICIPACION.jugoPartido

----------------------------------------------------------------------------------------------------------------------------
-- 17 --
CREATE TABLE sancion
(
      idSancion             INT NOT NULL
    , aplicaParticipacion   INT NOT NULL
    , sancionadaPorArbitro  INT NOT NULL
    , esDeTipo              INT NOT NULL
);

SANCION(idSancion, aplicaParticipacion, sancionadaPorArbitro, esDeTipo)
PK = { idSancion }
CC = { idSancion }
FK = { (aplicaParticipacion) , (sancionadaPorArbitro), (esDeTipo)}

References:
SANCION.aplicaParticipacion debe estar en PARTICIPACION.idParticipacion
SANCION.sancionadaPorArbitro debe estar en ARBITRO.idArbitro
SANCION.esDeTipo debe estar en SANCION.idTipoSancion

Constraints:
SANCION.aplicaParticipacion no puede ser nulo
SANCION.sancionadaPorArbitro no puede ser nulo
SANCION.esDeTipo no puede ser nulo
ARBITRA.idArbitroArb = SANCION.sancionadaPorArbitro  and ARBITRA.idPartidoArb =  SANCION.aplicaParticipacion.jugoPartido

----------------------------------------------------------------------------------------------------------------------------
-- 18 --
CREATE TABLE tiposancion
(
      idTipoSancion INT NOT NULL
    , nombreSancion VARCHAR(50)
);

TIPOSANCION(idTipoSancion, nombreSancion)
PK = { idTipoSancion }
CC = { idTipoSancion }
FK = { }

Constraints:
NONE

