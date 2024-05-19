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

	// version of get for course_modules - calling a nested query on modules table due to db design
	public function cm_get($course_id, $fetchMode=\PDO::FETCH_ASSOC)
	{
		$sql = "SELECT * FROM modules WHERE module_id IN (SELECT module_id FROM course_modules WHERE course_id = $course_id)";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();

		return $stmt->fetchAll($mode = $fetchMode);
	}

	public function updateRecord($table, $values, $pk, $id)
	{
		$set = '';

		// TODO: see if there is a more elegant solution than this string manipulation bodge
		foreach ($values as $key => $value) {
			// make empty strings NULL, trying to set a numerical field to an empty string raises - you guessed it - an SQL exception
			if ($value == '' || $value == 0) {
				$set = $set . "$key = NULL, ";
			}
			// don't place numeric values in quotes - SQL exception
			else if (is_numeric($value)) {
				$set = $set . "$key = $value, ";
			}
			else {
				$set = $set . "$key = '$value', ";
			}
		}
		$set = rtrim($set, ', ');

		$sql = "UPDATE $table SET $set WHERE $pk = :id";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db update succeeds/fails
		return $stmt->execute(['id' => $id]);
	}

	// check that student id prefix is correct, change db AUTO_INCREMENT if not
	private function studentIncrementCheck()
	{
		$date21st = new \DateTime('2000-01-01 00:00:00');
		$dateNow = new \DateTime();
		$dateDiff = date_diff($date21st, $dateNow);
		$centuryDiff = $dateDiff->format('%y')/100;

		$count = 2;
		while ($centuryDiff >= 1.0) {
			$count++;
			$centuryDiff--;
		}

		$studentIdPrefix = $count . $dateNow->format('y') . '00000';

		$sql = "ALTER TABLE students AUTO_INCREMENT=" . $studentIdPrefix;
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
	}

	// insert record, hashing the values where the key includes the string 'password'
	public function insertRecord($table, $values)
	{
		$keyString = '';
		$valString = '';

		if ($table == 'students') {
			$this->studentIncrementCheck();
		}

		foreach ($values as $key => $value) {
			$keyString = $keyString . "$key, ";

			// make empty strings NULL, trying to set a numerical field to an empty string raises - you guessed it - an SQL exception
			if ($value == '' || $value == 0) {
				$valString = $valString . "NULL, ";
			}
			// don't place numeric values in quotes - SQL exception
			else if (is_numeric($value)) {
				$valString = $valString . "$value, ";
			}
			// hash value if key contains 'password'
			else if (str_contains($key, 'password')) {
				$hashedValue = password_hash($key, PASSWORD_DEFAULT);
				$valString = $valString . "'$hashedValue', ";
			}
			else {
				$valString = $valString . "'$value', ";
			}
		}
		$keyString = rtrim($keyString, ', ');
		$valString = rtrim($valString, ', ');

		$sql = "INSERT INTO $table ($keyString) VALUES ($valString)";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db insert succeeds/fails
		return $stmt->execute();
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

	// generic DELETE FROM $table WHERE $id = $value function
	public function deleteRecord($table, $id, $value)
	{
		if (!is_numeric($value)) {
			$sql = "DELETE FROM $table WHERE $id = '$value'";
		}
		else {
			$sql = "DELETE FROM $table WHERE $id = $value";
		}

		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();
	}
}


?>
