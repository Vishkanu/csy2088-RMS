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
		return [
			'title' => 'Woodlands University: Staff RMS Login'
		];
	}

	public function students()
	{
		return [
			'title' => 'Woodlands University - Records Management System'
		];
	}
}


?>

