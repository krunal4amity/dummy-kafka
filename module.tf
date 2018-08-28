module "mydocker" {
  source        = "terra/"
  key_nm        = "key1"
  inst_type     = "t2.micro"
  instance_name = "MyDocker"
}
