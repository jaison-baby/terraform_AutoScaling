## Creating Launch Configuration

resource "aws_launch_configuration" "as-launch" {
  image_id               = aws_ami_from_instance.new_nginx_ami.id
  instance_type          = "t2.micro"
  security_groups        = [ var.security_groupid ]
  key_name               = var.key_name
  associate_public_ip_address = true
  }



## Creating AutoScaling Group

resource "aws_autoscaling_group" "as-group" {
  
  launch_configuration = aws_launch_configuration.as-launch.id 
  desired_capacity = 2
  min_size = 2
  max_size = 4
  vpc_zone_identifier  = [ var.as_subnet1 ]
  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_ami_from_instance" "new_nginx_ami" {
  name               = "terraform-nginx"
  source_instance_id = var.instance_id2
}
