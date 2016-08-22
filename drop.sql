/* 
Andres Rocha 12-11247
Francisco Rojas 12-10515
*/
DROP TRIGGER ref_estadio;
DROP TRIGGER estadio_delete;
DROP TABLE estadio CASCADE CONSTRAINTS;
DROP TYPE estadio_t force;
DROP TYPE patr_tab force;
DROP TABLE ganador;
DROP TYPE ganador_t;
DROP TABLE titulo;
DROP TYPE titulo_t;
DROP TABLE integrante;
DROP TYPE jugador_t force;
DROP TYPE entrenador_t;
DROP TYPE integrante_t force;
DROP TABLE equipo CASCADE CONSTRAINTS;
DROP TYPE equipo_t force;
