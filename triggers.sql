CREATE OR REPLACE TRIGGER ref_estadio
BEFORE INSERT ON equipo
BEGIN
	for reg in (select * from ESTADIO e where e.nombre = :NEW.estadio) loop 
 	IF NOT (reg.equipo == NULL) THEN
	RAISE_APPLICATION_ERROR(-20505,'El estadio ya tiene equipo');
	END IF;
 	end loop;
END;
/

CREATE OR REPLACE TRIGGER estadio_delete 
AFTER DELETE ON equipo
BEGIN
	for reg in (select * from ESTADIO where DEREF(equipo).nombre=:old.nombre) loop 
 	SET reg.estadio= NULL
 	end loop;
END;
 /