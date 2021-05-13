#Generates a secure private key and encodes it as PEM
resource "tls_private_key" "example" {
  algorithm = "${var.algorithm}"
  rsa_bits  = "${var.rsa_bits}"
}


#generate public key
resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

