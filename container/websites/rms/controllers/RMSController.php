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
			if ($auth['auth_success'] === true) {
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

	public function students()
	{
		if (!isset($_SESSION['auth_id'])) {
			header('Location: /rms/login');
		}

		return [
			'title' => 'Woodlands University - Records Management System - Students'
		];
	}
}


?>
