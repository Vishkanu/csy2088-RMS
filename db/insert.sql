-- password for test user: 1234
INSERT INTO staff (staff_forename, staff_surname, staff_email, staff_password, staff_address)
VALUES ('JOHN', 'SMITH', 'JOHN@SMITH.COM', '$2y$10$RJP5nezpfuwIGBTvqm86geJKzrERjdGIqpON8zRhjO7XFnWheywvu', '64 ZOO LANE');

INSERT INTO students (student_id, student_forename, student_surname, student_email, student_status)
VALUES (22400000, 'FOO', 'BAR', 'FOO@BAR.COM', 'L');
