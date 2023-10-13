<?php require_once('header.php');
$pre = isset($_GET['pre']) ? $_GET['pre'] : 'Nothing';
?>

<br><br>
Doctors giving Perscriptions<hr>
<?php
$sql = "SELECT PrescriptionName
				From Prescription;";
	$result = mysqli_query($link,$sql);
	print "<pre>Prescriptions";
	print "<table border=1>";
	print "<tr><td>Drug Name</td><td>View Doctors Prescribing</td></tr>";
	while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
	{
	print "\n";
	print "<tr><td> $row[PrescriptionName]  </td><td><a href = 'query2.php?pre=$row[PrescriptionName]'>View</a></td></tr>";
	}
	print "</table>";
	print "</pre><hr>";
	mysqli_free_result($result);

$sql = "SELECT DISTINCT FirstName, LastName
			FROM prescription 
			JOIN pvisitprescription USING (PrescriptionID)
			JOIN patientvisit USING (VisitID)
			JOIN doctor USING (DoctorID)
			JOIN person USING (PersonID)
			WHERE PrescriptionName = '" .$pre."';";
$result = mysqli_query($link,$sql);
print "<pre>Doctors Prescribing - ";
echo $pre;
print "<table border=5>";
print "<tr><td>First Name </td><td>Last Name </td></tr>";
while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
{
print "\n";
print "<tr><td>$row[FirstName] </td><td> $row[LastName]  </td></tr>";
}
print "</table>";
print "</pre>";
mysqli_free_result($result);
?>

<?php include('footer.php'); ?>