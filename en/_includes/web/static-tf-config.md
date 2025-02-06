```hcl
locals {
  folder_id = "<folder_ID>"
  domain    = "<domain>"
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = local.folder_id
}

resource "yandex_iam_service_account" "sa" {
  name      = "my-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.domain
  max_size   = 1073741824  
  acl        = "public-read"
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Certificate Manager certificate
  https {
    certificate_id = data.yandex_cm_certificate.example.id
  }
}

resource "yandex_cm_certificate" "le-certificate" {
  name    = "my-le-cert"
  domains = ["${local.domain}"]

  managed {
  challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "validation-record" {
  zone_id = yandex_dns_zone.zone1.id
  name    = yandex_cm_certificate.le-certificate.challenges[0].dns_name
  type    = yandex_cm_certificate.le-certificate.challenges[0].dns_type
  data    = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
  ttl     = 600
}

data "yandex_cm_certificate" "example" {
  depends_on      = [yandex_dns_recordset.validation-record]
  certificate_id  = yandex_cm_certificate.le-certificate.id
  #wait_validation = true
}

resource "yandex_storage_object" "index-html" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.test.id
  key        = "index.html"
  source     = "index.html"
}

resource "yandex_storage_object" "error-html" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.test.id
  key        = "error.html"
  source     = "error.html"
}

resource "yandex_dns_zone" "zone1" {
  name        = "example-zone-1"
  description = "Public zone"
  zone        = "${local.domain}."
  public      = true
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "${local.domain}."
  type    = "ANAME"
  ttl     = 600
  data    = ["${local.domain}.website.yandexcloud.net"]
}
```