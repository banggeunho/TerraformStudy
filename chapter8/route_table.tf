resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  

  tags = {
   Name = "terraform-rt-public"
  }
}


resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  tags = {
   Name = "terraform-rt-private"
  }
}

resource "aws_route_table_association" "route_table_association_public" {
  
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "route_table_association_private" {

  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "private_nat" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-2.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id = aws_route_table.private.id
}


  
