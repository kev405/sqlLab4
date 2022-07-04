
/* 4.a: Cree uno o varios disparadores (triggers) 
que implemente los siguiente requerimientos para 
la relación enrolls */

/*i Al agregar una tupla en enrolls, en caso de que la nota 
sea negativa, cero (0.0) o mayor de 5.00 se debe generar una 
excepción indicando que el valor a guardar en grade es 
incorrecto o invalido.*/

/* Eliminar referencia existentes */
DROP TRIGGER IF EXISTS grade_check ON enrols;

/* Se crea el disparador*/
CREATE OR REPLACE FUNCTION grade_check() 
    RETURNS TRIGGER AS $grade_check$
BEGIN
    IF NEW.grade <= 0 OR NEW.grade > 5.0 THEN
        RAISE EXCEPTION 'El valor de grade es incorrecto o inválido ',NEW.grade;
    END IF;
    RETURN NULL;
END;

CREATE TRIGGER grade_check BEFORE INSERT ON enrols
    FOR EACH ROW 
        EXECUTE PROCEDURE grade_check(); 

  
/*ii.Durante la actualización de un registro si el valor
grade es modificado, usando RAISE NOTICE se debe presentar 
un mensaje indicando el cambio, si es igual al valor grade en 
la tabla se debe indicar que el valor no ha sido modificado. 
Si el grade a actualizar es negativo, cero o mayor de cinco 
use RAISE EXCEPTION.*/

/* Eliminar referencia existentes */
DROP TRIGGER IF EXISTS grade_check_up ON enrols;

/* Se crea el disparador*/
CREATE OR REPLACE FUNCTION grade_check2() 
    RETURNS TRIGGER AS $grade_check2$
BEGIN
    IF NEW.grade = OLD.grade THEN
        RAISE EXCEPTION 'El valor de grade es igual al anterior por lo que no ha modificado',NEW.grade; 
    ELSIF NEW.grade <= 0 OR NEW.grade > 5.0 THEN
        RAISE EXCEPTION 'El valor de grade es incorrecto o inválido',NEW.grade;
    ELSE
        BEGIN
            RAISE NOTICE 'El valor de grade ha sido modificado',NEW.grade;
            RETURN NEW;
        END;
    END IF;
    RETURN NULL;
END;

CREATE TRIGGER grade_check_up BEFORE UPDATE ON enrols
    FOR EACH ROW 
        EXECUTE PROCEDURE grade_check2();

/*4.b. Cree un procedimiento create_teaches que automáticamente agregue 
un registro a teaches. Este recibe dos argumentos un identificador de 
instructor instructor_id y un identificador de course_id. Se asume que a
mbos existen en la base de datos.*/

/* i. Este procedimiento debe verificar que el curso 
exista en la oferta de cursos. */


/* ii. Use curse_id, sec_id, year y semester de la oferta de curso y 
instructor_id el para insertar en teaches.*/

DROP PROCEDURE IF EXISTS create_teaches(instructor_idp INT, course_idp INT);

CREATE PROCEDURE create_teaches(instructor_idp INT, course_idp INT)
    AS $create_teaches$
    BEGIN
        IF EXISTS(SELECT * FROM course 
                  WHERE course_id=course_idp) AND EXISTS(SELECT * FROM instructor 
                                                                              WHERE instructor_id=instructor_idp) THEN
            BEGIN
                INSERT INTO teaches (course_id,sec_id,semester,year,instructor_id) 
                    VALUES(course_idp,
                            (SELECT sec_id FROM course_offering 
                             WHERE course_id=course_idp),
                            (SELECT semester FROM course_offering 
                             WHERE course_id=course_idp),
                            (SELECT year FROM course_offering 
                             WHERE course_id=course_idp),
                            instructor_idp);
            END;
        ELSE
            RAISE EXCEPTION 'No existe el course_id o el instructor_id';        
        END IF;

