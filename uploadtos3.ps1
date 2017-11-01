#This file uploads cloud formation template and source files from workspace to s3 and then updates the stack.
set-executionpolicy unrestricted
$ErrorActionPreference = "Stop"
$date=Get-Date -Format yyyy_M_dd_H_m_ss
Write-S3Object -BucketName s3demo2017 -Key tos3.$date.zip -File .\tos3.zip -ProfileName slamba -Region us-west-2
Write-S3Object -BucketName s3demo2017 -Key demo.json -File .\demo.json -ProfileName slamba -Region us-west-2
Set-AWSCredentials -ProfileName slamba
Update-CFNStack -StackName disneydemo -Capability CAPABILITY_IAM -Parameter @(
@{ParameterKey="CIDR"; UsePreviousValue="True"},@{ParameterKey="Email"; UsePreviousValue="True"},@{ParameterKey="InstallerPath"; ParameterValue="tos3.$date.zip"},
@{ParameterKey="InstanceType"; UsePreviousValue="True"},@{ParameterKey="KeyPairName"; UsePreviousValue="True"},
@{ParameterKey="MaximumInstances"; UsePreviousValue="True"},@{ParameterKey="MinimumInstances"; UsePreviousValue="True"},
@{ParameterKey="RemoteAdministrationLocation"; UsePreviousValue="True"},
@{ParameterKey="TagEnvironment"; UsePreviousValue="True"},
@{ParameterKey="TagOperatingHours"; UsePreviousValue="True"},
@{ParameterKey="TagOperatingSystem"; UsePreviousValue="True"},
@{ParameterKey="TagOwner"; UsePreviousValue="True"}
) -TemplateURL 'https://s3-us-west-2.amazonaws.com/s3demo2017/demo.json' -Region us-west-2


while ($ss.StackStatus.Value -ne 'UPDATE_COMPLETE') 
{
    Write-Host 'Stack Still Updating, please wait';
	start-sleep 10;
    $ss=Get-CFNStack -Region us-west-2 -StackName sbxdemo | Select-Object StackStatus
}
write-host 'Stack Update Complete'
