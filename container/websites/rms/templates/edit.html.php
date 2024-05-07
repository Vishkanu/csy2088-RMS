<?php
$fieldNames = [];

foreach (array_keys($userRecord) as $key) {
	if (gettype($key) == "string") {
		array_push($fieldNames, $key);
	}
}
?>

<div class="col-md-10 py-4">
<h1>Edit Record</h1>
<?php
// TODO: PRESERVE $_GET VARIABLES ON FORM SUBMISSION
?>
<form method="POST" action="edit?<?=$_SERVER['QUERY_STRING'];?>">
	<label for="<?=$fieldNames[0];?>"><?=ucwords(str_replace('_',' ',$fieldNames[0]));?></label><br>
	<input type="text" id=<?=$fieldNames[0];?> name=<?=$fieldNames[0];?> value="<?=$userRecord[0];?>" readonly><br> <?php
for ($i = 1; $i < sizeof($fieldNames); $i++) { ?>
	<label for="<?=$fieldNames[$i];?>"><?=ucwords(str_replace('_',' ',$fieldNames[$i]));?></label><br>
	<input type="text" id=<?=$fieldNames[$i];?> name=<?=$fieldNames[$i];?> value="<?=$userRecord[$i];?>"><br>
<?php
}
?>
<input type="submit" name="submit">
</form>

<form method="POST" action="edit?<?=$_SERVER['QUERY_STRING'];?>">
	<label for="change_password">Password Reset:</label><br>
	<input type="text" id="change_password" name="change_password"><br>
<input type="submit" name="submit2">
</form>


</div>

