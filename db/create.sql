CREATE TABLE rooms (
	room_id			VARCHAR(4) PRIMARY KEY,
	room_type		VARCHAR,
	room_capacity	INTEGER(3)
);

-- this table will probably need changing
CREATE TABLE boundaries (
	boundaries_id		VARCHAR(2) PRIMARY KEY,
	boundaries_range	VARCHAR(6) NOT NULL,
	boundaries_class	VARCHAR(10) NOT NULL
);


-- FKs: module_leader
CREATE TABLE modules (
	module_id		INTEGER(4) PRIMARY KEY,
	module_year		INTEGER(1) NOT NULL,
	module_points	INTEGER(2) NOT NULL,
	module_title	VARCHAR NOT NULL,
	module_as1		INTEGER(3),
	module_as2		INTEGER(3),
	module_exam		INTEGER(3),
	module_leader	INTEGER(8)
);

CREATE TABLE courses (
	course_id			INTEGER(8) PRIMARY KEY,
	course_name			VARCHAR
);

-- courses <=> modules are a many-many relationship. make a junction table
CREATE TABLE course_modules (
	course_id		INTEGER(8),
	module_id		INTEGER(4),
	PRIMARY KEY (course_id, module_id)
);

-- staff_status: 'L' for live or 'D' for dormant
-- staff_status_reason: e.g. retired, resigned, misconduct
CREATE TABLE staff (
	staff_id			INTEGER(8) PRIMARY KEY AUTO_INCREMENT,
	staff_forename		VARCHAR,
	staff_middlenames	VARCHAR,
	staff_surname		VARCHAR,
	staff_role_cl		BOOLEAN,
	staff_role_ml		BOOLEAN,
	staff_role_pt		BOOLEAN,
	staff_address		VARCHAR,
	staff_telephone		VARCHAR,
	staff_email			VARCHAR,
	staff_status		CHAR(1),
	staff_status_reason	VARCHAR,
	staff_specialism	VARCHAR
);

-- FKs: student_course
-- student_status: 'L' for live or 'D' for dormant
-- student_status_reason: e.g. graduated, withdrawn, terminated
-- ## student_id format ## --
-- first digit = century e.g. 2024 == '2', 2124 == '3'
-- 2nd/3rd digit = current year e.g. 2024 == '24', 2025 == '25'
-- 4th-8th digits = increment
-- PL/SQL is cringe, so we're managing ID generation in PHP
-- ## end student_id format ## --
CREATE TABLE students (
	student_id						INTEGER(8) PRIMARY KEY,
	student_forename				VARCHAR,
	student_middlenames				VARCHAR,
	student_surname					VARCHAR,
	student_term_address			VARCHAR,
	student_nonterm_address			VARCHAR,
	student_telephone				VARCHAR,
	student_email					VARCHAR,
	student_status					CHAR(1),
	student_status_reason			VARCHAR,
	student_course					INTEGER(8),
	student_entry_qualifications	VARCHAR
);

-- FKs: module_id, lecture_room
-- lecture_duration: length of lecture in minutes
CREATE TABLE lectures (
	lecture_id			INTEGER(8) PRIMARY KEY,
	module_id			INTEGER(4),
	module_week			INTEGER(2),
	lecture_room		VARCHAR(4),
	lecture_datetime	DATETIME,
	lecture_duration	INTEGER(4),
);

-- FKs: student_id, lecture_id
CREATE TABLE attendance (
	student_id			INTEGER(8),
	lecture_id			INTEGER(8)
	attendance_value	CHAR(1),
	PRIMARY KEY (student_id, lecture_id)
);




-- ALTERS
ALTER TABLE modules
ADD CONSTRAINT fk_mod_staff
FOREIGN KEY (module_leader)
REFERENCES staff(staff_id);

ALTER TABLE course_modules
ADD CONSTRAINT fk_cm_courses
FOREIGN KEY (course_id)
REFERENCES courses(course_id);

ALTER TABLE course_modules
ADD CONSTRAINT fk_cm_modules
FOREIGN KEY (module_id)
REFERENCES modules(module_id);

-- TODO: set up function for student IDs
ALTER TABLE staff AUTO_INCREMENT=99100000;

ALTER TABLE students
ADD CONSTRAINT fk_stu_courses
FOREIGN KEY (student_course)
REFERENCES courses(course_id);

ALTER TABLE lectures
ADD CONSTRAINT fk_lec_modules
FOREIGN KEY (module_id)
REFERENCES modules(module_id);

ALTER TABLE lectures
ADD CONSTRAINT fk_lec_rooms
FOREIGN KEY (lecture_room)
REFERENCES rooms(room_id);

ALTER TABLE attendance
ADD CONSTRAINT fk_att_students
FOREIGN KEY (student_id)
REFERENCES students(student_id);

ALTER TABLE attendance
ADD CONSTRAINT fk_att_lectures
FOREIGN KEY (lecture_id)
REFERENCES lectures(lecture_id);


