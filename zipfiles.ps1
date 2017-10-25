Add-Type -Assembly "System.IO.Compression.FileSystem";
New-Item -ItemType directory -Path .\tos3
Copy-Item .\default.aspx .\tos3 -force
[System.IO.Compression.ZipFile]::CreateFromDirectory(".\tos3", "tos3.zip")