```hcl
# Объявление переменных

variable "folder_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "subdomain_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "cdn_cname" {
  type = string
}

variable "secure_key" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "index_file_path" {
  type = string
}

variable "content_file_path" {
  type = string
}

locals {
  sa_name          = "my-service-account"
  network_name     = "webserver-network"
  subnet_name      = "webserver-subnet-{{ region-id }}-b"
  sg_name          = "webserver-sg"
  vm_name          = "mywebserver"
  domain_zone_name = "my-domain-zone"
  cert_name        = "mymanagedcert"
  origin_gp_name   = "my-origin-group"
}

# Настройка провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  folder_id = var.folder_id
}

# Создание сервисного аккаунта

resource "yandex_iam_service_account" "ig-sa" {
  name = local.sa_name
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "storage-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

# Создание статического ключа доступа для СА

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
}

# Создание сети

resource "yandex_vpc_network" "webserver-network" {
  name = local.network_name
}

# Создание подсети

resource "yandex_vpc_subnet" "webserver-subnet-b" {
  name           = local.subnet_name
  zone           = "{{ region-id }}-b"
  network_id     = "${yandex_vpc_network.webserver-network.id}"
  v4_cidr_blocks = ["192.168.1.0/24"]
}

# Создание группы безопасности

resource "yandex_vpc_security_group" "webserver-sg" {
  name        = local.sg_name
  network_id  = "${yandex_vpc_network.webserver-network.id}"

  ingress {
    protocol       = "TCP"
    description    = "http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Создание загрузочного диска для ВМ

resource "yandex_compute_disk" "boot-disk" {
  type     = "network-ssd"
  zone     = "{{ region-id }}-b"
  size     = "20"
  image_id = "fd8jtn9i7e9ha5q25niu"
}

# Создание ВМ

resource "yandex_compute_instance" "mywebserver" {
  name        = local.vm_name
  platform_id = "standard-v2"
  zone        = "{{ region-id }}-b"

  resources {
    cores  = "2"
    memory = "2"
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = "${yandex_vpc_subnet.webserver-subnet-b.id}"
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.webserver-sg.id}"]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание публичной DNS-зоны

resource "yandex_dns_zone" "my-domain-zone" {
  name    = local.domain_zone_name
  zone    = "${var.domain_name}."
  public  = true
}

# Создание ресурсной A-записи для веб-сервера

resource "yandex_dns_recordset" "rsА1" {
  zone_id = yandex_dns_zone.my-domain-zone.id
  name    = "${yandex_dns_zone.my-domain-zone.zone}"
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.mywebserver.network_interface.0.nat_ip_address}"]
}

# Добавление сертификата Let's Encrypt

resource "yandex_cm_certificate" "le-certificate" {
  name    = local.cert_name
  domains = [var.domain_name,"${var.subdomain_name}.${var.domain_name}"]

  managed {
  challenge_type = "DNS_CNAME"
  challenge_count = 2
  }
}

# Создание CNAME-записей для валидации доменов при выпуске сертификата

resource "yandex_dns_recordset" "validation-record" {
  count   = yandex_cm_certificate.le-certificate.managed[0].challenge_count
  zone_id = yandex_dns_zone.my-domain-zone.id
  name    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_name
  type    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_type
  ttl     = 600
  data    = [yandex_cm_certificate.le-certificate.challenges[count.index].dns_value]
}

# Ожидание валидации доменов и выпуска сертификата Let's Encrypt

data "yandex_cm_certificate" "example-com" {
  depends_on      = [yandex_dns_recordset.validation-record]
  certificate_id  = yandex_cm_certificate.le-certificate.id
  wait_validation = true
}

# Создание бакета

resource "yandex_storage_bucket" "cdn-source" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.bucket_name
  max_size   = 1073741824

  anonymous_access_flags {
    read = true
    list = true
  }

  website {
    index_document = "index.html"
  }
}

# Загрузка в бакет главной страницы веб-сайта

resource "yandex_storage_object" "index-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "${yandex_storage_bucket.cdn-source.bucket}"
  key        = var.index_file_path
  source     = var.index_file_path
}

# Загрузка в бакет файла с тестовым контентом

resource "yandex_storage_object" "content-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "${yandex_storage_bucket.cdn-source.bucket}"
  key        = var.content_file_path
  source     = var.content_file_path
}

# Создание группы источников CDN

resource "yandex_cdn_origin_group" "my-origin-group" {
  name = local.origin_gp_name
  origin {
    source = "${var.bucket_name}.website.yandexcloud.net"
  }
}

# Создание CDN-ресурса

resource "yandex_cdn_resource" "my-resource" {
  cname               = "${var.subdomain_name}.${var.domain_name}"
  active              = true
  origin_protocol     = "match"
  origin_group_id     = "${yandex_cdn_origin_group.my-origin-group.id}"
  ssl_certificate {
    type = "certificate_manager"
    certificate_manager_id = "${data.yandex_cm_certificate.example-com.id}"
  }
  options {
    custom_host_header    = "${var.bucket_name}.website.yandexcloud.net"
    secure_key            = "${var.secure_key}"
    enable_ip_url_signing = true
  }
}

# Создание CNAME-записи для CDN-ресурса

resource "yandex_dns_recordset" "cdn-cname" {
  zone_id = yandex_dns_zone.my-domain-zone.id
  name    = "${yandex_cdn_resource.my-resource.cname}."
  type    = "CNAME"
  ttl     = 600
  data    = [var.cdn_cname]
}
```