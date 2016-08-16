
CREATE OR REPLACE TYPE equipo_t AS OBJECT (
 
	Nombre VARCHAR2(20),
   
	Ciudad VARCHAR2(20) 
);
/

CREATE TABLE equipo OF equipo_t( 

	primary key (nombre)
);

CREATE OR REPLACE TYPE integrante_t AS OBJECT (
	
	Nombre VARCHAR(20),
	
	Pasaporte VARCHAR(20),
	
	Edad VARCHAR(20),
	
	Nacionalidad VARCHAR(20),
	
	equipo REF equipo_t
	
)NOT FINAL;
/


CREATE OR REPLACE TYPE entrenador_t UNDER integrante_t (
	
	Estilo VARCHAR(20),
	
	Estrellas VARCHAR(20)
);


/

CREATE OR REPLACE TYPE jugador_t UNDER integrante_t (
		
	Posicion VARCHAR(20),

	Goles VARCHAR(20),

	Numero VARCHAR(20),

	Coop REF integrante_t);
/


CREATE TABLE integrante OF integrante_t(

	primary key (Pasaporte),
	
	foreign key (equipo) references equipo
);

CREATE OR REPLACE TYPE titulo_t AS OBJECT (
	
	Nombre VARCHAR(20),
	
	Categoria VARCHAR(20),
	
	Premio VARCHAR(20));

/

CREATE TABLE  titulo OF titulo_t(

	nombre not null,  
	
	primary key (nombre));
	

CREATE OR REPLACE TYPE ganador_t AS OBJECT (
	equipo REF equipo_t,
	
	titulo REF titulo_t,
	
	fecha VARCHAR2(10));
/

CREATE TABLE ganador of ganador_t(

	foreign key (equipo) references equipo,
	
	foreign key (titulo) references titulo);
	

CREATE OR REPLACE TYPE patr_tab AS Table OF VARCHAR2(20);
/

CREATE OR REPLACE TYPE estadio_t AS OBJECT (
	
	Nombre VARCHAR(20),
	
	Dir VARCHAR(100),
	
	Capacidad VARCHAR(20),
	
	Inaugurado VARCHAR(20),
	
	equipo REF equipo_t,
	
	patrocinadores patr_tab
);
/

CREATE TABLE estadio OF estadio_t( 

	nombre not null,
	
	primary key (nombre)
	
)NESTED TABLE patrocinadores STORE AS ptr_tab_store;

ALTER TABLE estadio
ADD CONSTRAINT fk_equipo
	FOREIGN KEY (equipo)
	REFERENCES equipo;
