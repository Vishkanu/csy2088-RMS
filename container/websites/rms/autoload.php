<?php

function autoload($className)
{
	require str_replace('\\', '/', $className) . '.php';
}

spl_autoload_register('autoload');

?>
