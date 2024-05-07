<?php

namespace classes;

class DatabaseHandler
{
	// No thoughts, class empty...
	private $pdo;
	private $primaryKeys;

	public function __construct($pdo)
	{
		$this->pdo = $pdo;

		// name of the primary key column for given tables
		$this->primaryKeys = [
			'students' => 'student_id',
			'staff' => 'staff_id'
		];
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
	public function get($fields, $table, $key, $value)
	{
		$fieldsString = implode(', ', $fields);
		$sql = "SELECT $fieldsString FROM $table WHERE $key = :value";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute(['value' => $value]);

		return $stmt->fetchAll();
	}

	// fetches records for edit pages
	public function editGet($table, $value)
	{
		// password hashes should not be returned
		$wantedFields = [
			'students' => [
				'student_id', 'student_forename', 'student_middle_names',
				'student_surname', 'student_term_address', 'student_nonterm_address',
				'student_telephone', 'student_email', 'student_status',
				'student_status_reason', 'student_course', 'student_entry_qualifications'
			],
			'staff' => [
				'staff_id', 'staff_forename', 'staff_middle_names',
				'staff_surname', 'staff_role_cl', 'staff_role_ml',
				'staff_role_pt', 'staff_address', 'staff_telephone',
				'staff_email', 'staff_status', 'staff_status_reason',
				'staff_specialism'
			]
		];

		$pk = $this->primaryKeys[$table];

		// TODO: add logic to catch invalid PK
		$sql = "SELECT ".implode(', ', $wantedFields[$table])." FROM $table WHERE $pk = $value";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute();

		return $stmt->fetch();
	}

	public function updateRecord($table, $id, $values)
	{
		$set = '';
		foreach ($values as $key => $value) {
			$set = $set . "$key = '$value', ";
		}
		$set = rtrim($set, ', ');

		$pk = $this->primaryKeys[$table];
		$sql = "UPDATE $table SET $set WHERE $pk = :id";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db update succeeds/fails
		return $stmt->execute(['id' => $id]);
	}

	public function updatePassword($table, $id, $newPassword)
	{
		$passwordFields = [
			'students' => 'student_password',
			'staff' => 'staff_password'
		];

		$field = $passwordFields[$table];
		$pk = $this->primaryKeys[$table];
		$sql = "UPDATE $table SET $field = '".password_hash($newPassword, PASSWORD_DEFAULT)."' WHERE $pk = :id";
		$stmt = $this->pdo->prepare($sql);

		// return true/false if db update succeeds/fails
		return $stmt->execute(['id' => $id]);
	}
}


?>
