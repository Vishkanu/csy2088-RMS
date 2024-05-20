<?php
// $fieldNames - array of column names requiring user input for insert
?>

<div class="col-md-10 py-4">
<h1>Create Record</h1>
<?php
// TODO: PRESERVE $_GET VARIABLES ON FORM SUBMISSION
?>

<div class="container mt-5">
    <form method="POST" action="create?<?= $_SERVER['QUERY_STRING']; ?>">
        <div class="row">
            <?php
            for ($i = 0; $i < sizeof($fieldNames); $i++) { ?>
                <div class="col-md-6 mb-3">
                    <label for="<?= $fieldNames[$i]; ?>"><?= ucwords(str_replace('_', ' ', $fieldNames[$i])); ?></label>
                    <input type="text" id="<?= $fieldNames[$i]; ?>" name="<?= $fieldNames[$i]; ?>" class="form-control" value="">
                </div>
            <?php } ?>
        </div>
        <div class="form-group text-center">
            <input type="submit" name="submit" class="btn btn-purple">
            <button type="button" onclick="javascript:history.back()" class="btn btn-purple">Go Back</button>
        </div>
    </form>
</div>

</div>

