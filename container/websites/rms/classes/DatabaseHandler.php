<?php

namespace classes;

class DatabaseHandler
{
	// No thoughts, class empty...
	private $pdo;

	public function __construct($pdo)
	{
		$this->pdo = $pdo;
	}

	public function authenticate_staff($username, $password)
	{
		// Returns array [$was_auth_successful, $authenticated_user_id, $last_login_datetime]
		
		$sql = "SELECT * FROM staff WHERE staff_email = :value";
		$stmt = $this->pdo->prepare($sql);

		$stmt->execute(['value' => $username]);
		$record = $stmt->fetch();

		// non-existent username
		if ($record === false) {
			return [false, -1];
		}

		// update date
		$sql = "UPDATE staff SET staff_lastlogged = NOW() WHERE staff_id = :id";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute(['id' => $record['staff_id']]);

		return [
			'auth_success' => password_verify($password, $record['staff_password']),
			'staff_id' => $record['staff_id'],
			'lastlogged' => $record['staff_lastlogged'],
			'auth_name' => ucwords(strtolower($record['staff_forename'] . ' ' . $record['staff_surname']))
		];
	}
}


?>
