#Use this to connect to MS SQL Server and extract data into PS
$SQLServer = "." #Local instance
$SQLDBName = "" #Change DB Name
$SQLQuery = "" #Change Query


$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName;Integrated Security = True"

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd

$DataSet = New-Object System.Data.Dataset
$SqlAdapter.Fill($DataSet)

$DataTable = New-Object System.Data.DataTable
$SqlAdapter.Fill($DataTable)

$SqlConnection.Close()

# Column drop for testing
#Write-Host $DataTable.Columns

foreach ($row in $DataTable.Rows) {
    Write-Host #Do something

}