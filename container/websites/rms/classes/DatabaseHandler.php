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
		// Returns array [$was_auth_successful, $authenticated_user_id]
		
		$returnArr = [];

		$sql = "SELECT * FROM staff WHERE staff_email = :value";
		$stmt = $this->pdo->prepare($sql);

		$stmt->execute(['value' => $username]);
		$record = $stmt->fetch();

		// non-existent username
		if ($record === false) {
			return [false, -1];
		}

		return [
			password_verify($password, $record['staff_password']),
			$record['staff_id']
		];
	}
}


?>
