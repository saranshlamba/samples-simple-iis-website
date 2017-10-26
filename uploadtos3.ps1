set-executionpolicy unrestricted
$ErrorActionPreference = "Stop"
$date=Get-Date -Format yyyy_M_dd_H_m_ss
Write-S3Object -BucketName s3demo2017 -Key tos3.$date.zip -File .\tos3.zip -ProfileName slamba -Region us-west-2
Write-S3Object -BucketName s3demo2017 -Key demo.json -File .\demo.json -ProfileName slamba -Region us-west-2
Set-AWSCredentials -ProfileName slamba
Update-CFNStack -StackName sbxdemo -Capability CAPABILITY_IAM -Parameter @(
@{ParameterKey="CIDR"; UsePreviousValue="True"},@{ParameterKey="Email"; UsePreviousValue="True"},@{ParameterKey="InstallerPath"; ParameterValue="tos3.$date.zip"},
@{ParameterKey="InstanceType"; UsePreviousValue="True"},@{ParameterKey="KeyPairName"; UsePreviousValue="True"},
@{ParameterKey="MaximumInstances"; UsePreviousValue="True"},@{ParameterKey="MinimumInstances"; UsePreviousValue="True"},
@{ParameterKey="RemoteAdministrationLocation"; UsePreviousValue="True"},
@{ParameterKey="TagEnvironment"; UsePreviousValue="True"},
@{ParameterKey="TagOperatingHours"; UsePreviousValue="True"},
@{ParameterKey="TagOperatingSystem"; UsePreviousValue="True"},
@{ParameterKey="TagOwner"; UsePreviousValue="True"}
) -TemplateURL 'https://s3-us-west-2.amazonaws.com/s3demo2017/demo.json' -Region us-west-2