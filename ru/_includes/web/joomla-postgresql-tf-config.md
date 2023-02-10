{% if product == "yandex-cloud" %}

```hcl
# Объявление переменных для пользовательских параметров

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "dns_zone" {
  type = string
}

variable "dns_recordset_name" {
  type = string
}

# Добавление прочих переменных

locals {
  network_name       = "example-network"
  subnet_name1       = "subnet-1"
  subnet_name2       = "subnet-2"
  subnet_name3       = "subnet-3"
  sg_vm_name         = "sg-vm"
  sg_pgsql_name      = "sg-pgsql"
  vm_name            = "joomla-pg-tutorial-web"
  cluster_name       = "joomla-pg-tutorial-db-cluster"
  db_name            = "joomla-pg-tutorial-db"
  dns_zone_name      = "example-zone-1"
}

# Настройка провайдера

terraform {
  required_providers {
    yandex    = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
}

# Создание облачной сети

resource "yandex_vpc_network" "joomla-pg-network" {
  name = local.network_name
}

# Создание подсети в зоне доступности {{ region-id }}-a

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-a" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = ["10.128.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание подсети в зоне доступности {{ region-id }}-b

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-b" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = ["10.129.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание подсети в зоне доступности {{ region-id }}-c

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-c" {
  name           = local.subnet_name3
  zone           = "{{ region-id }}-c"
  v4_cidr_blocks = ["10.130.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание группы безопасности для кластера БД {{ PG }}

resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = local.sg_pgsql_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  ingress {
    description    = "{{ PG }}"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Создание группы безопасности для ВМ

resource "yandex_vpc_security_group" "vm-sg" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  egress {
    protocol       = "ANY"
    description    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    description    = "HTTP"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    description    = "HTTPS"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    description    = "SSH"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Добавление готового образа ВМ

resource "yandex_compute_image" "joomla-pg-vm-image" {
  source_family = "centos-stream-8"
}

# Создание ВМ

resource "yandex_compute_instance" "joomla-pg-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = "{{ region-id }}-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.joomla-pg-vm-image.id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
    nat                = true
    security_group_ids = [ yandex_vpc_security_group.vm-sg.id ]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание кластера БД {{ PG }}

resource "yandex_mdb_postgresql_cluster" "joomla-pg-cluster" {
  name                = local.cluster_name
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.joomla-pg-network.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]

  config {
    version = "14"
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  host {
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
  }

  host {
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
  }

  host {
    zone      = "{{ region-id }}-c"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-c.id
  }
}

# Создание БД

resource "yandex_mdb_postgresql_database" "joomla-pg-tutorial-db" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = local.db_name
  owner      = var.db_user
}

# Создание пользователя БД

resource "yandex_mdb_postgresql_user" "joomla-user" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = var.db_user
  password   = var.db_password
}

# Создание зоны DNS

resource "yandex_dns_zone" "joomla-pg" {
  name    = local.dns_zone_name
  zone    = var.dns_zone
  public  = true
}

# Создание ресурсной записи типа А

resource "yandex_dns_recordset" "joomla-pg-a" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = var.dns_recordset_name
  type    = "A"
  ttl     = 600
  data    = [ yandex_compute_instance.joomla-pg-vm.network_interface.0.nat_ip_address ]
}

# Создание ресурсной записи типа CNAME

resource "yandex_dns_recordset" "joomla-pg-cname" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = "www"
  type    = "CNAME"
  ttl     = 600
  data    = [ var.dns_zone ]
}
```

{% endif %}

{% if product == "cloud-il" %}

```hcl
# Объявление переменных для конфиденциальных параметров

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "dns_zone" {
  type = string
}

variable "dns_recordset_name" {
  type = string
}

# Добавление прочих переменных

locals {
  network_name       = "example-network"
  subnet_name1       = "subnet-1"
  subnet_name2       = "subnet-2"
  subnet_name3       = "subnet-3"
  sg_vm_name         = "sg-vm"
  sg_pgsql_name      = "sg-pgsql"
  vm_name            = "joomla-pg-tutorial-web"
  cluster_name       = "joomla-pg-tutorial-db-cluster"
  db_name            = "joomla-pg-tutorial-db"
  dns_zone_name      = "example-zone-1"
}

# Настройка провайдера

terraform {
  required_providers {
    yandex    = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  endpoint  = "{{ api-host }}:443"
  folder_id = var.folder_id
}

# Создание облачной сети

resource "yandex_vpc_network" "joomla-pg-network" {
  name = local.network_name
}

# Создание подсети в зоне доступности {{ region-id }}-a

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-a" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = ["10.128.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание подсети в зоне доступности {{ region-id }}-b

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-b" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = ["10.129.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание подсети в зоне доступности {{ region-id }}-c

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-c" {
  name           = local.subnet_name3
  zone           = "{{ region-id }}-c"
  v4_cidr_blocks = ["10.130.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Создание группы безопасности для кластера БД {{ PG }}

resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = local.sg_pgsql_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  ingress {
    description    = "{{ PG }}"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Создание группы безопасности для ВМ

resource "yandex_vpc_security_group" "vm-sg" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  egress {
    protocol       = "ANY"
    description    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    description    = "HTTP"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    description    = "HTTPS"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    description    = "SSH"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Добавление готового образа ВМ

resource "yandex_compute_image" "joomla-pg-vm-image" {
  source_family = "centos-stream-8"
}

# Создание ВМ

resource "yandex_compute_instance" "joomla-pg-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = "{{ region-id }}-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.joomla-pg-vm-image.id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
    nat                = true
    security_group_ids = [ yandex_vpc_security_group.vm-sg.id ]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание кластера БД {{ PG }}

resource "yandex_mdb_postgresql_cluster" "joomla-pg-cluster" {
  name                = local.cluster_name
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.joomla-pg-network.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]

  config {
    version = "14"
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  host {
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
  }

  host {
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
  }

  host {
    zone      = "{{ region-id }}-c"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-c.id
  }
}

# Создание БД

resource "yandex_mdb_postgresql_database" "joomla-pg-tutorial-db" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = local.db_name
  owner      = var.db_user
}

# Создание пользователя БД

resource "yandex_mdb_postgresql_user" "joomla-user" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = var.db_user
  password   = var.db_password
}

# Создание зоны DNS

resource "yandex_dns_zone" "joomla-pg" {
  name    = local.dns_zone_name
  zone    = var.dns_zone
  public  = true
}

# Создание ресурсной записи типа А

resource "yandex_dns_recordset" "joomla-pg-a" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = var.dns_recordset_name
  type    = "A"
  ttl     = 600
  data    = [ yandex_compute_instance.joomla-pg-vm.network_interface.0.nat_ip_address ]
}

# Создание ресурсной записи типа CNAME

resource "yandex_dns_recordset" "joomla-pg-cname" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = "www"
  type    = "CNAME"
  ttl     = 600
  data    = [ var.dns_zone ]
}
```

{% endif %}
