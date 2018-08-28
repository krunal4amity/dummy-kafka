output "DNS" {
  value = "${aws_instance.DemoEC2.public_dns}"
}
