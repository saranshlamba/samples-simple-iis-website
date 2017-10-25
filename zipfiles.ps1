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
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\tos3", "tos3.zip")