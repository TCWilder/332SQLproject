<?php
	require_once('header.php');	
?>

<html lang="en">
		<navigation><center>
			<ul>
			<li><a href="query1.php">Retirement</a></li>
			<li><a href="query2.php">Perscription</a></li>
			<li><a href="query3.php">Doc Specialties</a></li>
			<li><a href="query4.php">All Doc Specialties</a></li>
			<!-- <li><a href="query5.php">Doc Update</a></li> THIS NEEDS TO BE A DB TRIGGER, not php scripted !-->
			<li><a href="query6.php">Backup DB</a></li>
			<hr></ul>
			<img src="waitingroom.jpg">
		</navigation>
</html>

<?php
	include_once('footer.php');
?>