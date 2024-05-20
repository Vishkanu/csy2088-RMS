<?php
// $userRecord - database record retrieved using data in $_GET
// $fieldNames - array to contain strings for each column in $userRecord
// $inputOpts - additional options for input fields e.g. some will be readonly for certain tables
// $hasPassword - show password reset form if applicable for the table


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
	<form method="POST" action="edit?<?= $_SERVER['QUERY_STRING']; ?>">
		<?php
		for ($i = 0; $i < sizeof($fieldNames); $i++) { ?>
			<div class="col-md-6 mb-3">
				<label for="<?= $fieldNames[$i]; ?>"><?= ucwords(str_replace('_', ' ', $fieldNames[$i])); ?></label>
				<input type="text" id="<?= $fieldNames[$i]; ?>" name="<?= $fieldNames[$i]; ?>" class="form-control"
					value="<?= $userRecord[$i]; ?>" <?= $inputOpts[$i]; ?>>
			</div>
			<?php
		}
		?>
		<div class="form-group text-center">
			<input type="submit" name="submit" class="btn btn-purple btn-block">
			<button type="button" onclick="javascript:history.back()" class="btn btn-purple btn-block">Go Back</button>
		</div>

	</form>

	<?php
	if (isset($hasPassword) && $hasPassword == true) {
		?>
		<form method="POST" action="edit?<?= $_SERVER['QUERY_STRING']; ?>">
			<label for="change_password">Password Reset:</label><br>
			<input type="text" id="change_password" name="change_password" class="btn btn-purple btn-block"><br>
			<input type="submit" name="submit2" class="btn btn-purple btn-block">
		</form>
		<?php
	}
	?>


</div>