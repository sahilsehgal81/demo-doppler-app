module "frontend" {
  source                = "../../modules/"
  env                   = "test"
  project               = "demo"
  key_name              = "demo-test"
  vpc_id                = "vpc-784fcc02"
  subnet_id             = "subnet-a53c418b"
  length                = "1"
  instance_type         = "t3.medium"
  ami                   = "ami-0e001c9271cf7f3b9"
  volume_size           = "50"
  volume_type           = "gp3"
  encrypted             = true
  delete_on_termination = false
  eip                   = true
  load_balancer         = false
  ssh_ports             = [22]
  ssh_cidr_block        = ["0.0.0.0/0"]
  web_ports             = [80, 443]
  web_cidr_blocks       = ["0.0.0.0/0"]
  iam_role              = "ssm_parameter"
}
