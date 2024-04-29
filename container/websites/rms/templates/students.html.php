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
									foreach (array_keys($studentTable[0]) as $field) { ?>
										<th><?=ucwords(str_replace('_',' ',$field));?></th>
									<?php } ?>


                                        <!-- Add more columns here -->
                                    </tr>
                                </thead>
                                <tbody>
									<?php
										foreach ($studentTable as $student) { ?>
											<tr>
											<?php
											foreach ($student as $value) { ?>
												<td><?=$value;?></td>
											<?php } ?>
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
