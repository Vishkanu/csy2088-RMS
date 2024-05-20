<?php
// $fieldNames - array of column names requiring user input for insert
?>

<div class="col-md-10 py-4">
<h1>Create Record</h1>
<?php
// TODO: PRESERVE $_GET VARIABLES ON FORM SUBMISSION
?>
<form method="POST" action="create?<?=$_SERVER['QUERY_STRING'];?>">
<?php
for ($i = 0; $i < sizeof($fieldNames); $i++) { ?>
	<label for="<?=$fieldNames[$i];?>"><?=ucwords(str_replace('_',' ',$fieldNames[$i]));?></label><br>
	<input type="text" id=<?=$fieldNames[$i];?> name=<?=$fieldNames[$i];?> value=""><br>
<?php
}
?>
<input type="submit" name="submit" class="btn btn-purple btn-block">
<button type="button" onclick="javascript:history.back()" class="btn btn-purple btn-block" >Go Back</button>
</form>

</div>

