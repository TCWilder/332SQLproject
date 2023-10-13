<?php
	require_once('header.php');	
?>
<?php
exec("mysqldump --opt -h ".$servername." -u ".$username." -p ".$password." ".$dbname."  /backup.sql");
print("Backed up");
#$sql = "DROP DATABASE IF EXISTS docOffice_Backup;
#		CREATE DATABASE docOffice_Backup;
#		INSERT INTO docOffice_Backup(*) FROM docOffice(*);
#";
#mysqli_query($link, $sql);
?>

<?php
	include_once('footer.php');
?>