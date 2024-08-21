<?php
$name=$_POST['name'];
$email=$_POST['email'];
$subject=$_POST['subject'];
$message=$_POST['message'];

$link='http://localhost:8080/lms/';
$con=new mysqli('localhost','root','','contact');
if($con->connect_error){
    die('connection error '.$conn->connect_error);
}
else{
$stm=$con->prepare("insert into contact_details(name,email,subject,message) values(?,?,?,?)");
$stm->bind_param("ssss",$name,$email,$subject,$message);
$stm->execute();
header("refresh:5; url=index.html");
echo'Thank You for Your Feedback\n';
echo'you will be redirected to home page in 5 secs';
echo"<a href=$link> click </a>here to go to login page";
$stm->close();
$con->close();
}
?>