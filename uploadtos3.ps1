set-executionpolicy unrestricted
$ErrorActionPreference = "Stop"
$date=Get-Date -Format yyyy_M_dd_H_m_ss
Write-S3Object -BucketName s3demo2017 -Key tos3.$date.zip -File .\tos3.zip -ProfileName slamba -Region us-west-2