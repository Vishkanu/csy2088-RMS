<?php
namespace controllers;

class RMSController
{
	// No thoughts, class empty...
	private $db;

	public function __construct($db)
	{
		$this->db = $db;
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

		return [
			'title' => 'Woodlands University - Records Management System - Students',
			'currentPage' => 'page_students',
			'primaryKey' => 'student_id',
			'tableName' => 'students',
			'dbTable' => $this->db->get_all('students')
		];
	}

	public function staff()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		// remove staff_password from the table
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
			$this->db->updateRecord($_GET['table'], $_GET['id'], $_POST);
			unset($_POST);
		}

		// password update logic
		if (isset($_POST['submit2'])) {
			$this->db->updatePassword($_GET['table'], $_GET['id'], $_POST['change_password']);
			unset($_POST);
		}

		return [
			'title' => 'Woodlands University - Records Management System - Edit Record',
			'currentPage' => 'page_edit',
			'userRecord' => $this->db->get($_GET['table'], $_GET['id'])
		];

	}
}


?>
