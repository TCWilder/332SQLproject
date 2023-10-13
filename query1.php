<?php require_once('header.php');
$doc = isset($_GET['doc']) ? $_GET['doc'] : '0';
?>

<br><br>
Doctors retiring - Patients <hr>
<?php
$sql = "SELECT FirstName, LastName, DoctorId
				From (Doctor JOIN Person Using (PersonId));";
	$result = mysqli_query($link,$sql);
	print "<pre>DOCTORS";
	print "<table border=1>";
	print "<tr><td>First Name </td><td>Last Name </td><td>View Patients</td></tr>";
	while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
	{
	print "\n";
	print "<tr><td>$row[FirstName] </td><td> $row[LastName]  </td><td><a href = 'query1.php?doc=$row[DoctorId]'>View</a></td></tr>";
	}
	print "</table>";
	print "</pre><hr>";
	mysqli_free_result($result);

if($doc != '0'){
	$sql = "SELECT FirstName, LastName, PhoneNumber 
				From (Patient JOIN Person Using (PersonId))
				JOIN patientvisit USING (PatientId) WHERE DoctorId = '"  .$doc. "'";
	$result = mysqli_query($link,$sql);
	print "<pre>PATIENTS";
	print "<table border=1>";
	print "<tr><td>First Name </td><td>Last Name </td><td>Phone Number</td></tr>";
	while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
	{
	print "\n";
	print "<tr><td>$row[FirstName] </td><td> $row[LastName]  </td><td>$row[PhoneNumber] </td></tr>";
	}
	print "</table>";
	print "</pre>";
	mysqli_free_result($result);
}
?>

<?php include('footer.php'); ?>