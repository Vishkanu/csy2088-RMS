<?php

// Configures and creates database connection.

$server = 'mysql';
$schema = 'csy2088_as1';
$username = 'student';
$password = 'student';

$pdo = new PDO('mysql:dbname=' . $schema . ';host=' . $server, $username, $password);

?>
