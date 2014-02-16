<?php require_once('Connections/conn.php'); ?>
<?php
if (!isset($_SESSION)) {
  session_start();
}
$MM_authorizedUsers = "student";
$MM_donotCheckaccess = "false";

// *** Restrict Access To Page: Grant or deny access to this page
function isAuthorized($strUsers, $strGroups, $UserName, $UserGroup) { 
  // For security, start by assuming the visitor is NOT authorized. 
  $isValid = False; 

  // When a visitor has logged into this site, the Session variable MM_Username set equal to their username. 
  // Therefore, we know that a user is NOT logged in if that Session variable is blank. 
  if (!empty($UserName)) { 
    // Besides being logged in, you may restrict access to only certain users based on an ID established when they login. 
    // Parse the strings into arrays. 
    $arrUsers = Explode(",", $strUsers); 
    $arrGroups = Explode(",", $strGroups); 
    if (in_array($UserName, $arrUsers)) { 
      $isValid = true; 
    } 
    // Or, you may restrict access to only certain users based on their username. 
    if (in_array($UserGroup, $arrGroups)) { 
      $isValid = true; 
    } 
    if (($strUsers == "") && false) { 
      $isValid = true; 
    } 
  } 
  return $isValid; 
}

$MM_restrictGoTo = "/dreamweaver/login.php";
if (!((isset($_SESSION['MM_Username'])) && (isAuthorized("",$MM_authorizedUsers, $_SESSION['MM_Username'], $_SESSION['MM_UserGroup'])))) {   
  $MM_qsChar = "?";
  $MM_referrer = $_SERVER['PHP_SELF'];
  if (strpos($MM_restrictGoTo, "?")) $MM_qsChar = "&";
  if (isset($_SERVER['QUERY_STRING']) && strlen($_SERVER['QUERY_STRING']) > 0) 
  $MM_referrer .= "?" . $_SERVER['QUERY_STRING'];
  $MM_restrictGoTo = $MM_restrictGoTo. $MM_qsChar . "accesscheck=" . urlencode($MM_referrer);
  header("Location: ". $MM_restrictGoTo); 
  exit;
}
?>
<?php
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
	  ?>
<?php

$colname_course_details = "-1";
if (isset($_GET['c_id'])) {
  $colname_course_details = $_GET['c_id'];
}
$value=GetSQLValueString($colname_course_details, "int");
mysql_select_db($database_conn, $conn);
$query_course_details = "SELECT c_id,c_name,c_stream,inserted_on,course.u_id,approve_status,course_image,avg_rating,description,enroll_course.u_id as u_enroll_id, c_enroll_id,completion_stat,DATE_FORMAT(start_date,'%d-%m-%Y') AS date_start,DATE_FORMAT(end_date,'%d-%m-%Y') AS date_end FROM `course` LEFT OUTER JOIN `enroll_course` ON course.c_id=enroll_course.c_enroll_id AND enroll_course.u_id=".$_SESSION['MM_UserID']." WHERE c_id =".$value;
$course_details = mysql_query($query_course_details, $conn) or die(mysql_error());
$row_course_details = mysql_fetch_assoc($course_details);
$totalRows_course_details = mysql_num_rows($course_details);

mysql_select_db($database_conn, $conn);
$query_resource = sprintf("SELECT * FROM `resource` NATURAL JOIN `resource_type` WHERE c_id=%s ",GetSQLValueString($_GET['c_id'], "int"));
$resource = mysql_query($query_resource, $conn) or die(mysql_error());
$row_resource = mysql_fetch_assoc($resource);
$totalRows_resource = mysql_num_rows($resource);

mysql_select_db($database_conn, $conn);
$query_author_details = sprintf("SELECT * FROM user WHERE u_id = %s", GetSQLValueString($row_course_details['u_id'], "int"));
$author_details = mysql_query($query_author_details, $conn) or die(mysql_error());
$row_author_details = mysql_fetch_assoc($author_details);
$totalRows_author_details = mysql_num_rows($author_details);

/*mysql_select_db($database_conn, $conn);
$query_other_course = sprintf("SELECT * FROM course WHERE u_id = %s", GetSQLValueString($row_course_details['u_id'], "int"));
$other_course = mysql_query($query_other_course, $conn) or die(mysql_error());
$row_other_course = mysql_fetch_assoc($other_course);
$totalRows_other_course = mysql_num_rows($other_course);
*/
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo $row_course_details['c_name']; ?></title>
<meta name="keywords" content="tech layer, free template, one page layout" />
<meta name="description" content="Tech Layer is free one-page template layout by templatemo.com using colorful navigations and darkgray background." />
<link href="css/course_details_page.css" type="text/css" rel="stylesheet" /> 
<script type="text/javascript" src="js/jquery.min.js"></script> 
<script type="text/javascript" src="js/jquery.scrollTo-min.js"></script> 
<script type="text/javascript" src="js/jquery.localscroll-min.js"></script> 
<script type="text/javascript" src="js/init.js"></script>  
<link rel="stylesheet" href="css/slimbox2.css" type="text/css" media="screen" /> 
<link rel="stylesheet" href="css/course_list.css" type="text/css" media="screen" /> 
<link rel="stylesheet" type="text/css" media="screen" href="css/nav_bar.css" />
<script type="text/JavaScript" src="js/slimbox2.js"></script> 
<script language="javascript" type="text/javascript">
function clearText(field)
{
    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;
}

function takeTest() {
	var cId = document.getElementById("hiddenId").value;
	if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("content-holder").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","course_eval.php?takeTest="+cId,true);
xmlhttp.send();
}

function submitTest() {
}
</script>
</head> 
<body> 
<nav id="headerbar">
	<ul id="headerbar">
		<li id="headerbar"><a href="userhome.php">Home</a></li>
		<li id="headerbar"><a href="forum_new.php?mode=showmain">Forums</a></li>
		<li id="headerbar"><a href="#"><?php echo $_SESSION['MM_Username'];?></a>
			<ul id="headerbar">
				<li id="headerbar"><a href="userhome.php?userTabToDisplay=5">Profile</a></li>
				<li id="headerbar"><a href="<?php echo $logoutAction ?>">Log Out</a>
				</li>
			</ul>
		</li>
	</ul>
</nav>
<br/>


<div id="templatemo_header_wrapper">
	<div id="templatemo_header">
    	<div id="site_title"><?php echo $row_course_details['c_name']; ?></div>
        <a class="templatemo_header_bg" href="http://nl.hiresimage.com" title="Creative commons beelden"  target="_blank"><img src="images/header.png" alt="Creative commons beelden" title="Creative commons beelden" /></a>
    </div>
</div>

<div id="templatemo_main_wrapper">
	<div id="templatemo_main">
		<div id="content"> 
            <div id="home" class="section">
                <div class="home_box left">
                	<div class="row1 box box1">
                    	<div class="box_with_padding">
                        	<h2><a href="#about">About</a></h2>
                         	<?php if (strlen($row_course_details['description'])>105) {
							echo substr($row_course_details['description'],0,105)."....";
							}else {
								echo $row_course_details['description'];
							}?>
						</div>
                    </div>
                    <div class="row1 box2">
                    	<div class="box_with_padding">
                        	<?php if(!empty($row_course_details['u_enroll_id'])){
								//user has enrolled, show him link to resources
								echo '<h2><a href="#resources">Resources</a></h2>';
							}else {
								//user has not enrolled, disable the link
								echo '<h2 style="cursor:pointer;"><a onclick="alert(\'You have not enrolled for the cource. Please enroll to access resources and evaluation!\'); return false;">Resources</a></h2>';
							}
							?>
                            Browse through the resources of this course and learn!
						</div>
                    </div>
                    <div class="row1 box3">
                    	<div class="box_with_padding">
                        	<?php if(!empty($row_course_details['u_enroll_id'])) {
								echo '<h2><a href="#evaluation">Evaluation</a></h2>';
							}else {
								echo '<h2 style="cursor:pointer;"><a onclick="alert(\'You have not enrolled for the cource. Please enroll to access resources and evaluation!\'); return false;">Evaluation</a></h2>';
							}
							?>
                             Prepared to get evaluated? Take the test now!
						</div>
                    </div>
                    <div class="row1 box4">
                    	<div class="box_with_padding">
                        	<h2><a href="#contact">Contact</a></h2>
                            Got any queries? Contact the faculty!
						</div>
                    </div>
                </div>
 				<div class="home_box right">
                	<div class="row1 box5">
                    	<div class="box_with_padding">
                        	<h5>Course Overview</h5>
                            Stream : <?php echo $row_course_details['c_stream']; ?><br />
                            Duration : <?php echo $row_course_details['date_start']." to ".$row_course_details['date_end'];?>
						</div>
                    </div>
                    <div class="row2" id="home_gallery">
                    	<img src="<?php echo $row_course_details['course_image'];?>" alt="image 1" width="400" height="240"/>
					</div>
                    <div class="row1 box6">
                        <div id="mini_contact_form">
                        	<h5>Quick Contact</h5>
                            <form method="post" name="contact" action="#">
                            	<div class="col_half left">
                               	  	<textarea id="text_small" name="text" rows="0" cols="0" 
                                  		onfocus="clearText(this)" onblur="clearText(this)">Message</textarea>
                                </div>                                
                            	<div class="col_half right">
                                	<input name="author" type="text" class="input_field" id="author_small" 
                                    	onfocus="clearText(this)" onblur="clearText(this)" value="Name" maxlength="40" />
                                    <input name="email" type="text" class="input_field" id="email_small" 
                                    	onfocus="clearText(this)" onblur="clearText(this)" value="Email" maxlength="40" />
                                  	<input type="submit" class="submit_btn float_l" name="submit" id="submit_small" value="Send" />
                              	</div>                                
                            </form>
                            <div class="clear"></div>
                        </div>
                        
                    </div>
                </div>
            </div> <!-- END of Home -->
            
            <div class="section section_with_padding" id="about"> 
                <h1>About</h1>
                <div class="half left">
                	<h4>The course</h4>
                    <div class="img_border img_course"> <a href="#gallery"><img src="<?php echo $row_course_details['course_image'] ?>" width="200" height="120" alt="No course image available" /></a>	
                  </div>
                    <p><em><?php echo $row_course_details['description'];?></em></p>
                    <?php if (empty($row_course_details['u_enroll_id'])) {
                    	echo '<form id="enrollform">';
                    	echo '<input id="submit" type="button" class="buttom" value="Enroll!" onclick="enrollCourse()" />';
                    	echo '</form>';
					}
					?>
				</div>
                <div class="half right">
                	<h4>The author</h4>
					<div class="img_border img_author"> <a href="#gallery"><img src="<?php echo $row_author_details['photo'] ?>" width="120" height="150" alt="No author image available" /></a></div>
                    <p class="inline_details">Name : <em><?php echo $row_author_details['f_name']." ".$row_author_details['l_name'];?></em></p>
                    <p class="inline_details">Degree of Specialization : <em><?php echo $row_author_details['degree'];?></em></p>
                    <p class="inline_details">Institute of Specialization : <em><?php echo $row_author_details['institute'];?></em></p>
                    <p class="inline_details">Contact : <em><?php echo $row_author_details['contact_no'];?></em></p>
				</div>
                <a href="#home" class="home_btn">home</a> 
                <a href="#home" class="page_nav_btn previous">Previous</a>
                <?php //if user is enrolled then go next to resources else go next to contact
				if (!empty($row_course_details['u_enroll_id'])) { 
					echo '<a href="#resources" class="page_nav_btn next">Next</a>';
				}else {
					echo '<a href="#contact" class="page_nav_btn next">Next</a>';
				}  ?>
            </div> <!-- END of About -->
            
            <?php if (!empty($row_course_details['u_enroll_id'])) { 
				//show the two tabs only if user has enrolled
			?>
            <div class="section section_with_padding" id="resources"> 
                <h1>Resources</h1>
                <div class="half left">
                	<p><em>Praesent condimentum ac quam a scelerisque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer feugiat gravida est nec accumsan. Nunc posuere, magna id ornare mollis.</em></p>
                	<ul class="list_bullet">
                        <li>Maecenas ac odio ipsum donec cursus</li>
                        <li>Fusce risus tortor, interdum</li>
                        <li>Proin facilisis ullamcorper</li>
                        <li><a href="#">Sed vel justo quis ligula</a></li>
                        <li>Ut tristique sagittis arcu</li>
                        <li>Maecenas ac odio ipsum donec cursus</li>
                        <li>Fusce risus tortor, interdum</li>
                        <li>Proin facilisis ullamcorper</li>
                    </ul>
                    
                </div>
                <div class="half right">
                    <div class="img_border img_nom"> <a href="#gallery"><img src="images/templatemo_image_01.jpg" alt="image 1" /></a>	
                    </div>
                    
               	  <p>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam mauris ipsum, pulvinar sit amet varius at, placerat ut felis. Curabitur consectetur aliquam purus, eget faucibus est ultrices iaculis. Suspendisse luctus mauris et erat imperdiet rutrum. Visit <a href="#gallery"><strong> Gallery Page</strong></a> for more info.<br />
               	    <br />
				All photos are provided by <a href="http://www.photovaco.com" target="_blank">photovaco</a> website.<br />
				Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow">XHTML</a> &amp; <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow">CSS</a></p>
                </div>
                <a href="#home" class="home_btn">home</a> 
                <a href="#about" class="page_nav_btn previous">Previous</a>
                <a href="#evaluation" class="page_nav_btn next">Next</a> 
            </div> <!-- END of resources -->
            

            <div class="section section_with_padding" id="evaluation"> 
               	<h1>Evaluation</h1>
                <div id="content-holder">
				<?php 
				//check if there are any available tests. Show options accordingly.
				$query_test_exists= sprintf("SELECT * FROM `course_eval` WHERE c_id_eval=%s",GetSQLValueString($_GET['c_id'], "int"));
				$check_test_exists = mysql_query($query_test_exists, $conn) or die(mysql_error());
				$row_test_exists = mysql_fetch_assoc($check_test_exists);
				$totalRows_test_exists = mysql_num_rows($check_test_exists);
				if($totalRows_test_exists>0){
					//test is available. check if candidate has already taken the test.
					$query_test_check=sprintf("SELECT * FROM `enroll_course` WHERE u_id=%s AND c_enroll_id=%s",GetSQLValueString($_SESSION['MM_UserID'], "int"),GetSQLValueString($_GET['c_id'], "int"));
					$check_test=mysql_query($query_test_check,$conn) or die(mysql_error());
					$row_check_test=mysql_fetch_assoc($check_test);
					if($row_check_test['marks']==-1) {
					//Test has not been taken. Show options of taking test.
					echo "There is a test for this course available!<br>";
					echo '<form id="enrollform" style="padding-top:10px;">';
                    echo '<input id="submit" type="button" class="buttom" value="Take Test!" onclick="takeTest();" />';
					echo '<input id="hiddenId" type="hidden" value="'.$_GET['c_id'].'" />';
                    echo '</form>';
					}else {
						//test has already been taken. Show user the marks.
						echo "You have already taken test and have secured ".$row_check_test['marks']."/".$totalRows_test_exists*10;
					}
				}else {
					echo "Sorry, no test has been created for this course by author yet!";
				}
				?>
            	</div><!--- end of content-holder--->
                <a href="#home" class="home_btn">home</a> 
                <a href="#resources" class="page_nav_btn previous">Previous</a>
                <a href="#contact" class="page_nav_btn next">Next</a>
            </div> <!-- END of evaluation -->
            
            
            <?php } //end of the if of only-enrolled tabs ?>
            
            <div class="section section_with_padding" id="contact"> 
                <h1>Contact</h1> 
                
                <div class="half left">
                    <h4>Mailing Address</h4>
                    220-440 Nullam lacus diam,<br />
                	Pulvinar sit amet convallis eget, 10220<br />
                	Lorem ipsum dolor<br /><br />
                 
                 	Email: info[at]company.com | Phone: 020-010-0101<br />

                    <div class="clear h20"></div>
                <div class="img_nom img_border"><span></span>
                    <iframe width="320" height="160" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=new+york+central+park&amp;aq=&amp;sll=37.0625,-95.677068&amp;sspn=60.158465,135.263672&amp;vpsrc=6&amp;ie=UTF8&amp;hq=&amp;hnear=Central+Park,+New+York&amp;t=m&amp;ll=40.769606,-73.973372&amp;spn=0.014284,0.033023&amp;z=14&amp;output=embed"></iframe>
                </div>
                
                <a href="#home" class="home_btn">home</a> 
                <?php //if user is enrolled, previous page is evaluation, else is about
				if (!empty($row_course_details['u_enroll_id'])) {
					echo '<a href="#evaluation" class="page_nav_btn previous">Previous</a>';
				}else {
					echo '<a href="#about" class="page_nav_btn previous">Previous</a>';
				} ?>
                <a href="#home" class="page_nav_btn next">Next</a>
            	</div> <!-- END of Contact -->
                
                <div class="half right">
                    <h4>Quick Contact</h4>
                    <p>Nullam a tortor est, congue fermentum nisi. Maecenas nulla nulla, eu volutpat euismod, scelerisque ut dui.</p>
                    <div id="contact_form">
                        <form method="post" name="contact" action="#contact">
                            <div class="left">
                                <label for="author">Name:</label> <input type="text" id="author" name="author" class="required input_field" />
                            </div>
                            <div class="right">                           
                                <label for="email">Email:</label> <input type="text" id="email" name="email" class="validate-email required input_field" />
                            </div>
                            <div class="clear"></div>
                            <label for="text">Message:</label> <textarea id="text" name="text" rows="0" cols="0" class="required"></textarea>
                            <input type="submit" class="submit_btn float_l" name="submit" id="submit" value="Send" />
                        </form>
                    </div>
                </div>
                
                
            
        </div> 
    </div>
</div>

<div id="templatemo_footer_wrapper">
	<div id="templatemo_footer">
    	<p>Copyright © 2014 <a href="#">Shaarad and Kunal</a> | <a rel="nofollow" href="index.php">Virtual Library</a> by <a href="https://www.facebook.com/kunal.shah.96780" target="_blank" rel="nofollow">Kunal and Shaarad</a></p>
    </div>
</div>

</div>

</body> 
<script type='text/javascript' src='js/logging.js'></script>
</html>
<?php 
mysql_free_result($author_details);
mysql_free_result($course_details);
mysql_free_result($resource);
?>