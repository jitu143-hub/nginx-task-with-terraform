resource "aws_security_group" "myinstance-securitygroup" {
        vpc_id = aws_vpc.myvpc01.id
	name = "myinstance-securitygroup"
	description = "this is to all ssh from elb to my instance"
	egress {
	  from_port = 0
	  to_port = 0
	  protocol = "-1"
	  cidr_blocks = ["0.0.0.0/0"]
	  }
	ingress {
	  from_port = 22
	  to_port = 22
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
	  }
	ingress {
	  from_port = 80
	  to_port = 80
	  protocol = "tcp"
	  security_groups = [aws_security_group.elb-securitygroup.id]
	  }
	tags = {
      name = "myinstance-securitygroup"
      }	  
 }
	
resource "aws_security_group" "elb-securitygroup" {
      vpc_id = aws_vpc.myvpc01.id
      name = "elb-securitygroup"
      description = " this is used for elb to open traffic to internrt"
      egress {
         from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
         }
  
      ingress {
         from_port = 80
	 to_port= 80
	 protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
	  }
	tags = {
      name = "elb-securitygroup"
     }
}	
