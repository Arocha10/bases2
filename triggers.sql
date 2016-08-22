CREATE OR REPLACE TRIGGER ref_estadio
BEFORE INSERT ON equipo
SELECT equipo
FROM estadio e
WHERE e.nombre = :NEW.estadio
IF NOT(e.quipo = NULL) THEN
RAISE_APPLICATION_ERROR(-20505,'El estadio ya tiene equipo');
END IF;
END;
/
CREATE TRIGGER estadio_delete AFTER DELETE on equipo
BEGIN
	for reg in (select * from ESTADIO where DEREF(equipo).nombre=:old.nombre) loop 
 	SET reg.estadio= NULL
 	end loop;
END;
 /
