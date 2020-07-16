output "aws_publickkey" {
  value = "${aws_key_pair.generated_key.public_key}"
}
output "aws_keyname" {
  value = "${aws_key_pair.generated_key.key_name}"
}
output "aws_privatekey" {
  value = "${tls_private_key.example.private_key_pem}"
}