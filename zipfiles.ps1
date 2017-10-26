#This copies and zips all the necessary files needed for codedeploy and iis
set-executionpolicy unrestricted
$ErrorActionPreference = "Stop"
Add-Type -Assembly "System.IO.Compression.FileSystem";
New-Item -ItemType directory -Path .\webfiles
New-Item -ItemType directory -Path .\tos3
Copy-Item .\default.aspx .\webfiles -force
Copy-Item .\default.aspx.cs .\webfiles -force
Copy-Item .\packages.config .\webfiles -force
Copy-Item .\readme.md .\webfiles -force
Copy-Item .\web.config .\webfiles -force
Copy-Item .\Web.Debug.config .\webfiles -force
Move-Item .\webfiles .\tos3 -force
Copy-Item .\appspec.yml .\tos3 -Force
Copy-Item .\install.bat .\tos3 -Force
Copy-Item .\install_web_codedeploy.ps1 .\tos3 -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\tos3", "tos3.zip")