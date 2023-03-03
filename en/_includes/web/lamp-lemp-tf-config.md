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

resource "yandex_compute_instance" "vm-lamp" {
  name        = "lamp-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "<VM_image_ID>"
    }
  }

  network_interface {
    subnet_id          = "${yandex_vpc_subnet.subnet-1.id}"
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]

  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<path_to_public_SSH_key>")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "web-network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
}

resource "yandex_vpc_security_group" "sg-1" {
  name        = "sg-web"
  description = "Description for security group"
  network_id  = "${yandex_vpc_network.network-1.id}"

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

resource "yandex_dns_zone" "zone1" {
  name        = "example-zone-1"
  description = "Public zone"
  zone        = "example.com."
  public      = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "www"
  type    = "CNAME"
  ttl     = 200
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
  endpoint  = "api.cloudil.com:443"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-lamp" {
  name        = "lamp-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }

  boot_disk {
    initialize_params {
      image_id = "<VM_image_ID>"
    }
  }

  network_interface {
    subnet_id          = "${yandex_vpc_subnet.subnet-1.id}"
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]

  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<path_to_public_SSH_key>")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "web-network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
}

resource "yandex_vpc_security_group" "sg-1" {
  name        = "sg-web"
  description = "Description for security group"
  network_id  = "${yandex_vpc_network.network-1.id}"

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

resource "yandex_dns_zone" "zone1" {
  name        = "example-zone-1"
  description = "Public zone"
  zone        = "example.com."
  public      = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "www"
  type    = "CNAME"
  ttl     = 200
  data    = ["example.com"]
}
```

{% endif %}
