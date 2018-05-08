aws_access_key = "AKIAILOZH3TYFDEUXUQQ"
aws_secret_key = "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"
aws_key_name = "InfraDev-DBAKey"
aws_region = "us-east-1"
db_ami = "ami-5e912521"
db_instancestype = "t2.medium"
subnet_id = "subnet-7c5eab35"
availability_zone = "us-east-1a"
db_userdata = "bootstrap/userdata-db.tpl"

db_instance_name = "AZV-DBS6E-DDBT3"
serviceaccount_name = "SVCDBS6EDDBT"
app_name = "DBT"
env = "prod"
svc_pwd = ""
sqlcollation = "SQL_Latin1_General_CP1_CI_AS"

#########################################################################################################
#   Please provide the valid values for successfull DB Restore. Restore failed if below details are wrong.
##

DBS_SourceDbServer = "DC01-CTX-SQL-02"
DBS_DbnameToRestore = "PVSCTXPRO"

#############################
#   Volume size
##
# Note: c_drive_size should be more than 50gb..

c_drive_size = "100"
d_drive_size = "50"
e_drive_size = "10"

##################
##  Security Group
##

dbsg = "AZV-SGDBS-DDBT3"

##############################
#  Variable declaration IAM Role, Instance Profile
##

instance_profile_name = "INP-DBS6E-DDBT3"
ec2_role = "IAM-DBS6E-DDBT3"
ec2_policy = "IAM-DBS6E-DDBT3"

##############################
#  Variable declaration for Tagging
###

budget_manager_tag = "Nagarajan Subbiah"
lineof_business_tag = "TOPS"
project_tag = "AIM"
environment_tag = "TEST"
security_tag = "Non Sensitive"
automation_tag = "None"
financial_tag = "NA"
application_id_tag = "DBT"
application_role_tag = "Database Testing Server"
international_tag = "TBD"
additional_team = "Database Team"
additional_purpose = "POC Testing"
additional_name = "Sateesh"


######################################################################
# Remote state
##

s3_rstate_bucket = "ae-terraform-state-prod"
vpc_s3_key = "ppas/prod/vpc/terraform.tfstate"
uat_subnet_key = "ppas/prod/vpc/prodsubnet/terraform.tfstate"

