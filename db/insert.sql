-- password for test user: 1234
INSERT INTO staff (staff_forename, staff_surname, staff_email, staff_password, staff_address)
VALUES ('JOHN', 'SMITH', 'JOHN@SMITH.COM', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', '64 ZOO LANE');

INSERT INTO students (student_id, student_forename, student_surname, student_email, student_status)
VALUES (22400000, 'FOO', 'BAR', 'FOO@BAR.COM', 'L');

--course table:
INSERT INTO `csy2088_as1`.`courses` (`course_id`, `course_name`) 
VALUES ('1', 'Computer Science');

INSERT INTO `csy2088_as1`.`courses` (`course_id`, `course_name`) 
VALUES ('2', 'Software Engineering');

INSERT INTO `csy2088_as1`.`courses` (`course_id`, `course_name`) 
VALUES ('3', 'Medicine');

INSERT INTO `csy2088_as1`.`courses` (`course_id`, `course_name`) 
VALUES ('4', 'Art');

INSERT INTO `csy2088_as1`.`courses` (`course_id`, `course_name`) 
VALUES ('5', 'English Language Studies');

--students table:
INSERT INTO `csy2088_as1`.`students` 
VALUES('22400001', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '075679012','johndoe@gmail.com', 'Currently Studying', '1','A A B');


