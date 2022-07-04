DROP SEQUENCE IF EXISTS "student_id_seq" CASCADE;
DROP TABLE IF EXISTS "student" CASCADE;
DROP TABLE IF EXISTS "instructor" CASCADE;
DROP SEQUENCE IF EXISTS "course_id_seq" CASCADE;
DROP TABLE IF EXISTS "course" CASCADE;
DROP TABLE IF EXISTS "course_offering" CASCADE;
DROP TABLE IF EXISTS "enrols" CASCADE;
DROP TABLE IF EXISTS "teaches" CASCADE;
DROP TABLE IF EXISTS "requires" CASCADE;
 

/* table student - INCREMENT 168  */
CREATE SEQUENCE student_id_seq
INCREMENT 168
START 7488;

/* Create table Student */
CREATE TABLE student(
    student_id INT DEFAULT nextval('student_id_seq'),
    name varchar(40) NOT NULL,
    program varchar(40) NOT NULL,
    PRIMARY KEY(student_id)
);

/* Create table instructor */
CREATE TABLE instructor(
    instructor_id INT,
    name varchar(40) NOT NULL,
    dept varchar(40) NOT NULL,
    title varchar(40) NOT NULL,
    PRIMARY KEY(instructor_id)
);

/* table course_id - INCREMENT 23 */
CREATE SEQUENCE course_id_seq
INCREMENT 23
START 837827;

/* Create table course_id */
CREATE TABLE course(
    course_id INT DEFAULT nextval('course_id_seq'),
    title varchar(40) NOT NULL,
    syllabus varchar(40) NOT NULL,
    credits INT NOT NULL,
    PRIMARY KEY(course_id)
);

/* Create table course_offering */
CREATE TABLE course_offering(
    course_id INT,
    sec_id serial,
    year INT,
    semester INT CHECK (semester=1 OR semester=2),
    time time NOT NULL,
    classroom varchar(40) NOT NULL,
    CONSTRAINT "FK_course_offering.course_id"
      FOREIGN KEY (course_id)
        REFERENCES course(course_id),
    PRIMARY KEY(course_id, sec_id , year, semester)
);


/* Create table enrols */
CREATE TABLE enrols(
    student_id INT,
    course_id INT,
    sec_id serial,
    semester INT CHECK (semester=1 OR semester=2),
    year INT,
    grade NUMERIC(3,2) NOT NULL CHECK (grade>1 AND grade<5),
    CONSTRAINT "FK_enrols.student_id"
      FOREIGN KEY (student_id)
        REFERENCES student(student_id),
    CONSTRAINT "FK_enrols_offering.course_id"
      FOREIGN KEY (course_id)
        REFERENCES course(course_id),
    PRIMARY KEY(student_id,course_id, sec_id , semester,year)
);

/* Create table teaches */
CREATE TABLE teaches(
    course_id INT,
    sec_id serial,
    semester INT CHECK (semester=1 OR semester=2),
    year INT,
    instructor_id INT,
    CONSTRAINT "FK_teaches.course_id"
      FOREIGN KEY (course_id)
        REFERENCES course(course_id),
    CONSTRAINT "FK_teaches.instructor_id"
      FOREIGN KEY (instructor_id)
        REFERENCES instructor(instructor_id),
    PRIMARY KEY(course_id,sec_id, semester , year,instructor_id)
);

/* Create table requires */
CREATE TABLE requires(
    main_course INT,
    prerequisite INT,
    CONSTRAINT "FK_requires.main_course"
      FOREIGN KEY (main_course)
        REFERENCES course(course_id),
    CONSTRAINT "FK_requires.prerequisite"
      FOREIGN KEY (prerequisite)
        REFERENCES course(course_id),
    PRIMARY KEY(main_course,prerequisite)
);