<?php
session_start();
//require '../pdo.php';
require '../autoload.php';
require '../loadTemplate.php';

// TODO: db
//$database = new classes\DatabaseHandler($pdo);
$database = '';

// structure it as an array, in case more controllers are implemented later.
$controllers = [
	'rms' => new controllers\RMSController($database)
];

$route = ltrim(explode('?', $_SERVER['REQUEST_URI'])[0], '/');

// use route to determine correct controller
if ($route != '') {
	list($controllerName, $action) = explode('/', $route);
	$page = $controllers[$controllerName]->$action();
}
else {
	// only one controller currently - default to it
	$page = $controllers['rms']->login();
	$route = '/rms';
}

$allowedActions = ['login', 'students'];

if (isset($controllerName) && in_array($action, $allowedActions))
{
	// All pages share an identical <head>
	echo loadTemplate("../templates/head.html.php", [
		'title' => $page['title']
	]);

	if (isset($controllerName) && $action === 'login') {
		echo loadTemplate("../templates/login.html.php", []);
	} else if (isset($controllerName) && $action == 'students') {
		echo loadTemplate("../templates/students.html.php", []);
	}
}
