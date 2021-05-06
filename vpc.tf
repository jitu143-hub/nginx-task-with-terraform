resource "aws_vpc" "myvpc01" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  
  tags = {
   name = "myvpc01"
   }
}  
resource "aws_subnet" "public-subnet01" {
  vpc_id = aws_vpc.myvpc01.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.AWS_REGION}a"
  
  tags = { 
   name = "public-subnet01"
   }
} 
 resource "aws_subnet" "public-subnet02" {
  vpc_id = aws_vpc.myvpc01.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.AWS_REGION}b"
  
  tags = { 
   name = "public-subnet02"
   }
} 
resource "aws_internet_gateway" "myigt" {
   vpc_id = aws_vpc.myvpc01.id
   
   tags = {
     name = "myigt"
	 }
}
resource "aws_route_table" "public-route" {
   vpc_id = aws_vpc.myvpc01.id
   route {
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.myigt.id
	  }
   
   tags = {
     name = "public-route"
	 }
} 
	 
resource "aws_route_table_association" "public-subenet01-route-association" {
   route_table_id = aws_route_table.public-route.id
   subnet_id = aws_subnet.public-subnet01.id
   
}
	
resource "aws_route_table_association" "public-subenet02-route-association" {
   route_table_id = aws_route_table.public-route.id
   subnet_id = aws_subnet.public-subnet02.id

}
