<?php

session_start();

ini_set("display_errors", 0);

require_once("lib/BeaconAPI.php");
require_once("lib/BeaconAuthenticator.php");
require_once("lib/BeaconMySQL.php");
require_once("lib/BeaconXSLTransformer.php");
require_once ('settings.php');

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
    header('Location: index.php');
    exit();
}

$auth = new BeaconAuth($beacon_db_instance);

if (!$auth->check_session()) {
    @session_destroy();
    header('Location: index.php');

    exit();
}

// Pick up request
$file = "";
$type = "";
$file = $_FILES['file']['name'];
$type = $_POST['type'];
$content = file_get_contents($_FILES['file']['tmp_name']);

if ($type == 0) {
   $type = "docbook";
} else if ($type == 1) {
   $type = "guidexml";
}

// Removing extension
if (strlen(strstr($file, ".xml")) == 4) {
    $file = substr_replace($file, "", strlen($file)-4);
}

// Set the conf file path here
$confFile = $beacon_conf_path;

// Set the full path here
$fullPath = getcwd() . "/../";
/*$s = '{ "action": "newdoc",
        "payload": { "plugin":'.$type.',
                     "filename": "'.$file.'",
                     "xmlsource":"'.$content.'"
                   }
      }';*/

$request = (object) array('action' => 'newdoc', 'payload' => (object) array('plugin' => $type, 'filename' => $file, 'xmlsource' => $content));

// Create a new Beacon object
$beacon = new BeaconAPI($confFile, $fullPath, $request, $beacon_db_instance);
$newdoc = $beacon->newdoc();
header("Location: beacon.php");

?>
