<?php
session_start();
require '../pdo.php';
require '../autoload.php';
require '../loadTemplate.php';

// TODO: db
$database = new classes\DatabaseHandler($pdo);
//$database = '';

// structure it as an array, in case more controllers are implemented later.
$controllers = [
	'rms' => new controllers\RMSController($database)
];

$route = ltrim(explode('?', $_SERVER['REQUEST_URI'])[0], '/');

// use route to determine correct controller
if ($route == '') {
	// only one controller currently - default to it
	header('Location: /rms/login');

	//$route = 'rms/login';
	//list($controllerName, $action) = explode('/', $route);
	//$page = $controllers[$controllerName]->$action();
}
else {
	list($controllerName, $action) = explode('/', $route);
	$page = $controllers[$controllerName]->$action();
}

$allowedActions = ['login', 'students', 'home'];

if (isset($controllerName) && in_array($action, $allowedActions))
{
	// All pages share an identical <head>
	echo loadTemplate("../templates/head.html.php", [
		'title' => $page['title']
	]);

	echo loadTemplate("../templates/$action.html.php", $page);

	#if (isset($controllerName) && $action === 'login') {
	#	echo loadTemplate("../templates/login.html.php", []);
	#} else if (isset($controllerName) && $action == 'students') {
	#	echo loadTemplate("../templates/students.html.php", []);
	#}
}
