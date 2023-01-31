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

variable "folder_id" {
  description = "Yandex.Cloud Folder ID where resources will be created"
  default     = "<идентификатор_каталога>"
}

resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
  ]
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = "nlb-vm-group"
  folder_id          = var.folder_id
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
  instance_template {
    platform_id = "standard-v3"
    resources {
      core_fraction = 20
      memory        = 1
      cores         = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "<идентификатор_образа>"
        type     = "network-hdd"
        size     = 3
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}","${yandex_vpc_subnet.subnet-2.id}" ]
      nat        = true
    }

    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-a", "ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name = "nlb-tg"
  }
}

resource "yandex_lb_network_load_balancer" "foo" {
  name = "nlb-1"
  listener {
    name = "nlb-listener"
    port = 80
  }
  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id}"
    healthcheck {
      name                = "health-check-1"
      unhealthy_threshold = 5
      healthy_threshold   = 5
      http_options {
        port = 80
      }
    }
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.2.0/24"]
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

variable "folder_id" {
  description = "Yandex.Cloud Folder ID where resources will be created"
  default     = "<идентификатор_каталога>"
}

resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
  ]
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = "nlb-vm-group"
  folder_id          = var.folder_id
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
  instance_template {
    platform_id = "standard-v3"
    resources {
      core_fraction = 20
      memory        = 1
      cores         = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "<идентификатор_образа>"
        type     = "network-hdd"
        size     = 3
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}","${yandex_vpc_subnet.subnet-2.id}" ]
      nat        = true
    }

    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-a", "ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name = "nlb-tg"
  }
}

resource "yandex_lb_network_load_balancer" "foo" {
  name = "nlb-1"
  listener {
    name = "nlb-listener"
    port = 80
  }
  attached_target_group {
    target_group_id = "${yandex_compute_instance_group.ig-1.load_balancer.0.target_group_id}"
    healthcheck {
      name                = "health-check-1"
      unhealthy_threshold = 5
      healthy_threshold   = 5
        http_options {
          port = 80
        }
    }
  }
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.2.0/24"]
}
```

{% endif %}
