data "aws_ami" "ubuntu_1804" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

#get workstation ip address
data "http" "workstation_ip" {
  url = "http://icanhazip.com"
}
###output keypair
resource "null_resource" "keypair_output" {
  provisioner "local-exec" {
    command = "echo '${module.ec2_keypair.aws_privatekey}' > ../files/your-keypair.pem"
  }
}

#####create ansible inventory####
resource "local_file" "ansible_inventory" {
  count = 1

content = "[ec2-host]\n${join("\n",
            formatlist(
              "%s ansible_ssh_private_key_file=../../terraform/files/your-keypair.pem ",
              module.ec2_instance.aws_instance_private_ip
            ))}"
filename = "../../ansible/inventory/ansible_inventory"
}