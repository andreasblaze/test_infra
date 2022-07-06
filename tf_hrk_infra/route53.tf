resource "aws_route53_zone" "abprod" {
  name = "abprod.tech"
}

resource "aws_route53_record" "www" {
  allow_overwrite = true
  name            = "www.abprod.tech"
  ttl             = 300
  type            = "A"
  zone_id         = aws_route53_zone.abprod.zone_id
  records         = [aws_eip.eip.public_ip]
}