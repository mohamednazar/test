######################################################################
## Create EC2 instance
###

data "template_file" "user_data" {
    template  = "${file(var.db_userdata)}"
    vars {
        ComputerName = "${var.db_instance_name}"
		svcname = "${var.serviceaccount_name}"
		svc_pwd = "${var.svc_pwd}"
		appname = "${var.app_name}"
		environment = "${var.env}"
		DBS_SourceDbServer = "${var.DBS_SourceDbServer}"
		DBS_DbnameToRestore = "${var.DBS_DbnameToRestore}"
		sqlcollation = "${var.sqlcollation}"
    }
}

resource "aws_instance" "db-instance" {
    ami = "${var.db_ami}"
    instance_type = "${var.db_instancestype}"
	key_name = "${var.aws_key_name}"
	subnet_id = "${var.subnet_id}"
	availability_zone = "${var.availability_zone}"
	vpc_security_group_ids = ["${aws_security_group.dbs_sg.id}"]
	user_data="${data.template_file.user_data.rendered}"
	iam_instance_profile = "${aws_iam_instance_profile.instancerole.name}"
	#monitoring = "${var.monitoring}"
	root_block_device {
                    volume_type = "gp2"
                    volume_size = "${var.c_drive_size}"
                    delete_on_termination = "true"
    }                              
    ebs_block_device {
                    device_name    = "/dev/xvdb"
                    volume_type = "gp2"
                    volume_size = "${var.d_drive_size}"
                    delete_on_termination = "true"               
    }
    ebs_block_device {
                    device_name    = "/dev/xvdc"
                    volume_type = "gp2"
                    volume_size = "${var.e_drive_size}"
                    delete_on_termination = "true"               
    }
    tags {
		"Name" 					= "${var.db_instance_name}"
		"Budget Manager"		= "${var.budget_manager_tag}"
		"Application ID" 		= "${var.application_id_tag}"
		"Application Role"		= "${var.application_role_tag}"
		"Line of Business"		= "${var.lineof_business_tag}"
		"Environment" 			= "${var.environment_tag}"
		"Financial"				= "${var.financial_tag}"
		"Project"				= "${var.project_tag}"
		"Security" 				= "${var.security_tag}"	
		"Automation"			= "${var.automation_tag}"
		"International"			= "${var.international_tag}"
		"Additional Team" 		= "${var.additional_team}"
		"Additional Purpose" 	= "${var.additional_purpose}"
		"Additional Name" 		= "${var.additional_name}"		
    }
}