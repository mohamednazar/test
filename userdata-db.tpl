<powershell>

wget https://s3.amazonaws.com/ae-infra-software/Bootstrap/Chef/aechef-validator.pem -Outfile C:\chef\aechef-validator.pem


$nodeName = "${ComputerName}{0}" -f (-join ((65..90) + (97..122) | Get-Random -Count 3 | % {[char]$_}))
$environment = "${environment}"

## Create first-boot.json
$firstboot = '{
"run_list": [
	"role[DBS-2016]"
],
 "sqlserver": {
      "ComputerName": "${ComputerName}",
	  "svcname": "${svcname}",
	  "svc_pwd": "${svc_pwd}",	  
	  "appname": "${appname}",
	  "DBS_SourceDbServer": "${DBS_SourceDbServer}",
	  "DBS_DbnameToRestore": "${DBS_DbnameToRestore}",
	  "sqlcollation": "${sqlcollation}"
 }
}'

$pathToJson = "C:\chef\first-boot.json"
echo $firstboot | Set-Content -Path $pathToJson

## Create client.rb
$clientrb = @"
chef_server_url        'https://chef.it.aenetworks.com/organizations/aechef'
validation_client_name 'aechef-validator'
validation_key         'C:\chef\aechef-validator.pem'
file_cache_path        'C:\chef\cache'
ssl_verify_mode		   :verify_none
node_name              '{0}'
log_level              :info
log_location           'C:\chef\chef-client_before_bootsraprun.log'
"@ -f $nodeName



Set-Content -Path c:\chef\client.rb -Value $clientrb

## Set host file so the instance knows where to find chef-server
$private_IP = Invoke-RestMethod -uri http://169.254.169.254/latest/meta-data/local-ipv4
$hostname = "$nodeName"
$hosts = "$private_IP $hostname"
$file = "C:\Windows\System32\drivers\etc\hosts"
$hosts | Add-Content $file

## Run Chef
cd c:\opscode\chef\bin
.\chef-client -j C:\chef\first-boot.json -E "${environment}"
</powershell>