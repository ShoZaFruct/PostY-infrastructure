resource "yandex_storage_bucket" "static" {
  bucket     = "posty-static-bucket"
  access_key = var.access_key
  secret_key = var.secret_key
  acl        = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
