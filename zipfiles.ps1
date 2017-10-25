set-executionpolicy unrestricted
Add-Type -Assembly "System.IO.Compression.FileSystem";
New-Item -ItemType directory -Path .\tos3
Copy-Item .\default.aspx .\tos3 -force
Copy-Item .\default.aspx.cs .\tos3 -force
Copy-Item .\packages.config .\tos3 -force
Copy-Item .\readme.md .\tos3 -force
Copy-Item .\web.config .\tos3 -force
Copy-Item .\web.config.debug .\tos3 -force
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\tos3", "tos3.zip")