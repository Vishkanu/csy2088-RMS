            <!-- Main Content -->
            <div class="col-md-10 py-4">
                <!-- Main content here -->
                <div class="container table-container">
                    <div class="row justify-content-center"> <!-- Center the table -->
                        <div class="col-md-12">
                            <table class="table">
                                <thead>
									<tr>
									<?php
									foreach (array_keys($dbTable[0]) as $field) { ?>
										<th><?=ucwords(str_replace('_',' ',$field));?></th>
									<?php } ?>


                                        <!-- Add more columns here -->
                                    </tr>
                                </thead>
                                <tbody>
									<?php
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
                                                <td><a href='grades?assignment_id=<?=$row[$primaryKey];?>'>GO</a></td>
                                            <?php
                                            } else {
                                            ?>
                                                <td><a href='edit?table=<?=$tableName;?>&id=<?=$row[$primaryKey];?>'>EDIT</a></td>
											<?php
                                            }
                                            ?>
						
											</tr>
										<?php } ?>
                                </tbody>
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
