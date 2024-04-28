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
			if ($auth[0] === true) {
				// auth success!
				$_SESSION['auth_id'] = $auth[1];
				header('Location: /rms/students');
			}
			else {
				$returnArr['auth_failed'] = true;
			}
		}

		return $returnArr;
	}

	public function students()
	{
		return [
			'title' => 'Woodlands University - Records Management System'
		];
	}
}


?>
