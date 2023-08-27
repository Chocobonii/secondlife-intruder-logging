<?php
function clean($string) {
        $string = str_replace(' ', '-', $string);                 // Replaces all spaces with hyphens.
        $string = preg_replace('/[^A-Za-z0-9$\/=]/', '-', $string);// Removes special chars.
        $string = str_replace('$', '-', $string);
        $string = str_replace('\'', '-', $string);
        $string = str_replace('\"', '-', $string);
        return preg_replace('/-+/', '-', $string);               // Replaces multiple hyphens with single one.
}

      $user     = "your sql user";
      $password = "your sql password";
      $db       = "your sql table";
      $conn = mysqli_connect('localhost', $user, $password, $db);

      if(!$conn){
        echo 'ERROR: 2002';
        die('mysql server couldnt connect :(');
      }
      $uuid = $_GET["udid"];
      $name = $_GET["nme"];
      $place= $_GET["plce"];
      $udst = $_GET["dist"];
      $json = "{ uuid: " . $uuid . ", name: " . $name . ", place: " . $place . ", dist: " . $udst . "}";
      //$json = mysql_real_escape_string($json);
      //$uuid = mysql_real_escape_string($uuid);
      date_default_timezone_set('Australia/Melbourne');
      $date = date('m/d/Y h:i:s a', time());
      $json = clean($json);
      $uuid = clean($uuid);
      $req = "INSERT INTO LOG4 (DOXX,STAMP, UUID) VALUES ('$json', '$date', '$uuid') ON DUPLICATE KEY UPDATE STAMP = '$date', DOXX = '$json';";
      //$req = mysql_real_escape_string($req);
      echo $req;
      if(!mysqli_query($conn, $req)){
        echo mysqli_errno($conn);
	    die("could not perform query");
      }

     mysqli_close($conn);
?>
