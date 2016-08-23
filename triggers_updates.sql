/* 
Andres Rocha 12-11247
Francisco Rojas 12-10515
*/

CREATE OR REPLACE TRIGGER u_estadio
FOR UPDATE OF equipo ON estadio
COMPOUND TRIGGER

	equipos equipo_t;
	equiposOLD equipo_t;
	estadios estadio_t;
	estadiosOLD estadio_t;
	temp estadio.nombre%type;
	BEFORE EACH ROW IS
	BEGIN
	temp := :New.nombre;
	IF (:OLD.equipo IS NULL) THEN
		SELECT DEREF(:NEW.equipo) INTO equipos FROM dual;
		IF (equipos.estadio IS NOT NULL) THEN
			SELECT DEREF(equipos.estadio) INTO estadios FROM dual;

			UPDATE estadio
			SET equipo = NULL 
			WHERE nombre = estadios.nombre;

			
		END IF;

		UPDATE equipo
		SET ESTADIO = (SELECT TREAT(REF(p) AS REF estadio_t) FROM estadio p WHERE p.nombre = :NEW.nombre) 
		WHERE nombre = equipos.nombre;
	
	ELSIF (:NEW.equipo IS NULL) THEN
		SELECT DEREF(:OLD.equipo) INTO equipos FROM dual;
		IF (equipos.estadio IS NOT NULL) THEN
			SELECT DEREF(equipos.estadio) INTO estadios FROM dual;

			UPDATE estadio
			SET equipo = NULL 
			WHERE nombre = estadios.nombre;

			
		END IF;

		UPDATE equipo
		SET ESTADIO = NULL 
		WHERE nombre = equipos.nombre;
	
	ELSE
		SELECT DEREF(:NEW.equipo) INTO equipos FROM dual;
		SELECT DEREF(:OLD.equipo) INTO equiposOLD FROM dual;

		SELECT DEREF(equipos.estadio) INTO estadios FROM dual;
		SELECT DEREF(equiposOLD.estadio) INTO estadiosOLD FROM dual;

		UPDATE estadio
		SET equipo= NULL 
		WHERE nombre = estadios.nombre;

		UPDATE equipo
		SET estadio = NULL
		WHERE nombre = equiposOLD.nombre;

		UPDATE equipo
		SET estadio =  (SELECT TREAT(REF(p) AS REF estadio_t) FROM estadio p WHERE p.nombre = :OLD.nombre)
		WHERE nombre = equipos.nombre; 

	END IF;
	END BEFORE EACH ROW;
END u_estadio;
/

CREATE OR REPLACE TRIGGER u_equipo
FOR UPDATE OF estadio ON equipo
COMPOUND TRIGGER

	estadios estadio_t;
	estadiosOLD estadio_t;
	equipos equipo_t;
	equiposOLD equipo_t;
	temp equipo.nombre%type;
	BEFORE EACH ROW IS
	BEGIN
	temp := :New.nombre;
	IF (:OLD.estadio IS NULL) THEN
		SELECT DEREF(:NEW.estadio) INTO estadios FROM dual;
		IF (estadios.equipo IS NOT NULL) THEN
			SELECT DEREF(estadios.equipo) INTO equipos FROM dual;

			UPDATE equipo
			SET estadio = NULL 
			WHERE nombre = equipos.nombre;

			
		END IF;

		UPDATE estadio
		SET equipo = (SELECT TREAT(REF(p) AS REF equipo_t) FROM equipo p WHERE p.nombre = :NEW.nombre) 
		WHERE nombre = estadios.nombre;
	
	ELSIF (:NEW.estadio IS NULL) THEN
		SELECT DEREF(:OLD.estadio) INTO estadios FROM dual;
		IF (estadios.equipo IS NOT NULL) THEN
			SELECT DEREF(estadios.equipo) INTO equipos FROM dual;

			UPDATE equipo
			SET estadio = NULL 
			WHERE nombre = equipos.nombre;

			
		END IF;

		UPDATE estadio
		SET equipo = NULL 
		WHERE nombre = estadios.nombre;
	
	ELSE
		SELECT DEREF(:NEW.estadio) INTO estadios FROM dual;
		SELECT DEREF(:OLD.estadio) INTO estadiosOLD FROM dual;

		SELECT DEREF(estadios.equipo) INTO equipos FROM dual;
		SELECT DEREF(estadiosOLD.equipo) INTO equiposOLD FROM dual;

		UPDATE equipo
		SET estadio= NULL 
		WHERE nombre = equipos.nombre;

		UPDATE estadio
		SET equipo = NULL
		WHERE nombre = estadiosOLD.nombre;

		UPDATE estadio
		SET equipo =  (SELECT TREAT(REF(p) AS REF equipo_t) FROM equipo p WHERE p.nombre = :OLD.nombre)
		WHERE nombre = estadios.nombre; 

	END IF;
	END BEFORE EACH ROW;
END u_equipo;
/