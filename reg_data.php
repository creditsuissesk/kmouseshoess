<?php require_once('Connections/conn.php'); ?>
<?php /*php script for uploading pic */?>
<?php 
$allowedExts = array("gif", "jpeg", "jpg", "png");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);
if ((($_FILES["file"]["type"] == "image/gif")
|| ($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/jpg")
|| ($_FILES["file"]["type"] == "image/pjpeg")
|| ($_FILES["file"]["type"] == "image/x-png")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 20000)
/*&& in_array($extension, $allowedExts)*/
)
  {
  if ($_FILES["file"]["error"] > 0)
    {
    echo "Return Code: " . $_FILES["file"]["error"] . "<br>";
    }
  else
    {
    echo "Upload: " . $_FILES["file"]["name"] . "<br>";
    echo "Type: " . $_FILES["file"]["type"] . "<br>";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br>";

    if (file_exists("images/profiles/" . $_FILES["file"]["name"]))
      {
      echo $_FILES["file"]["name"] . " already exists. ";
      }
    else
      {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "images/profiles/" . $_FILES["file"]["name"]);
	  $upload_add="images/profiles/" . $_FILES["file"]["name"];
      echo "Stored in: " . $upload_add;
      
	  if (!function_exists("GetSQLValueString")) {
	  function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
	  {
		if (PHP_VERSION < 6) {
		  $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
		}
	  
		$theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);
	  
		switch ($theType) {
		  case "text":
			$theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
			  break;    
		  case "long":
		  case "int":
			$theValue = ($theValue != "") ? intval($theValue) : "NULL";
			break;
		  case "double":
			$theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
			break;
		  case "date":
			$theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
			break;
		  case "defined":
			$theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
			break;
		}
		return $theValue;
	  }
	  }	  
if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form")) {
		$insertSQL = sprintf("INSERT INTO `user` (u_name, password, f_name, l_name, contact_no, dob, institute, stream,role,photo) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s,%s)",
							 GetSQLValueString($_POST['u_name'], "text"),
							 GetSQLValueString($_POST['pass'], "text"),
							 GetSQLValueString($_POST['f_name'], "text"),
							 GetSQLValueString($_POST['l_name'], "text"),
							 GetSQLValueString($_POST['contact'], "int"),
							 GetSQLValueString($_POST['dob'], "date"),
							 GetSQLValueString($_POST['inst_name'], "text"),
							 GetSQLValueString($_POST['stream'], "text"),
							 GetSQLValueString($_POST['role'], "text"),
							 GetSQLValueString( $upload_add,"text"));
	  
		mysql_select_db($database_conn, $conn);
		$Result1 = mysql_query($insertSQL, $conn) or die(mysql_error());
	  
		$insertGoTo = "index.php";
		if (isset($_SERVER['QUERY_STRING'])) {
		  $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
		  $insertGoTo .= $_SERVER['QUERY_STRING'];
		}
		 /*header(sprintf("Location: %s", $insertGoTo)); */
	  }
	  }
    }
	    }
else
  {
  echo "Invalid file, rejected in first if";
  }

?>
















<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
</body>
</html>