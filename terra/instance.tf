# One Ec2 instance in public subnet	
resource "aws_instance" "DemoEC2" {
  #vpc_id="${aws_vpc.terraVPC.id}"
  ami                    = "ami-51537029"
  instance_type          = "${var.inst_type}"
  subnet_id              = "${var.pubsub}"
  key_name               = "${var.key_nm}"
  vpc_security_group_ids = ["${aws_security_group.access_node.id}", "${aws_security_group.access_ssh.id}", "${aws_security_group.jenkins.id}", "${aws_security_group.extra.id}"]
  user_data              = "${file("${var.myuserdata}")}"

  connection {
    user        = "ec2-user"
    private_key = "${file("${var.path_to_key}")}"
  }

  tags {
    Name = "${var.instance_name}"
  }
}
