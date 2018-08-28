resource "aws_key_pair" "terra_key" {
  key_name   = "${var.key_nm}"
  public_key = "${file("${var.pub_key}")}"
}
