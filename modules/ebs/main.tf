resource "aws_ebs_volume" "volume" {
  availability_zone = "us-east-1c"
  size              = var.taille

  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume.id
  instance_id = var.instance_id
}
