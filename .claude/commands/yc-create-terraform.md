---
description: Генерация Terraform конфигурации для Yandex Cloud инфраструктуры
---

Вы - эксперт по Terraform для Yandex Cloud. Помогите создать конфигурацию инфраструктуры.

**Ваша задача:**

1. Узнайте требования к инфраструктуре
2. Создайте Terraform конфигурацию следуя best practices
3. Включите необходимые ресурсы и зависимости
4. Добавьте переменные для гибкости
5. Создайте outputs для удобства

**Базовая структура:**

```
terraform/
├── main.tf           # Основные ресурсы
├── variables.tf      # Переменные
├── outputs.tf        # Выходные значения
├── versions.tf       # Версии провайдеров
├── terraform.tfvars  # Значения переменных (не коммитить!)
└── README.md         # Документация
```

**Шаблон versions.tf:**

```hcl
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "terraform-state"
    region = "ru-central1"
    key    = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  zone = var.zone
}
```

**Типичные ресурсы:**

1. **VPC и сети:**
```hcl
resource "yandex_vpc_network" "main" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "sg" {
  name       = var.sg_name
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

2. **Compute Instance:**
```hcl
resource "yandex_compute_instance" "vm" {
  name        = var.instance_name
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.instance_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    nat                = var.assign_public_ip
    security_group_ids = [yandex_vpc_security_group.sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
    user-data = templatefile("${path.module}/cloud-init.yaml", {
      ssh_key = file(var.ssh_key_path)
    })
  }

  scheduling_policy {
    preemptible = var.preemptible
  }
}
```

3. **Managed Kubernetes:**
```hcl
resource "yandex_kubernetes_cluster" "k8s" {
  name        = var.cluster_name
  network_id  = yandex_vpc_network.main.id

  master {
    version = var.k8s_version
    zonal {
      zone      = var.zone
      subnet_id = yandex_vpc_subnet.subnet.id
    }

    public_ip = true

    security_group_ids = [yandex_vpc_security_group.sg.id]
  }

  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id

  release_channel = "STABLE"
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "workers" {
  cluster_id  = yandex_kubernetes_cluster.k8s.id
  name        = "workers"
  version     = var.k8s_version

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores  = var.node_cores
      memory = var.node_memory
    }

    boot_disk {
      size = var.node_disk_size
      type = var.node_disk_type
    }

    network_interface {
      subnet_ids         = [yandex_vpc_subnet.subnet.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.sg.id]
    }

    scheduling_policy {
      preemptible = var.nodes_preemptible
    }
  }

  scale_policy {
    auto_scale {
      min     = var.min_nodes
      max     = var.max_nodes
      initial = var.initial_nodes
    }
  }
}
```

4. **Managed PostgreSQL:**
```hcl
resource "yandex_mdb_postgresql_cluster" "postgres" {
  name        = var.db_cluster_name
  environment = var.environment
  network_id  = yandex_vpc_network.main.id

  config {
    version = var.postgres_version
    resources {
      resource_preset_id = var.db_preset
      disk_size          = var.db_disk_size
      disk_type_id       = var.db_disk_type
    }
  }

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.subnet.id
  }

  security_group_ids = [yandex_vpc_security_group.sg.id]
}

resource "yandex_mdb_postgresql_database" "db" {
  cluster_id = yandex_mdb_postgresql_cluster.postgres.id
  name       = var.database_name
  owner      = yandex_mdb_postgresql_user.db_user.name
}

resource "yandex_mdb_postgresql_user" "db_user" {
  cluster_id = yandex_mdb_postgresql_cluster.postgres.id
  name       = var.db_username
  password   = var.db_password
}
```

5. **Object Storage:**
```hcl
resource "yandex_iam_service_account" "s3_sa" {
  name = var.s3_sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "s3_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.s3_sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "s3_key" {
  service_account_id = yandex_iam_service_account.s3_sa.id
}

resource "yandex_storage_bucket" "bucket" {
  access_key = yandex_iam_service_account_static_access_key.s3_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3_key.secret_key
  bucket     = var.bucket_name

  versioning {
    enabled = var.bucket_versioning
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = var.bucket_retention_days
    }
  }
}
```

**Variables.tf шаблон:**

```hcl
variable "zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-a"
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "main-network"
}

# Добавьте другие переменные по необходимости
```

**Outputs.tf шаблон:**

```hcl
output "instance_ip" {
  description = "Public IP of the instance"
  value       = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

output "k8s_cluster_id" {
  description = "Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.k8s.id
}

output "db_connection" {
  description = "Database connection string"
  value       = "postgresql://${var.db_username}@${yandex_mdb_postgresql_cluster.postgres.host.0.fqdn}:6432/${var.database_name}"
  sensitive   = true
}
```

**Команды для работы:**

```bash
# Инициализация
terraform init

# Планирование
terraform plan -out=tfplan

# Применение
terraform apply tfplan

# Уничтожение
terraform destroy

# Форматирование
terraform fmt -recursive

# Валидация
terraform validate
```

Спросите пользователя:
- Какие ресурсы нужно создать?
- Какое окружение (dev/test/prod)?
- Нужны ли дополнительные настройки (autoscaling, monitoring)?
- Где хранить state (локально или в S3)?

Создайте полную конфигурацию с комментариями и примерами использования.
