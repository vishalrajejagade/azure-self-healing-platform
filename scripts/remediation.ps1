$service = "W3SVC"

$status = Get-Service $service

if($status.Status -ne "Running")
{
    Restart-Service $service

    Write-Host "IIS Restarted"

}
else
{
    Write-Host "IIS Healthy"
}