DROP TABLE CONSOLA CASCADE CONSTRAINTS;
DROP TABLE FRANQUICIA CASCADE CONSTRAINTS;
DROP TABLE VIDEOJUEGO CASCADE CONSTRAINTS;
DROP TABLE JUGADOR CASCADE CONSTRAINTS;

CREATE TABLE CONSOLA (
    id_consola             NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_consola         VARCHAR2(60) NOT NULL UNIQUE,
    tipo_consola           VARCHAR2(20) NOT NULL CHECK (tipo_consola IN ('SOBREMESA', 'PORTATIL', 'HIBRIDA')),
    anio_lanzamiento       NUMBER(4) NOT NULL CHECK (anio_lanzamiento BETWEEN 1983 AND 2030),
    precio_referencia_usd  NUMBER(6,2) NOT NULL CHECK (precio_referencia_usd > 0),
    estado_fabricacion     VARCHAR2(15) DEFAULT 'ACTIVA' NOT NULL CHECK (estado_fabricacion IN ('ACTIVA', 'DESCONTINUADA'))
);

CREATE TABLE FRANQUICIA (
    id_franquicia      NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_franquicia  VARCHAR2(60) NOT NULL UNIQUE,
    creador_principal  VARCHAR2(80),
    anio_debut         NUMBER(4) NOT NULL CHECK (anio_debut >= 1980),
    estudio_principal  VARCHAR2(60) DEFAULT 'NINTENDO EPD' NOT NULL
);

CREATE TABLE VIDEOJUEGO (
    id_juego            NUMBER(6) GENERATED ALWAYS AS IDENTITY START WITH 101 PRIMARY KEY,
    codigo_catalogo     VARCHAR2(10) NOT NULL UNIQUE,
    titulo              VARCHAR2(100) NOT NULL,
    id_franquicia       NUMBER(4) NOT NULL REFERENCES franquicia (id_franquicia),
    id_consola          NUMBER(4) NOT NULL REFERENCES consola (id_consola),
    clasificacion_esrb  VARCHAR2(5) NOT NULL CHECK (clasificacion_esrb IN ('E', 'E10+', 'T', 'M')),
    precio_clp          NUMBER(8) NOT NULL CHECK (precio_clp >= 0),
    puntaje_metacritic  NUMBER(3) CHECK (puntaje_metacritic BETWEEN 0 AND 100),
    stock_fisico        NUMBER(5) DEFAULT 0 NOT NULL CHECK (stock_fisico >= 0),
    fecha_lanzamiento   DATE NOT NULL
);

CREATE TABLE JUGADOR (
    id_jugador         NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nickname           VARCHAR2(30) NOT NULL UNIQUE,
    email              VARCHAR2(100) NOT NULL UNIQUE,
    pais               VARCHAR2(40) DEFAULT 'CHILE' NOT NULL,
    monedas_oro        NUMBER(6) DEFAULT 0 NOT NULL CHECK (monedas_oro >= 0),
    suscripcion_online VARCHAR2(15) DEFAULT 'GRATUITA' NOT NULL CHECK (suscripcion_online IN ('GRATUITA', 'INDIVIDUAL', 'FAMILIAR', 'EXPANSION')),
    id_juego_favorito  NUMBER(6) REFERENCES videojuego (id_juego)
);

CREATE TABLE ACCESORIO_PRUEBA (
    id_accesorio     NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_accesorio VARCHAR2(40) NOT NULL,
    precio_usd       NUMBER(5,2) NOT NULL CHECK (precio_usd > 0),
    id_consola       NUMBER(4) NOT NULL REFERENCES consola(id_consola)
);

ALTER TABLE JUGADOR ADD fecha_registro DATE DEFAULT SYSDATE NOT NULL;
ALTER TABLE JUGADOR ADD nivel_cuenta   NUMBER(3) DEFAULT 1 NOT NULL CHECK (nivel_cuenta BETWEEN 1 AND 99);

ALTER TABLE ACCESORIO_PRUEBA MODIFY nombre_accesorio VARCHAR2(100);
ALTER TABLE ACCESORIO_PRUEBA ADD color_edicion       VARCHAR2(25);
ALTER TABLE ACCESORIO_PRUEBA DROP COLUMN color_edicion;

DROP TABLE ACCESORIO_PRUEBA;

ALTER TABLE VIDEOJUEGO ADD descuento_porcentaje NUMBER(3) DEFAULT 0 NOT NULL CHECK (descuento_porcentaje BETWEEN 0 AND 80);

--PARTE 2

INSERT INTO CONSOLA (nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion) VALUES ('Nintendo Switch', 'HIBRIDA', 2017, 299.99, 'ACTIVA');
INSERT INTO CONSOLA (nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd) VALUES ('Nintendo Switch 2', 'HIBRIDA', 2025, 449.99);
INSERT INTO CONSOLA (nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion) VALUES ('Nintendo 3DS', 'PORTATIL', 2011, 169.99, 'DESCONTINUADA');
INSERT INTO CONSOLA (nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion) VALUES ('Nintendo GameCube', 'SOBREMESA', 2001, 199.99, 'DESCONTINUADA');
COMMIT;

INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut) VALUES ('Super Mario', 'Shigeru Miyamoto', 1985);
INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut) VALUES ('The Legend of Zelda', 'Shigeru Miyamoto', 1986);
INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES ('Pokemon', 'Satoshi Tajiri', 1996, 'Game Freak');
INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES ('Metroid', 'Gunpei Yokoi', 1986, 'MercurySteam');
INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut, estudio_principal) VALUES ('Super Smash Bros', 'Masahiro Sakurai', 1999, 'Bandai Namco/Sora');
INSERT INTO FRANQUICIA (nombre_franquicia, creador_principal, anio_debut) VALUES ('Splatoon', NULL, 2015);
COMMIT;

INSERT INTO VIDEOJUEGO (codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento) 
    VALUES ('NSW-001', 'The Legend of Zelda: Breath of the Wild', 2, 1, 'E10+', 54990, 97, 45, TO_DATE('2017-03-03','YYYY-MM-DD'));
INSERT INTO VIDEOJUEGO (codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento) 
    VALUES ('NSW-002', 'Super Mario Odyssey', 1, 1, 'E10+', 49990, 97, 60, TO_DATE('2017-10-27','YYYY-MM-DD'));
INSERT INTO VIDEOJUEGO (codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento) 
    VALUES ('NSW-003', 'Metroid Dread', 4, 1, 'T', 44990, 88, 15, TO_DATE('2021-10-08','YYYY-MM-DD'));

COMMIT;
