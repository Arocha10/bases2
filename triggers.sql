/* 
Andres Rocha 12-11247
Francisco Rojas 12-10515
*/

SET SERVEROUTPUT ON;


CREATE OR REPLACE TRIGGER ref_equipo
FOR INSERT ON estadio
COMPOUND TRIGGER

	equipos equipo_t;
	temp estadio.nombre%type;
	BEFORE EACH ROW IS
	BEGIN
	temp := :New.nombre;
	IF (:NEW.equipo IS NOT NULL) THEN
		SELECT DEREF(:NEW.equipo) INTO equipos FROM dual;
		IF (equipos.estadio IS NOT NULL) THEN
			RAISE_APPLICATION_ERROR(-20505,'Ya tiene equipo.');
		END IF;
	END IF;
	END BEFORE EACH ROW;

	AFTER STATEMENT IS
	BEGIN
		UPDATE equipo 
		SET estadio = (SELECT TREAT(REF(p) AS REF estadio_t) FROM estadio p WHERE p.nombre = temp) 
		WHERE nombre = equipos.nombre;
	END AFTER STATEMENT;
END ref_equipo;
/

CREATE OR REPLACE TRIGGER ref_estadio
FOR INSERT ON equipo
COMPOUND TRIGGER

	estadios estadio_t;
	temp equipo.nombre%type;
	BEFORE EACH ROW IS
	BEGIN
	temp := :New.nombre;
	IF (:NEW.estadio IS NOT NULL) THEN
		SELECT DEREF(:NEW.estadio) INTO estadios FROM dual;
		IF (estadios.equipo IS NOT NULL) THEN
			RAISE_APPLICATION_ERROR(-20505,'Ya tiene estadio.');
		END IF;
	END IF;
	END BEFORE EACH ROW;

	AFTER STATEMENT IS
	BEGIN
		UPDATE estadio 
		SET equipo = (SELECT TREAT(REF(p) AS REF equipo_t) FROM equipo p WHERE p.nombre = temp) 
		WHERE nombre = estadios.nombre;
	END AFTER STATEMENT;
END ref_estadio;
/

CREATE OR REPLACE TRIGGER equipo_delete
AFTER DELETE ON equipo 
FOR EACH ROW 
DECLARE 
	PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN 
	UPDATE estadio c SET c.equipo = null WHERE c.equipo = (SELECT REF(p) FROM equipo p WHERE p.nombre = :old.nombre);
	commit; 
END;
/

CREATE OR REPLACE TRIGGER estadio_delete
AFTER DELETE ON estadio 
FOR EACH ROW 
DECLARE 
	PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN 
	UPDATE equipo c SET c.estadio = null WHERE c.estadio = (SELECT REF(p) FROM estadio p WHERE p.nombre = :old.nombre);
	commit; 
END;
/
