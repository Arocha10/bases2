# bases2
faltan  las vainas de into

CREATE OR REPLACE TYPE integrante_t AS OBJECT (
	
	Nombre VARCHAR(20),
	
	Pasaporte VARCHAR(20),
	
	Edad VARCHAR(20),
	
	Nacionalidad VARCHAR(20),
	equipo REF equipo_t
	
)NOT FINAL;
/

CREATE TABLE integrante OF integrante_t(
	primary key (Pasaporte),
	foreign key (equipo) references equipo
);




CREATE OR REPLACE TYPE entrenador_t UNDER integrante_t (
	
	Estilo VARCHAR(20),
	
	Estrellas VARCHAR(20)
);



/




CREATE OR REPLACE TYPE jugador_t UNDER integrante_t (
		
	Posicion VARCHAR(20),

	Goles VARCHAR(20),

	Numero VARCHAR(20),

	rel REF integrante_t);
/


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
	
	Inaugurado VARCHAR(20)
, 
	equipo REF equipo_t,
	patrocinadores patr_tab
);
/

CREATE TABLE estadio OF estadio_t( 
	nombre not null,
	primary key (nombre)
)NESTED TABLE patrocinadores STORE AS ptr_tab_store;


CREATE OR REPLACE TYPE equipo_t AS OBJECT (
 
	Nombre VARCHAR2(20),
   
	Ciudad VARCHAR2(20) 
);
/

CREATE TABLE equipo OF equipo_t( 
	primary key (nombre)
);

ALTER TABLE estadio
ADD CONSTRAINT fk_equipo
	FOREIGN KEY (equipo)
	REFERENCES equipo;

INSERT INTO equipo values ('real madrid','madrid');
INSERT INTO equipo values ('barca','barcelona');

INSERT INTO estadio Select 'bernabeu','calle mama','2','177', REF (a), patr_tab('nike','underarmor') 
FROM equipo a WHERE a.nombre = 'real madird';

INSERT INTO estadio Select 'camp nou','calle cataluny','00021','1722', REF (a), patr_tab('adidas','ovejita') 
FROM equipo a WHERE a.nombre = 'barca';

INSERT INTO titulo values( 'Liga espana','1er', '1000');

INSERT INTO ganador Select REF(a) , REF(b), '12'
FROM equipo a, titulo b WHERE a.nombre='barca' and b.nombre='Liga espana' ;

INSERT INTO integrante Select 'francisco','1234','21','vz',REF (a)
From equipo a where a.nombre='real madird';

INSERT INTO integrante SELECT entrenador_t(  'mou','123', '21', 'vz', REF(a), 'gay','3')
FROM equipo a where a.nombre='real madird';

INSERT INTO integrante SELECT jugador_t( 'morata', '001','23', 'espana', REF(a),'del','23','2', REF(b))
FROM equipo a , integrante b WHERE a.nombre = 'real madird' and b.nombre= 'n1';

INSERT INTO integrante Select 'n1','p1','e1','espana',REF(a)
FROM equipo a WHERE a.nombre = 'real madird';

