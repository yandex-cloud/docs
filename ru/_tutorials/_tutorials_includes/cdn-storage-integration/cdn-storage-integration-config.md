```hcl
# Объявление переменных

variable "folder_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_file_path" {
  type = string
}

locals {
  network_name     = "example-network"
  subneta_name     = "example-subnet-{{ region-id }}-a"
  subnetb_name     = "example-subnet-{{ region-id }}-b"
  subnetd_name     = "example-subnet-{{ region-id }}-d"
  sg_name          = "example-sg"
  object_key       = "index.html"
  domain_zone_name = "my-domain-zone"
  cert_name        = "mymanagedcert"
  origin_gp_name   = "example-origin-group"
  bg_name          = "example-bg"
  backend_name     = "example-backend"
  router_name      = "example-router"
  vh_name          = "example-vh"
  route_name       = "example-route"   
  alb_name         = "example-balancer"
  listener_name    = "example-listener"
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

# Создание публичной DNS-зоны

resource "yandex_dns_zone" "my-domain-zone" {
  name    = local.domain_zone_name
  zone    = "${var.domain_name}."
  public  = true
}

# Добавление сертификата Let's Encrypt

resource "yandex_cm_certificate" "le-certificate" {
  name    = local.cert_name
  domains = [var.domain_name]

  managed {
  challenge_type = "DNS_CNAME"
  challenge_count = 1
  }
}

# Создание CNAME-записи для валидации доменов при выпуске сертификата

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

# Создание сети

resource "yandex_vpc_network" "my-network" {
  name = local.network_name
}

# Создание подсетей

resource "yandex_vpc_subnet" "my-subnet-a" {
  name           = local.subneta_name
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "my-subnet-b" {
  name           = local.subnetb_name
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "my-subnet-d" {
  name           = local.subnetd_name
  zone           = "{{ region-id }}-d"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}

# Создание группы безопасности

resource "yandex_vpc_security_group" "my-sg" {
  name        = local.sg_name
  network_id  = yandex_vpc_network.my-network.id

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
    protocol          = "TCP"
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 30080
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Создание бакета

resource "yandex_storage_bucket" "cdn-source-bucket" {
  bucket      = var.bucket_name
  folder_id   = var.folder_id

  anonymous_access_flags {
    read = true
    list = true
  }
}

# Загрузка в бакет главной страницы тестового сервиса

resource "yandex_storage_object" "index-object" {
  bucket        = yandex_storage_bucket.cdn-source-bucket.bucket
  key           = local.object_key
  source        = var.index_file_path
  content_type  = "text/html"
}

# Создание группы бэкендов

resource "yandex_alb_backend_group" "test-backend-group" {
  name                     = local.bg_name
  http_backend {
    name                   = local.backend_name
    weight                 = 100
    port                   = 80
    storage_bucket         = var.bucket_name
  }
}

# Создание HTTP-роутера

resource "yandex_alb_http_router" "my-router" {
  name          = local.router_name
}

# Создание виртуального хоста

resource "yandex_alb_virtual_host" "my-virtual-host" {
  name           = local.vh_name
  http_router_id = yandex_alb_http_router.my-router.id

  route {
    name = local.route_name

    http_route {
      http_match {
        http_method = ["GET"]
        path {
          prefix = "/"
        }
      }

      http_route_action {
        backend_group_id = yandex_alb_backend_group.test-backend-group.id
      }
    }
  }

  authority = [var.domain_name]
}

# Создание L7-балансировщика

resource "yandex_alb_load_balancer" "my-balancer" {
  name               = local.alb_name
  network_id         = yandex_vpc_network.my-network.id
  security_group_ids = [yandex_vpc_security_group.my-sg.id]

  allocation_policy {
    location {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.my-subnet-a.id
    }

    location {
      zone_id   = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.my-subnet-b.id
    }

    location {
      zone_id   = "{{ region-id }}-d"
      subnet_id = yandex_vpc_subnet.my-subnet-d.id
    }
  }

  listener {
    name = local.listener_name
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.my-router.id
      }
    }
  }
}

# Создание группы источников CDN

resource "yandex_cdn_origin_group" "my-origin-group" {
  name = local.origin_gp_name
  origin {
    source = yandex_alb_load_balancer.my-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
  }
}

# Создание CDN-ресурса

resource "yandex_cdn_resource" "my-resource" {
  cname               = var.domain_name
  active              = true
  origin_protocol     = "http"
  origin_group_id     = yandex_cdn_origin_group.my-origin-group.id
  ssl_certificate {
    type = "certificate_manager"
    certificate_manager_id = data.yandex_cm_certificate.example-com.id
  }
  options {
    redirect_http_to_https = true
    forward_host_header    = true
  }
}

# Создание CNAME-записи для CDN-ресурса

resource "yandex_dns_recordset" "cdn-cname" {
  zone_id = yandex_dns_zone.my-domain-zone.id
  name    = "${var.domain_name}."
  type    = "CNAME"
  ttl     = 600
  data    = [yandex_cdn_resource.my-resource.provider_cname]
}
```