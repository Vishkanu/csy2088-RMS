-- password for test user: 1234
INSERT INTO staff (staff_id, staff_forename, staff_surname, staff_role_pt, staff_email, staff_password, staff_address)
VALUES (99100000, 'JOHN', 'SMITH', true, 'JOHN@SMITH.COM', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', '64 ZOO LANE');

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

-- students table:
INSERT INTO `csy2088_as1`.`students` 
VALUES('22400001', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '07567901245','johndoe@gmail.com', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', 'L', NULL, 1, 'A A B', 99100000);

INSERT INTO `csy2088_as1`.`students` 
VALUES('22400002', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '07567901245','johndoe@gmail.com', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', 'L', NULL, 1, 'A A B', 99100000);

INSERT INTO `csy2088_as1`.`students` 
VALUES('22400003', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '07567901245','johndoe@gmail.com', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', 'L', NULL, 1, 'A A B', 99100000);

INSERT INTO `csy2088_as1`.`students` 
VALUES('22400004', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '07567901245','johndoe@gmail.com', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', 'L', NULL, 1, 'A A B', 99100000);

INSERT INTO `csy2088_as1`.`students` 
VALUES('22400005', 'John', 'Long', 'Doe', '89 Grange Park', '90 Park Lane',  '07567901245','johndoe@gmail.com', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', 'L', NULL, 1, 'A A B', 99100000);

-- modules table
INSERT INTO modules
VALUES ('C1001', 1, 20, 'Fundamentals of Computer Science', 50, 50, NULL, 99100000);

INSERT INTO modules
VALUES ('C1002', 1, 20, 'Fundamentals of Computer Science - Continued', 50, NULL, 50, 99100000);

INSERT INTO modules
VALUES ('C1003', 1, 20, 'Software Engineering Fundamentals', 50, NULL, 50, 99100000);

INSERT INTO modules
VALUES ('C2001', 1, 20, 'Bleeps and Bloops - An Introduction', NULL, 50, 50, 99100000);

INSERT INTO modules
VALUES ('C2002', 1, 20, 'Advanced Bleeps and Bloops', 50, NULL, 50, 99100000);

INSERT INTO modules
VALUES ('C3001', 1, 20, 'Internet of Things', NULL, NULL, 100, 99100000);

INSERT INTO modules
VALUES ('C3002', 1, 20, 'Buzzword Engineering', NULL, NULL, 100, 99100000);

-- course_modules table
INSERT INTO course_modules
VALUES (1, 'C1001');

INSERT INTO course_modules
VALUES (1, 'C1002');

INSERT INTO course_modules
VALUES (2, 'C1003');

INSERT INTO course_modules
VALUES (1, 'C2001');

INSERT INTO course_modules
VALUES (1, 'C2002');

INSERT INTO course_modules
VALUES (1, 'C3001');

INSERT INTO course_modules
VALUES (1, 'C3002');

-- rooms table
INSERT INTO rooms
VALUES ('C1', 'Computer Lab', 30);

INSERT INTO rooms
VALUES ('C2', 'Computer Lab', 30);

INSERT INTO rooms
VALUES ('C3', 'Computer Lab', 30);

-- lectures table
INSERT INTO lectures
VALUES (10000001, 'C1001', 1, 'C1', '2024-05-08 10:00:00', 180);

INSERT INTO lectures
VALUES (10000002, 'C1002', 1, 'C2', '2024-05-08 13:30:00', 180);

INSERT INTO lectures
VALUES (10000003, 'C2001', 1, 'C3', '2024-05-08 10:00:00', 180);

INSERT INTO lectures
VALUES (10000004, 'C2002', 1, 'C3', '2024-05-08 13:30:00', 180);

-- attendance table
INSERT INTO attendance
VALUES
(30000001, 22400001, 10000001, 'O'),
(30000002, 22400001, 10000002, 'X'),
(30000003, 22400002, 10000003, 'X'),
(30000004, 22400002, 10000004, 'O'),
(30000005, 22400002, 10000001, 'O');

-- assignments table
INSERT INTO assignments
VALUES
(40000001, 'AS1 - Intro Project', 'C1001'),
(40000002, 'AS2 - Second Project', 'C1001');

--- grades table
INSERT INTO grades
VALUES
(50000001, 40000001, 22400001, 'A+'),
(50000002, 40000002, 22400001, 'B+');

-- diaries table
INSERT INTO diaries
VALUES
(60000001, 99100000, current_timestamp, 'This is a diary entry'),
(60000002, 99100000, current_timestamp, 'This is another diary entry'),
(60000003, 99100000, current_timestamp, 'This is yet another diary entry');

