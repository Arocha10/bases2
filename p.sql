/*  Instancias de la entidad equipo  */
INSERT INTO equipo values ('real madrid','madrid',NULL);
INSERT INTO equipo values ('barca','barcelona',NULL);
INSERT INTO equipo values ('chelsea','londres',NULL);

/*  Instancias de la entidad estadio  */  
INSERT INTO estadio Select 'bernabeu','calle 17','20000','177', REF (a), patr_tab('nike','underarmor') 
FROM equipo a WHERE a.nombre = 'real madrid';

INSERT INTO estadio Select 'camp nou','calle cataluny','00021','7/2', REF (a), patr_tab('adidas','ovejita') 
FROM equipo a WHERE a.nombre = 'barca';

INSERT INTO estadio Select 'standfor bridge','street nine','100000','17/22', REF (a), patr_tab('rayban','susuki') 
FROM equipo a WHERE a.nombre = 'chelsea';

DELETE a from equipo a
where a.nombre = 'chelsea';
