
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
  zone = "{{ region-id }}-a"
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_security_group" "fileserver-tutorial-sg" {
  name       = "fileserver-tutorial-sg"
  network_id = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-msql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
  }
}

resource "yandex_compute_image" "ubuntu-1804-lts" {
  source_family = "ubuntu-1804-lts"
}

resource "yandex_compute_disk" "boot-disk" {
  name     = "fileserver-tutorial-disk"
  type     = "network-ssd"
  zone     = "{{ region-id }}-a"
  size     = "100"
  image_id = yandex_compute_image.ubuntu-1804-lts.id
}

resource "yandex_compute_instance" "fileserver-tutorial" {
  name        = "fileserver-tutorial"
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 100
    cores         = 8
    memory        = 56
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = [yandex_vpc_security_group.fileserver-tutorial-sg.id]
    nat                = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
  }
}
```


