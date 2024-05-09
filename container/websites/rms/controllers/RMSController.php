<?php
namespace controllers;

class RMSController
{
	// No thoughts, class empty...
	private $db;
	private $editData;

	public function __construct($db)
	{
		$this->db = $db;

		$this->editData = [
			'students' => [
				// fields wanted from the db
				'wantedFields' => [
					'student_id', 'student_forename', 'student_middle_names',
					'student_surname', 'student_term_address', 'student_nonterm_address',
					'student_telephone', 'student_email', 'student_status',
					'student_status_reason', 'student_course', 'student_entry_qualifications'
				],
				// options for input fields on edit forms (some are readonly)
				'inputOpts' => ['readonly', '', '', '', '', '', '', '', '', '', '', ''],
				// does this table need the password reset form on the edit page?
				'hasPassword' => true,
				'primaryKey' => 'student_id'
			],
			'staff' => [
				'wantedFields' => [
					'staff_id', 'staff_forename', 'staff_middle_names',
					'staff_surname', 'staff_role_cl', 'staff_role_ml',
					'staff_role_pt', 'staff_address', 'staff_telephone',
					'staff_email', 'staff_status', 'staff_status_reason',
					'staff_specialism'
				],
				'inputOpts' => ['readonly', '', '', '', '', '', '', '', '', '', '', '', ''],
				'hasPassword' => true,
				'primaryKey' => 'staff_id'
			],
			'attendance' => [
				'wantedFields' => [
					'attendance_id', 'student_id', 'lecture_id',
					'attendance_value'
				],
				'inputOpts' => ['readonly', 'readonly', 'readonly', ''],
				'hasPassword' => false,
				// we're searching by FK lecture_id here, instead of PK
				'primaryKey' => 'attendance_id'
			],
			'grades' => [
				'wantedFields' => [
					'grade_id', 'assignment_id', 'student_id',
					'grade_value'
				],
				'inputOpts' => ['readonly', 'readonly', 'readonly', ''],
				'hasPassword' => false,
				'primaryKey' => 'grade_id'
			]
		];
	}

	public function login()
	{
		$returnArr = ['title' => 'Woodlands University: Staff RMS Login'];

		// authentication logic
		if (isset($_SESSION['auth_id'])) {
			// already authenticated
			header('Location: /rms/students');
		}
		else if (isset($_POST['username']) && isset($_POST['password'])) {
			$auth = $this->db->authenticate_staff($_POST['username'], $_POST['password'], 'staff');
			if (isset($auth['auth_success']) && $auth['auth_success'] === true) {
				// auth success!
				$_SESSION['auth_id'] = $auth['staff_id'];
				$_SESSION['lastlogged'] = $auth['lastlogged'];
				$_SESSION['auth_name'] = $auth['auth_name'];
				header('Location: /rms/students');
			}
			else {
				$returnArr['auth_failed'] = true;
			}
		}

		return $returnArr;
	}

	public function logout()
	{
		session_destroy();
		header('Location: /rms/login');
	}

	public function home()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		return [
			'title' => 'Woodlands University - Records Management System - Dashboard',
			'currentPage' => 'page_home'
		];
	}

	public function students()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		// remove unwanted fields from the table + substitute FKs for strings
		$dbTable = $this->db->get_all('students');
		$newTable = [];
		foreach ($dbTable as $row) {
			unset($row['student_password']);

			// catch empty array
			$course = $this->db->get(['course_name'], 'courses', 'course_id', $row['student_course']);
			if (empty($course)) {
				$course = '';
			} else {
				$course = $course[0]['course_name'];
			}

			$row['student_course'] = $course;
			array_push($newTable, $row);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Students',
			'currentPage' => 'page_students',
			'primaryKey' => 'student_id',
			'tableName' => 'students',
			'dbTable' => $newTable
		];
	}

	public function staff()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		// remove unwanted fields from the table
		$dbTable = $this->db->get_all('staff');
		$newTable = [];
		foreach ($dbTable as $row) {
			unset($row['staff_password']);
			array_push($newTable, $row);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Staff',
			'currentPage' => 'page_staff',
			'primaryKey' => 'staff_id',
			'tableName' => 'staff',
			'dbTable' => $newTable
		];
	}

	public function edit()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		} else if (!isset($_GET['table']) || !isset($_GET['id'])) {
			header('Location: /rms/home');
		}

		// record update logic
		if (isset($_POST['submit'])) {
			unset($_POST['submit']);
			$this->db->updateRecord($_GET['table'], $_POST, $this->editData[$_GET['table']]['primaryKey'], $_GET['id']);
			unset($_POST);
		}

		// password update logic
		if (isset($_POST['submit2'])) {
			$this->db->updatePassword($_GET['table'], $_POST['change_password'], $this->editData[$_GET['table']]['primaryKey'], $_GET['id']);
			unset($_POST);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Edit Record',
			'currentPage' => 'page_edit',
			'inputOpts' => $this->editData[$_GET['table']]['inputOpts'],
			'hasPassword' => $this->editData[$_GET['table']]['hasPassword'],
			'userRecord' => $this->db->get($this->editData[$_GET['table']]['wantedFields'], $_GET['table'], $this->editData[$_GET['table']]['primaryKey'], $_GET['id'])[0]
		];
	}

	// annoyingly named - attendance page DOES NOT call attendance table. It calls lectures table
	public function attendance()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		return [
			'title' => 'Woodlands University - Records Management System - Attendance',
			'currentPage' => 'page_attendance',
			'tableName' => 'attendance',
			'primaryKey' => 'lecture_id',
			'dbTable' => $this->db->get_all('lectures')
		];
	}

	public function attendance_register()
	{
		$lectureRegister = $this->db->get($this->editData['attendance']['wantedFields'], 'attendance', 'lecture_id', $_GET['lecture_id'], \PDO::FETCH_ASSOC);
		$newRegister = [];

		foreach ($lectureRegister as $row) {
			// remove unwanted data
			unset($row['lecture_id']);

			// use student_id to fetch and append name of student to the results
			$name = implode(' ', $this->db->get(['student_forename', 'student_surname'], 'students', 'student_id', $row['student_id'], \PDO::FETCH_ASSOC)[0]);

			$newRow = [
				'attendance_id' => $row['attendance_id'],
				'student_id' => $row['student_id'],
				'student_name' => $name,
				'attendance_value' => $row['attendance_value']
			];


			array_push($newRegister, $newRow);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Attendance Register',
			'currentPage' => 'page_attendance_register',
			'tableName' => 'attendance',
			'primaryKey' => 'attendance_id',
			'dbTable' => $newRegister
		];
	}

	public function assignments()
	{
		return [
			'title' => 'Woodlands University - Records Management System - Assignments',
			'currentPage' => 'page_assignments',
			'tableName' => 'assignments',
			'primaryKey' => 'assignment_id',
			'dbTable' => $this->db->get_all('assignments')
		];
	}

	public function grades()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		} else if (!isset($_GET['assignment_id'])) {
			header('Location: /rms/home');
		}

		// SELECT grades that are from the desired assignment
		$dbTable = $this->db->get(['grade_id', 'student_id', 'grade_value'], 'grades', 'assignment_id', $_GET['assignment_id']);
		$newTable = [];

		foreach ($dbTable as $row) {
			// use student_id to fetch and append name of student to the results
			$name = implode(' ', $this->db->get(['student_forename', 'student_surname'], 'students', 'student_id', $row['student_id'], \PDO::FETCH_ASSOC)[0]);
			$newRow = [
				'grade_id' => $row['grade_id'],
				'student_id' => $row['student_id'],
				'student_name' => $name,
				'grade_value' => $row['grade_value']
			];
			array_push($newTable, $newRow);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Assignment Grades',
			'currentPage' => 'page_grades',
			'tableName' => 'grades',
			'primaryKey' => 'grade_id',
			'dbTable' => $newTable
		];
	}
}


?>
