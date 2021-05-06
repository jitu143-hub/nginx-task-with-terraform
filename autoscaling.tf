resource "aws_launch_configuration" "test-lunchconfig" {
        name_prefix = "test-lunchconfig"
	image_id  = "${lookup(var.AMIS,var.AWS_REGION)}"
	instance_type = "t2.micro"
	security_groups = [aws_security_group.myinstance-securitygroup.id]
	key_name = aws_key_pair.mykeypair.key_name
	user_data = "#!/bin/bash\nsudo su\nyum update\nyum install ngnix -y\necho 'hello world' > /var/www/html/index.html"
    lifecycle {
      create_before_destroy = true
      }
} 

resource "aws_autoscaling_group" "test-autoscaling" {
   name = "test-autoscaling"
   vpc_zone_identifier = [aws_subnet.public-subnet01.id,aws_subnet.public-subnet02.id]
   launch_configuration = aws_launch_configuration.test-lunchconfig.name
   min_size = 1
   max_size = 2
   health_check_grace_period = 300
   health_check_type = "ELB"
   load_balancers = [aws_elb.elb.name]   
   force_delete = true
   
 }
