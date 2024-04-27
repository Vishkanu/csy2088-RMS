<?php

function loadTemplate($filename, $tVars)
{
	extract($tVars);
	ob_start();
	require $filename;
	$contents = ob_get_clean();
	return $contents;
}

?>
