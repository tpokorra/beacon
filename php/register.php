<?php
/*
 * Register Script
 */

session_start();

require_once ('settings.php');
require_once("lib/BeaconMySQL.php");

$beacon_db_instance = NULL;

$beacon_runnable = false;

if ($beacon_db_type == "mysql") {
    $beacon_db_instance = new BeaconMySQL();
}

$beacon_runnable = $beacon_db_instance->init_db($beacon_mysql_hostname,
                                                $beacon_mysql_database,
                                                $beacon_mysql_username,
                                                $beacon_mysql_password);

if ($beacon_runnable < 0) {
    echo '<h3>Database Error. <a href="index.php">Go to main page</a> to review the problem.</h3>';
    @session_destroy();
}
else {
    $beacon_db_instance->add_user($_POST['name'],
                                                         $_POST['password'],
                                                         $_POST['email']); 
}

header("Location: login.php");
