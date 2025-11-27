```hcl
# Declaring variables with sensitive data

variable "main_domain" {
  type = string
}

variable "extra_domain" {
  type = string
}

variable "folder_id" {
  type = string
}

locals {
  test = [ yandex_dns_zone.zone1.id, yandex_dns_zone.zone2.id]
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

# Creating buckets

resource "yandex_storage_bucket" "main-bucket" {
  bucket    = var.main_domain
  folder_id = var.folder_id
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  https {
    certificate_id = data.yandex_cm_certificate.example_by_id.id
  }

  depends_on = [data.yandex_cm_certificate.example_by_id]
}

resource "yandex_storage_bucket" "extra-bucket" {
  bucket    = var.extra_domain
  folder_id = var.folder_id
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
  website {
    redirect_all_requests_to = "https://${var.main_domain}"
  }

  https {
    certificate_id = data.yandex_cm_certificate.example_by_id.id
  }

  depends_on = [data.yandex_cm_certificate.example_by_id]
}

# Uploading the main page to the bucket

resource "yandex_storage_object" "index-page" {
  bucket     = yandex_storage_bucket.main-bucket.id
  key        = "index.html"
  source     = "index.html"
}

# Creating DNS zones and resource records

resource "yandex_dns_zone" "zone1" {
  name    = "main-domain-zone"
  zone    = "${var.main_domain}."
  public  = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "@"
  type    = "CNAME"
  ttl     = 600
  data    = ["${var.main_domain}.{{ s3-web-host }}"]
}

resource "yandex_dns_zone" "zone2" {
  name    = "extra-domain-zone"
  zone    = "${var.extra_domain}."
  public  = true
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone2.id
  name    = "@"
  type    = "CNAME"
  ttl     = 600
  data    = ["${var.extra_domain}.{{ s3-web-host }}"]
}


# Creating a Let's Encrypt TLS certificate

resource "yandex_cm_certificate" "example" {
  name    = "multidomains-cert"
  domains = ["${var.main_domain}", "${var.extra_domain}"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 2 # for each domain
  }
}

resource "yandex_dns_recordset" "example" {
  count   = yandex_cm_certificate.example.managed[0].challenge_count
  zone_id = element(local.test, count.index - 1)
  name    = yandex_cm_certificate.example.challenges[count.index].dns_name
  type    = yandex_cm_certificate.example.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.example.challenges[count.index].dns_value]
  ttl     = 600
}

data "yandex_cm_certificate" "example_by_id" {
  depends_on     = [yandex_dns_recordset.example]
  certificate_id = yandex_cm_certificate.example.id
}
```
