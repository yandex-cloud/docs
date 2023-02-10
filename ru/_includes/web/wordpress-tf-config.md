{% if product == "yandex-cloud" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-wordpress" {
  name        = "wordpress"
  platform_id = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "fd8er6stcpm84o8rkpa8"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
  }

  metadata = {
    ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
  }
}

resource "yandex_vpc_security_group" "sg-1" {
  name        = "wordpress"
  description = "Description for security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_dns_zone" "zone-1" {
  name        = "example-zone-1"
  description = "Public zone"
  zone        = "example.com."
  public      = true
}

resource "yandex_dns_recordset" "rs-1" {
  zone_id = yandex_dns_zone.zone-1.id
  name    = "example.com."
  ttl     = 600
  type    = "A"
  data    = ["${yandex_compute_instance.vm-wordpress.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "rs-2" {
  zone_id = yandex_dns_zone.zone-1.id
  name    = "www"
  ttl     = 600
  type    = "CNAME"
  data    = ["example.com"]
}
```

{% endif %}

{% if product == "cloud-il" %}

```hcl
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  endpoint  = "{{ api-host }}"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-wordpress" {
  name        = "wordpress"
  platform_id = "standard-v3"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "fd8er6stcpm84o8rkpa8"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
  }

  metadata = {
    ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
  }
}

resource "yandex_vpc_security_group" "sg-1" {
  name        = "wordpress"
  description = "Description for security group"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_dns_zone" "zone-1" {
  name        = "example-zone-1"
  description = "Public zone"
  zone        = "example.com."
  public      = true
}

resource "yandex_dns_recordset" "rs-1" {
  zone_id = yandex_dns_zone.zone-1.id
  name    = "example.com."
  ttl     = 600
  type    = "A"
  data    = ["${yandex_compute_instance.vm-wordpress.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "rs-2" {
  zone_id = yandex_dns_zone.zone-1.id
  name    = "www"
  ttl     = 600
  type    = "CNAME"
  data    = ["example.com"]
}
```

{% endif %}
