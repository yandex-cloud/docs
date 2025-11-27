```hcl
# Declaring variables with sensitive data

variable "folder_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "cert_id" {
  type = string
}

# Configuring the provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.136.0"
}

# Getting TLS certificate info

data "yandex_cm_certificate" "example_by_id" {
  certificate_id = var.cert_id
}

# Creating a bucket

resource "yandex_storage_bucket" "main-bucket" {
  bucket    = var.domain
  folder_id = var.folder_id
  max_size  = "1073741824"
  website {
    index_document = "index.html"
  }
  https {
    certificate_id = data.yandex_cm_certificate.example_by_id.id
  }

  depends_on = [data.yandex_cm_certificate.example_by_id]
}

# Configuring access permissions for a bucket

resource "yandex_storage_bucket_grant" "my_grant_main" {
  bucket = yandex_storage_bucket.main-bucket.id
  grant {
    uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
    permissions = ["READ"]
    type        = "Group"
  }
  depends_on = [yandex_storage_bucket.main-bucket]
}

# Upload an object to a bucket

resource "yandex_storage_object" "index-page" {
  bucket     = yandex_storage_bucket.main-bucket.id
  key        = "index.html"
  source     = "index.html"
  depends_on = [yandex_storage_bucket_grant.my_grant_main]
}

# Creating a DNS zone

resource "yandex_dns_zone" "zone1" {
  name   = "mydnszone"
  zone   = "${var.domain}."
  public = true
}

# Creating a DNS record

resource "yandex_dns_recordset" "rs1" {
  zone_id    = yandex_dns_zone.zone1.id
  name       = "cdn"
  type       = "CNAME"
  ttl        = 600
  data       = ["${data.yandex_cdn_resource.my_resource.provider_cname}"]
  depends_on = [yandex_cdn_resource.my_resource]
}

# Getting CDN resource info

data "yandex_cdn_resource" "my_resource" {
  resource_id = yandex_cdn_resource.my_resource.id
}

# Creating an origin group

resource "yandex_cdn_origin_group" "my_group" {
  name     = "updates-origin-group"
  use_next = true
  origin {
    source = "${var.domain}.{{ s3-web-host }}"
  }
}

# Creating a CDN resource

resource "yandex_cdn_resource" "my_resource" {
  cname             = "cdn.${var.domain}"
  active            = true
  origin_protocol   = "http"
  origin_group_name = yandex_cdn_origin_group.my_group.name
  options {
    custom_host_header     = "${var.domain}.{{ s3-web-host }}"
    redirect_http_to_https = true
  }
  ssl_certificate {
    type                   = "certificate_manager"
    certificate_manager_id = data.yandex_cm_certificate.example_by_id.id
  }
}
```