<?php require_once('header.php'); ?>

<br><br>
All Doctors & Specialties<hr>

<?php
$sql = "Select FirstName, LastName, SpecialtyName
			FROM specialty JOIN doctorspecialty USING (SpecialtyID)
			RIGHT JOIN doctor USING (DoctorID)
			Join person USING (PersonID);";
$result = mysqli_query($link,$sql);
print "<pre>";
print "<table border=1>";
print "<tr><td>First Name </td><td>Last Name </td><td>Specialty Name</td></tr>";
while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
{
print "\n";
print "<tr><td>$row[FirstName] </td><td> $row[LastName]  </td><td>$row[SpecialtyName] </td></tr>";
}
print "</table>";
print "</pre>";
mysqli_free_result($result);
?>

<?php include('footer.php'); ?>