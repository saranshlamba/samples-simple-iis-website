set-executionpolicy unrestricted
Write-S3Object -BucketName s3demo2017 -Key tos3.zip -File .\tos3.zip -ProfileName slamba -Region us-west-2