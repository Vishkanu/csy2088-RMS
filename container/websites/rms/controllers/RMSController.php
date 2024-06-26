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
		
		// WARNING: changes to database schema will likely require updates to this array!
		$this->editData = [
			'students' => [
				// fields wanted from the db
				'wantedFields' => [
					'student_id', 'student_forename', 'student_middle_names',
					'student_surname', 'student_term_address', 'student_nonterm_address',
					'student_telephone', 'student_email', 'student_status',
					'student_status_reason', 'student_course', 'student_entry_qualifications',
					'student_personal_tutor'
				],
				// options for input fields on edit forms (some are readonly)
				'inputOpts' => ['readonly', '', '', '', '', '', '', '', '', '', '', '', ''],
				// does this table need the password reset form on the edit page?
				'hasPassword' => true,
				'primaryKey' => 'student_id',
				'returnPage' => 'students',
				'insertFields' => [
					'student_forename', 'student_middle_names', 'student_surname',
					'student_term_address', 'student_nonterm_address', 'student_telephone',
					'student_email', 'student_status', 'student_status_reason',
					'student_course', 'student_entry_qualifications', 'student_personal_tutor'
				]
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
				'primaryKey' => 'staff_id',
				'returnPage' => 'staff',
				'insertFields' => [
					'staff_forename', 'staff_middle_names',	'staff_surname',
					'staff_role_cl', 'staff_role_ml', 'staff_role_pt',
					'staff_address', 'staff_telephone', 'staff_email',
					'staff_status', 'staff_status_reason', 'staff_specialism'
				]
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
			'lectures' => [
				'insertFields' => [
					'module_id', 'module_week', 'lecture_room',
					'lecture_datetime', 'lecture_duration'
				],
				'returnPage' => 'attendance',
			],
			'grades' => [
				'wantedFields' => [
					'grade_id', 'assignment_id', 'student_id',
					'grade_value'
				],
				'inputOpts' => ['readonly', 'readonly', 'readonly', ''],
				'hasPassword' => false,
				'primaryKey' => 'grade_id'
			],
			'courses' => [
				'insertFields' => [
					'course_name'
				],
				'returnPage' => 'courses',
			],
			'modules' => [
				'wantedFields' => [
					'module_id', 'module_year', 'module_points',
					'module_title', 'module_as1', 'module_as2',
					'module_exam', 'module_leader'
				],
				'inputOpts' => ['readonly', '', '', '', '', '', '', ''],
				'hasPassword' => false,
				'primaryKey' => 'module_id',
				'returnPage' => 'modules',
				'insertFields' => [
					'module_id', 'module_year', 'module_points',
					'module_title', 'module_as1', 'module_as2',
					'module_exam', 'module_leader'
				]
			],
			'course_modules' => [
				'insertFields' => [
					'module_id'
				],
				'returnPage' => 'attendance',
			],
			'assignments' => [
				'insertFields' => [
					'assignment_name', 'assignment_module'
				],
				'returnPage' => 'assignments',
			],
			'diaries' => [
				'wantedFields' => [
					'diary_id', 'diary_content'
				],
				'inputOpts' => ['readonly', ''],
				'hasPassword' => false,
				'primaryKey' => 'diary_id',
				'returnPage' => 'diaries',
				'insertFields' => [
					'diary_content'
				]
			]
		];
	}

	public function __call($name, $arguments)
	{
		if (!method_exists($this, $name)) {
			header('Location: /rms/home');
		}
	}

	public function login()
	{
		$returnArr = ['title' => 'Woodlands University: Staff RMS Login'];

		// authentication logic
		if (isset($_SESSION['auth_id'])) {
			// already authenticated
			header('Location: /rms/home');
		}
		else if (isset($_POST['username']) && isset($_POST['password'])) {
			$auth = $this->db->authenticate_staff($_POST['username'], $_POST['password'], 'staff');
			if (isset($auth['auth_success']) && $auth['auth_success'] === true) {
				// auth success!
				$_SESSION['auth_id'] = $auth['staff_id'];
				$_SESSION['lastlogged'] = $auth['lastlogged'];
				$_SESSION['auth_name'] = $auth['auth_name'];
				header('Location: /rms/home');
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
			'insertTableName' => 'students',
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
			'insertTableName' => 'staff',
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

	// adds data to database insert that will NOT be entered by the user
	private function silentInserts()
	{
		if ($_GET['table'] == 'diaries') {
			$_POST['diary_author'] = $_SESSION['auth_id'];
			return 'diaries';
		}
		else if ($_GET['table'] == 'course_modules') {
			$_POST['course_id'] = $_GET['course_id'];
			return 'attendance';
		}
	}

	public function create()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		} else if (!isset($_GET['table'])) {
			header('Location: /rms/home');
		}

		// record insert logic
		if (isset($_POST['submit'])) {
			unset($_POST['submit']);
			$this->silentInserts();
			$this->db->insertRecord($_GET['table'], $_POST);
			$returnRoute = $this->editData[$_GET['table']]['returnPage'];
			unset($_POST);
			// return to appropriate page after insert
			header("Location: /rms/$returnRoute");
		}

		return [
			'title' => 'Woodlands University - Records Management System - Create Record',
			'currentPage' => 'page_create',
			'fieldNames' => $this->editData[$_GET['table']]['insertFields']
		];
	}

	public function delete()
	{
		$table = $_GET['table'];
		$pk = $this->editData[$table]['primaryKey'];

		$this->db->deleteRecord($table, $pk, $_GET['id']);
		
		$returnRoute = $this->editData[$_GET['table']]['returnPage'];
		header("Location: /rms/$returnRoute");
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
			'insertTableName' => 'lectures',
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
			'insertTableName' => 'assignments',
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

	public function courses()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		$dbTable = $this->db->get_all('courses');

		return [
			'title' => 'Woodlands University - Records Management System - Courses',
			'currentPage' => 'page_courses',
			'tableName' => 'courses',
			'primaryKey' => 'course_id',
			'insertTableName' => 'courses',
			'dbTable' => $dbTable
		];
	}

	public function modules()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		$dbTable = $this->db->get_all('modules');

		return [
			'title' => 'Woodlands University - Records Management System - Modules',
			'currentPage' => 'page_modules',
			'tableName' => 'modules',
			'primaryKey' => 'module_id',
			'insertTableName' => 'modules',
			'dbTable' => $dbTable
		];
	}

	public function course_modules()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		} else if (!isset($_GET['course_id'])) {
			header('Location: /rms/home');
		}

		$dbTable = $this->db->cm_get($_GET['course_id']);

		return [
			'title' => 'Woodlands University - Records Management System - Course Modules',
			'currentPage' => 'page_course_modules',
			'tableName' => 'modules',
			'primaryKey' => 'module_id',
			'insertTableName' => 'course_modules',
			'dbTable' => $dbTable
		];
	}

	public function personal_tutors()
	{
		// redirects - need to be logged in; need appropriate $_GET vars set
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		// remove unwanted fields from table
		$dbTable = $this->db->get(['*'], 'staff', 'staff_role_pt', 1, \PDO::FETCH_ASSOC);
		$newTable = [];
		foreach ($dbTable as $row) {
			unset($row['staff_password']);
			array_push($newTable, $row);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Personal Tutors',
			'currentPage' => 'page_personal_tutors',
			'tableName' => 'students',
			'primaryKey' => 'staff_id',
			'dbTable' => $newTable
		];
	}

	public function tutees()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		} else if (!isset($_GET['staff_id'])) {
			header('Location: /rms/home');
		}

		// remove unwanted fields from the table + substitute FKs for strings
		$dbTable = $this->db->get(['*'], 'students', 'student_personal_tutor', $_GET['staff_id'], \PDO::FETCH_ASSOC);
		$newTable = [];
		foreach ($dbTable as $row) {
			unset($row['student_password']);
			unset($row['student_personal_tutor']);

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
			'title' => 'Woodlands University - Records Management System - Tutees',
			'currentPage' => 'page_tutees',
			'primaryKey' => 'student_id',
			'tableName' => 'students',
			'dbTable' => $newTable
		];
	}

	public function diaries()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		$dbTable = $this->db->get(['diary_id', 'diary_date', 'diary_content'], 'diaries', 'diary_author', $_SESSION['auth_id'], \PDO::FETCH_ASSOC);

		return [
			'title' => 'Woodlands University - Records Management System - Diaries',
			'currentPage' => 'page_diaries',
			'primaryKey' => 'diary_id',
			'tableName' => 'diaries',
			'insertTableName' => 'diaries',
			'dbTable' => $dbTable
		];
	}
}


?>
