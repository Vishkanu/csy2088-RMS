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

	// fetches all records from a given table, removing numerical keys
	public function get_all($table)
	{
		$sql = "SELECT * FROM $table";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();

		return $stmt->fetchAll($mode = \PDO::FETCH_ASSOC);
	}

	// generic "SELECT $fields from $table WHERE $key = $value"
	public function get($fields, $table, $key, $value, $fetchMode=\PDO::FETCH_BOTH)
	{
		$fieldsString = implode(', ', $fields);
		$sql = "SELECT $fieldsString FROM $table WHERE $key = :value";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute(['value' => $value]);

		return $stmt->fetchAll($mode = $fetchMode);
	}

	public function updateRecord($table, $values, $pk, $id)
	{
		$set = '';
		foreach ($values as $key => $value) {
			$set = $set . "$key = '$value', ";
		}
		$set = rtrim($set, ', ');

		$sql = "UPDATE $table SET $set WHERE $pk = :id";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db update succeeds/fails
		return $stmt->execute(['id' => $id]);
	}

	public function updatePassword($table, $newPassword, $pk, $id)
	{
		$passwordFields = [
			'students' => 'student_password',
			'staff' => 'staff_password'
		];

		$field = $passwordFields[$table];
		$sql = "UPDATE $table SET $field = '".password_hash($newPassword, PASSWORD_DEFAULT)."' WHERE $pk = :id";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db update succeeds/fails
		return $stmt->execute(['id' => $id]);
	}
}


?>
