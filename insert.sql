
/*Insertar  tuplas tabla student*/
INSERT INTO student (name,program)
VALUES
  ('Javier Castillo','Matematicas'),
  ('Kevin Aristizabal','Ingenieria Sistemas'),
  ('Angie Duque','Estadistica'),
  ('Victor Cifuentes','Estadistica'),
  ('Ivan Morales','Ingenieria electronica');

/*Select - table student*/
SELECT * FROM "student";

/*Insertar  tuplas tabla instructor*/
INSERT INTO instructor (instructor_id, name, dept, title) 
VALUES 
    (8513711, 'Jaime', 'Investigación', 'Tecnico de soporte'),
    (5678912, 'Jennifer', 'Desarrollo', 'Investigador'),
    (1267934, 'Rafael', 'Administración', 'Asistente'),
    (3451256, 'Luz', 'Ciencias', 'Profesor catedra '),
    (1987267, 'Santiago', 'Salud3', 'Tecnico de soporte');

/*Select - table instructor*/
SELECT * FROM "instructor";

/*Insertar  tuplas tabla course*/
INSERT INTO course (title,syllabus,credits)
VALUES
  ('FLP','pensum 148',4),
  ('Desarrollo Software','pensum 158',3),
  ('Física','pensum 148',3),
  ('Deporte formativo','pensum 158',2),
  ('Cálculo','pensum 158',4);
  
/*Select - table course*/
SELECT * FROM "course";  

/*Insertar  tuplas tabla course_offering*/
INSERT INTO course_offering (course_id,year,semester,time,classroom)
VALUES
 (837827,1937,1,'10:40 PM','740B'),
  (837850,2018,2,'4:58 PM','120c'),
  (837873,2022,1,'5:11 AM','530A'),
  (837896,2021,2,'12:01 PM','350Bx'),
  (837919,1973,1,'9:23 AM','740Bd');
  
/*Select - table course_offering*/
SELECT * FROM "course_offering";

/*Insertar  tuplas tabla enrols*/
INSERT INTO enrols (student_id,course_id,semester,year,grade)
VALUES
  (7488,837827,1,1937, 4.43),
  (7656,837850,2,2018,3.47),
  (7824,837873,1,2022,4.91),
  (7992,837896,2,2018,2.23),
  (8160,837873,1,1937,2.94);

/*Select - table enrols*/
SELECT * FROM "enrols";
 
/*Insertar  tuplas tabla teaches*/
INSERT INTO teaches (course_id,semester,year,instructor_id)
VALUES
  (837827,1,1937,8513711),
  (837873,2,2020,1267934),
  (837896,1,1973,3451256),
  (837850,2,2022,5678912),
  (837919,2,2021,1987267);

/*Select - table teaches*/
SELECT * FROM "teaches";

/*Insertar  tuplas tabla requires*/
INSERT INTO requires (main_course,prerequisite)
VALUES
  (837827, 837850),
  (837850, 837827),
  (837873, 837919),
  (837919, 837873),
  (837919, 837896);
  
/*Select - table requires*/
SELECT * FROM "requires";

