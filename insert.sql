/* 
Andres Rocha 12-11247
Francisco Rojas 12-10515
*/

/*  Instancias de la entidad equipo  */
INSERT INTO equipo values ('real madrid','madrid');
INSERT INTO equipo values ('barca','barcelona');
INSERT INTO equipo values ('chelsea','londres');

/*  Instancias de la entidad estadio  */  
INSERT INTO estadio Select 'bernabeu','calle 17','20000','177', REF (a), patr_tab('nike','underarmor') 
FROM equipo a WHERE a.nombre = 'real madrid';

INSERT INTO estadio Select 'camp nou','calle cataluny','00021','7/2', REF (a), patr_tab('adidas','ovejita') 
FROM equipo a WHERE a.nombre = 'barca';

INSERT INTO estadio Select 'standfor bridge','street nine','100000','17/22', REF (a), patr_tab('rayban','susuki') 
FROM equipo a WHERE a.nombre = 'chelsea';

/*  Instancias de la entidad titulo  */ 

INSERT INTO titulo values('Liga espana','1er','1000');
INSERT INTO titulo values('Liga adelante','2da','10');
INSERT INTO titulo values('Barclays premier','1er','100000');

/*  Instancias de la entidad ganador  */ 

INSERT INTO ganador Select REF(a) , REF(b), '28/05/2015'
FROM equipo a, titulo b WHERE a.nombre='barca' and b.nombre='Liga espana';

INSERT INTO ganador Select REF(a) , REF(b), '28/05/2010'
FROM equipo a, titulo b WHERE a.nombre='real madrid' and b.nombre='Liga espana';

INSERT INTO ganador Select REF(a) , REF(b), '28/05'
FROM equipo a, titulo b WHERE a.nombre='chelsea' and b.nombre='Barclays premier' ;

/*  Instancias de la entidad integrante  */ 

INSERT INTO integrante Select 'Francisco','1234','21','Venezuela',REF (a)
From equipo a where a.nombre='real madrid';

INSERT INTO integrante Select 'Alejandro','4321','23','Alemania',REF (a)
From equipo a where a.nombre='chelsea';

INSERT INTO integrante Select 'Sandra','0001','40','Bolivia',REF (a)
From equipo a where a.nombre='real madrid';

/*  Instancias de la entidad entrenador  */ 

INSERT INTO integrante SELECT entrenador_t('mourinho','456', '35', 'Portugal', REF(a), 'alternativo','5')
FROM equipo a where a.nombre='real madrid';

INSERT INTO integrante SELECT entrenador_t('luis enrique','1298', '26', 'Espana', REF(a), 'ofensivo','4')
FROM equipo a where a.nombre='barca';

INSERT INTO integrante SELECT entrenador_t('Antonio','777', '22', 'Italia', REF(a), 'defensivo','4')
FROM equipo a where a.nombre='chelsea';

/*  Instancias de la entidad jugador  */ 

INSERT INTO integrante SELECT jugador_t( 'morata', '001','23', 'espana', REF(a),'del','23','2', REF(b))
FROM equipo a , integrante b WHERE a.nombre = 'real madrid' and b.nombre= 'Francisco';

INSERT INTO integrante SELECT jugador_t( 'lionel', '10','28', 'argentina', REF(a),'del','100','10', REF(b))
FROM equipo a , integrante b WHERE a.nombre = 'barca' and b.nombre= 'luis enrique';

INSERT INTO integrante SELECT jugador_t( 'cristiano', '7','31', 'portugal', REF(a),'del','99','7', REF(b))
FROM equipo a , integrante b WHERE a.nombre = 'real madrid' and b.nombre= 'mourinho';

/* Consulta de la tabla anidada */

SELECT Patrocinadores FROM estadio a where a.nombre ='bernabeu';

/* Consulta de la subclase */

SELECT TREAT(VALUE(t) AS jugador_t).numero 
   FROM integrante t where TREAT(VALUE(t) AS jugador_t).numero  IS NOT NULL;
