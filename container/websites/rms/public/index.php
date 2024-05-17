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
if ( in_array($route, ['', 'rms', 'rms/']) ) {
	// only one controller currently - default to it
	header('Location: /rms/login');
}
else {
	list($controllerName, $action) = explode('/', $route);
	$page = $controllers[$controllerName]->$action();
}

if (isset($controllerName) && $action == 'login')
{
	// Login page has different layout to RMS interface
	echo loadTemplate("../templates/head.html.php", $page);
	echo loadTemplate("../templates/login.html.php", $page);
}
else
{
	$page['templateName'] = $action;
	echo loadTemplate("../templates/layout.html.php", $page);
}

