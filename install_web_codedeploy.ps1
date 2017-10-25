if ($PSHOME -like "*SysWOW64*"){
  & (Join-Path ($PSHOME -replace "SysWOW64", "SysNative") powershell.exe) -File `
    (Join-Path $PSScriptRoot $MyInvocation.MyCommand) @args
  Exit $LastExitCode
}

set-executionpolicy unrestricted
Import-Module WebAdministration
Import-Module -Name C:\Windows\System32\WindowsPowerShell\v1.0\Modules\ServerManager
function InstallfeatureRoles
{
    if((Get-WindowsFeature -name Application-Server).Installed -eq 0)
    {
       Add-WindowsFeature Application-Server | Out-Null
    }
}

InstallfeatureRoles
iisreset /stop
Remove-Item IIS:\AppPools\webdemopool -ErrorAction SilentlyContinue
Remove-WebApplication -Name webdemo -Site "Default Web Site" -ErrorAction SilentlyContinue
Remove-Item C:\inetpub\wwwroot\webdemo -Force -Recurse -ErrorAction SilentlyContinue

Copy-Item -Path c:\temp\webfiles -Destination C:\inetpub\wwwroot\webdemo -Recurse -Force
New-Item IIS:\AppPools\webdemopool
New-WebApplication -Name webdemo -Site "Default Web Site" -ApplicationPool webdemopool -PhysicalPath C:\inetpub\wwwroot\webdemo -Force
Set-ItemProperty -Path 'IIS:\Sites\Default Web Site\webdemo' -Name preloadEnabled -Value True
Set-ItemProperty -Path IIS:\AppPools\webdemopool -Name startMode -Value 'AlwaysRunning'

iisreset /start