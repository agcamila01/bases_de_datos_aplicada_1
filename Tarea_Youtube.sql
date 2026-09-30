DROP TABLE VIDEO CASCADE CONSTRAINTS;
DROP TABLE TIPO_VIDEO CASCADE CONSTRAINTS;
DROP TABLE USUARIO CASCADE CONSTRAINTS;
DROP TABLE COMENTARIO CASCADE CONSTRAINTS;
DROP TABLE CANAL CASCADE CONSTRAINTS;
DROP TABLE SUSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE TIPO_ME_GUSTA CASCADE CONSTRAINTS;
DROP TABLE ME_GUSTA CASCADE CONSTRAINTS;
DROP TABLE LISTA_DE_REPRODUCCION CASCADE CONSTRAINTS;
DROP TABLE TIPO_MEMBRESIA CASCADE CONSTRAINTS;
DROP TABLE MEMBRESIA CASCADE CONSTRAINTS;

CREATE TABLE TIPO_VIDEO(
    id_tipo_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100)
);

CREATE TABLE VIDEO(
    id_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(200) NOT NULL,
    descripcion VARCHAR2(200),
    me_gusta_activados CHAR(1),
    comentarios_activados CHAR(1),
    esta_monetizado CHAR(1),
    duracion NUMBER,
    id_tipo_video NUMBER REFERENCES TIPO_VIDEO(id_tipo_video)
    --fk canal
    --fk visibilidad publico privado oculto
    --fk estado procesando publicado eliminado
    --restriccion de edad
);

CREATE TABLE USUARIO(
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    fecha_de_nacimiento DATE,
    esta_verificado CHAR(1)
);

CREATE TABLE CANAL(
    id_canal NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(300),
    esta_verificado CHAR(1),
    esta_monetizado CHAR(1)
);

CREATE TABLE SUSCRIPCION(
    id_suscripcion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
    --fk usuario
    --fk canal
);

CREATE TABLE COMENTARIO(
    id_comentario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    texto VARCHAR2(300) NOT NULL,
    fecha DATE
    --fk usuario
    --fk video
    --fk respuesta a comentario
);

CREATE TABLE TIPO_ME_GUSTA(
    id_tipo_me_gusta NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(20) --me gusta, no me gusta
);

CREATE TABLE ME_GUSTA(
    id_me_gusta NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_tipo_me_gusta REFERENCES TIPO_ME_GUSTA(id_tipo_me_gusta)
    --fk usuario
    --fk video
);

CREATE TABLE LISTA_DE_REPRODUCCION(
    id_lista_de_reproduccion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    fecha_creacion DATE
    --visibilidad
    --fk video
    --fk usuario
);

CREATE TABLE TIPO_MEMBRESIA(
    id_tipo_membresia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100),
    precio NUMBER
);

CREATE TABLE MEMBRESIA(
    id_membresia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_inicio DATE,
    fecha_termino DATE,
    id_tipo_membresia REFERENCES TIPO_MEMBRESIA(id_tipo_membresia)
    --estado
);

