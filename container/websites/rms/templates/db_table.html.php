<?php
// Variables:
// $dbTable - result set from database query, to be displayed in the table.
// $currentPage - page string. used to highlight the current page in the navbar.
// $tableName - name of table being displayed. needed for hyperlinks.
// $primaryKey - name of PK column in displayed table. needed for hyperlinks e.g. edit button
// $insertTableName - name of table to insert into when add button is pressed. If unset, add button will not appear.
?>
			<!-- Main Content -->
            <div class="col-md-10 py-4">
                <!-- Main content here -->
                <div class="container table-container">
                    <div class="row justify-content-center"> <!-- Center the table -->
                        <div class="col-md-12">
							<table class="table">
							<?php
							if (isset($dbTable[0])) {
							?>
                                <thead>
									<tr>
									<?php
									foreach (array_keys($dbTable[0]) as $field) { ?>
										<th><?=ucwords(str_replace('_',' ',$field));?></th>
									<?php } ?>


                                        <!-- Add more columns here -->
                                    </tr>
								</thead>
								<?php
								}
								?>
								<tbody>
									<?php
									// Display add record button appropriately, where necessary.
									if (isset($insertTableName) && $currentPage == 'page_course_modules') {
									?>
									<a href="create?table=<?=$insertTableName;?>&course_id=<?=$_GET['course_id'];?>">ADD RECORD</a>
									<?php
									}
									else if (isset($insertTableName)) {
									?>
										<a href="create?table=<?=$insertTableName;?>">ADD RECORD</a>
									<?php
									}

							if (isset($dbTable[0])) {
										foreach ($dbTable as $row) { ?>
											<tr>
											<?php
											foreach ($row as $value) { ?>
												<td><?=$value;?></td>
											<?php } 
											if ($currentPage == 'page_attendance') {
                                            ?>
                                                <!-- lectures PK here is used to search for FK in attendance table -->
                                                <td><a href='attendance_register?lecture_id=<?=$row[$primaryKey];?>'>GO</a></td>
                                            <?php
                                            } else if ($currentPage == 'page_assignments') {
                                            ?>
												<td>
													<a href='grades?assignment_id=<?=$row[$primaryKey];?>'>GO</a>
													<a href='delete?table=<?=$tableName;?>&id=<?=$row[$primaryKey];?>'>DELETE</a>
												</td>
                                            <?php
                                            } else if ($currentPage == 'page_courses') {
                                            ?>
												<td>
													<a href='course_modules?course_id=<?=$row[$primaryKey];?>'>GO</a>
													<a href='delete?table=<?=$tableName;?>&id=<?=$row[$primaryKey];?>'>DELETE</a>
												</td>
                                            <?php
                                            } else if ($currentPage == 'page_personal_tutors') {
                                            ?>
                                                <td><a href='tutees?staff_id=<?=$row[$primaryKey];?>'>GO</a></td>
                                            <?php
                                            } else {
                                            ?>
												<td>
													<a href='edit?table=<?=$tableName;?>&id=<?=$row[$primaryKey];?>'>EDIT</a>
													<a href='delete?table=<?=$tableName;?>&id=<?=$row[$primaryKey];?>'>DELETE</a>
												</td>
											<?php
                                            }
                                            ?>
						
											</tr>
										<?php } ?>
								</tbody>
								<?php
								}
								?>
                            </table>
                        </div>
                    </div>
                </div>


                <div class="container bottom-bar bg-light">
                    <div class="row">
                        <div class="col text-center">
                            <button id="first-page" class="btn btn-primary">First Page</button>
                        </div>
                        <div class="col text-center">
                            <button id="prev-page" class="btn btn-primary">Previous</button>
                        </div>
                        <div class="col text-center">
                            <span id="page-number">Page 1</span>
                        </div>
                        <div class="col text-center">
                            <button id="next-page" class="btn btn-primary">Next</button>
                        </div>
                        <div class="col text-center">
                            <button id="last-page" class="btn btn-primary">Last Page</button>
                        </div>
                    </div>
                </div>



            </div>
        </div>
    </div>
