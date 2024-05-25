CREATE TABLE rooms (
	room_id			VARCHAR(4) PRIMARY KEY,
	room_type		VARCHAR(255),
	room_capacity	INTEGER(3)
);

-- staff_status: 'L' for live or 'D' for dormant
-- staff_status_reason: e.g. retired, resigned, misconduct
CREATE TABLE staff (
	staff_id			INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	staff_forename		VARCHAR(255),
	staff_middle_names	VARCHAR(255),
	staff_surname		VARCHAR(255),
	staff_role_cl		BOOLEAN,
	staff_role_ml		BOOLEAN,
	staff_role_pt		BOOLEAN,
	staff_address		VARCHAR(255),
	staff_telephone		VARCHAR(255),
	staff_email			VARCHAR(255) UNIQUE,
	staff_password		VARCHAR(255),
	staff_status		CHAR(1) DEFAULT 'L',
	staff_status_reason	VARCHAR(255),
	staff_specialism	VARCHAR(255),
	staff_lastlogged	DATETIME DEFAULT NOW()
);

-- FKs: module_leader
CREATE TABLE modules (
	module_id		CHAR(5) PRIMARY KEY,
	module_year		INTEGER(1) NOT NULL,
	module_points	INTEGER(2) NOT NULL,
	module_title	VARCHAR(255) NOT NULL,
	module_as1		INTEGER(3),
	module_as2		INTEGER(3),
	module_exam		INTEGER(3),
	module_leader	INTEGER(8)
);

CREATE TABLE courses (
	course_id			INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	course_name			VARCHAR(255)
);

-- courses <=> modules are a many-many relationship. make a junction table
CREATE TABLE course_modules (
	course_id		INTEGER(8),
	module_id		CHAR(5),
	PRIMARY KEY (course_id, module_id)
);

-- FKs: student_course, student_personal_tutor
-- student_status: 'L' for live or 'D' for dormant
-- student_status_reason: e.g. graduated, withdrawn, terminated
-- ## student_id format ## --
-- first digit = century e.g. 2024 == '2', 2124 == '3'
-- 2nd/3rd digit = current year e.g. 2024 == '24', 2025 == '25'
-- 4th-8th digits = increment
-- PL/SQL is cringe, so we're managing ID generation in PHP
-- ## end student_id format ## --
CREATE TABLE students (
	student_id						INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	student_forename				VARCHAR(255),
	student_middle_names			VARCHAR(255),
	student_surname					VARCHAR(255),
	student_term_address			VARCHAR(255),
	student_nonterm_address			VARCHAR(255),
	student_telephone				VARCHAR(255),
	student_email					VARCHAR(255),
	student_password				VARCHAR(255),
	student_status					CHAR(1) DEFAULT 'L',
	student_status_reason			VARCHAR(255),
	student_course					INTEGER(8),
	student_entry_qualifications	VARCHAR(255),
	student_personal_tutor			INTEGER(8)
);

-- FKs: module_id, lecture_room
-- lecture_duration: length of lecture in minutes
CREATE TABLE lectures (
	lecture_id			INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	module_id			CHAR(5),
	module_week			INTEGER(2),
	lecture_room		VARCHAR(4),
	lecture_datetime	DATETIME,
	lecture_duration	INTEGER(4),
	UNIQUE (lecture_room, lecture_datetime)
);

-- FKs: student_id, lecture_id
CREATE TABLE attendance (
	attendance_id		INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	student_id			INTEGER(8),
	lecture_id			INTEGER(8),
	attendance_value	CHAR(1),
	UNIQUE (student_id, lecture_id)
);

-- FKs: assignment_module
CREATE TABLE assignments (
	assignment_id		INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	assignment_name		VARCHAR(255),
	assignment_module	CHAR(5)
);

-- FKs: assignment_id, student_id
CREATE TABLE grades (
	grade_id		INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	assignment_id	INTEGER(8),
	student_id		INTEGER(8),
	grade_value		CHAR(3)
);

-- FKs: diary_author
CREATE TABLE diaries (
	diary_id		INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	diary_author	INTEGER(8),
	diary_date		DATETIME DEFAULT NOW(),
	diary_content	VARCHAR(2000)
);


-- TRIGGERS

-- create blank grade entries for appropriate students when assignment is created
CREATE TRIGGER tr_assignment_grades
AFTER INSERT ON assignments
FOR EACH ROW
	INSERT INTO grades (assignment_id, student_id)
	SELECT NEW.assignment_id, student_id FROM students
	WHERE student_course = (SELECT course_id FROM course_modules WHERE module_id = NEW.assignment_module)
;

-- create blank attendance entries for appropriate students when lecture is created
CREATE TRIGGER tr_attendance_students
AFTER INSERT ON lectures
FOR EACH ROW
	INSERT INTO attendance (student_id, lecture_id)
	SELECT student_id, NEW.lecture_id FROM students
	WHERE student_course = (SELECT course_id FROM course_modules WHERE module_id = NEW.module_id)
;


-- ALTERS
ALTER TABLE staff AUTO_INCREMENT=99100000;
ALTER TABLE lectures AUTO_INCREMENT=10000000;
ALTER TABLE attendance AUTO_INCREMENT=30000000;
ALTER TABLE assignments AUTO_INCREMENT=40000000;
ALTER TABLE grades AUTO_INCREMENT=50000000;
ALTER TABLE diaries AUTO_INCREMENT=60000000;
ALTER TABLE courses AUTO_INCREMENT=70000000;

ALTER TABLE modules
ADD CONSTRAINT fk_mod_staff
FOREIGN KEY (module_leader)
REFERENCES staff(staff_id)
ON DELETE CASCADE;

ALTER TABLE course_modules
ADD CONSTRAINT fk_cm_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id)
ON DELETE CASCADE;

ALTER TABLE course_modules
ADD CONSTRAINT fk_cm_modules
FOREIGN KEY (module_id)
REFERENCES modules(module_id)
ON DELETE CASCADE;

ALTER TABLE students
ADD CONSTRAINT fk_stu_courses
FOREIGN KEY (student_course)
REFERENCES courses(course_id)
ON DELETE CASCADE;

ALTER TABLE students
ADD CONSTRAINT fk_stu_staff
FOREIGN KEY (student_personal_tutor)
REFERENCES staff(staff_id)
ON DELETE CASCADE;

ALTER TABLE lectures
ADD CONSTRAINT fk_lec_modules
FOREIGN KEY (module_id)
REFERENCES modules(module_id)
ON DELETE CASCADE;

ALTER TABLE lectures
ADD CONSTRAINT fk_lec_rooms
FOREIGN KEY (lecture_room)
REFERENCES rooms(room_id)
ON DELETE CASCADE;

ALTER TABLE attendance
ADD CONSTRAINT fk_att_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON DELETE CASCADE;

ALTER TABLE attendance
ADD CONSTRAINT fk_att_lectures
FOREIGN KEY (lecture_id)
REFERENCES lectures(lecture_id)
ON DELETE CASCADE;

ALTER TABLE assignments 
ADD CONSTRAINT fk_ass_modules
FOREIGN KEY (assignment_module)
REFERENCES modules(module_id)
ON DELETE CASCADE;

ALTER TABLE grades
ADD CONSTRAINT fk_gr_assignments
FOREIGN KEY (assignment_id)
REFERENCES assignments(assignment_id)
ON DELETE CASCADE;

ALTER TABLE grades
ADD CONSTRAINT fk_gr_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON DELETE CASCADE;

ALTER TABLE diaries
ADD CONSTRAINT fk_di_staff
FOREIGN KEY (diary_author)
REFERENCES staff(staff_id)
ON DELETE CASCADE;
