output "bucket_name" {
  description = "Bucket name for static website hosting"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "s3 website static hosting"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "The cloudfront distro domain name"
  value = module.terrahouse_aws.cloudfront_url
}