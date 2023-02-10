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

resource "yandex_compute_instance" "vm-wordpress-mysql" {
  name        = "wp-mysql-tutorial-web"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "<идентификатор_образа>"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
    nat                = true
  }

  metadata = {
    ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
  }
}

resource "yandex_mdb_mysql_cluster" "wp-cluster" {
  name                = "wp-mysql-tutorial-db-cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network-1.id
  version             = "8.0"
  security_group_ids  = ["${yandex_vpc_security_group.sg-1.id}"]

  resources {
    resource_preset_id = "s2.small"
    disk_type_id       = "network-ssd"
    disk_size          = "10"
  }

  host {
    zone             = "ru-central1-a"
    subnet_id        = yandex_vpc_subnet.subnet-1.id
    assign_public_ip = false
  }

  host {
    zone             = "ru-central1-b"
    subnet_id        = yandex_vpc_subnet.subnet-2.id
    assign_public_ip = false
  }

  host {
    zone             = "ru-central1-c"
    subnet_id        = yandex_vpc_subnet.subnet-3.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_mysql_database" "wp-db" {
  cluster_id = yandex_mdb_mysql_cluster.wp-cluster.id
  name       = "wp-mysql-tutorial-db"
}

resource "yandex_mdb_mysql_user" "wp-user" {
  cluster_id            = yandex_mdb_mysql_cluster.wp-cluster.id
  name                  = "wordpress"
  password              = "password"
  authentication_plugin = "MYSQL_NATIVE_PASSWORD"
  permission {
    database_name = yandex_mdb_mysql_database.wp-db.name
    roles         = ["ALL"]
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
    description    = "ext-ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-msql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
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

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
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
  data    = ["${yandex_compute_instance.vm-wordpress-mysql.network_interface.0.nat_ip_address}"]
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
  endpoint  = "api.cloudil.com:443"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-wordpress-mysql" {
  name        = "wp-mysql-tutorial-web"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "<идентификатор_образа>"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
    nat                = true
  }

  metadata = {
    ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
  }
}

resource "yandex_mdb_mysql_cluster" "wp-cluster" {
  name                = "wp-mysql-tutorial-db-cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network-1.id
  version             = "8.0"
  security_group_ids  = ["${yandex_vpc_security_group.sg-1.id}"]

  resources {
    resource_preset_id = "s2.small"
    disk_type_id       = "network-ssd"
    disk_size          = "10"
  }

  host {
    zone             = "ru-central1-a"
    subnet_id        = yandex_vpc_subnet.subnet-1.id
    assign_public_ip = false
  }

  host {
    zone             = "ru-central1-b"
    subnet_id        = yandex_vpc_subnet.subnet-2.id
    assign_public_ip = false
  }

  host {
    zone             = "ru-central1-c"
    subnet_id        = yandex_vpc_subnet.subnet-3.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_mysql_database" "wp-db" {
  cluster_id = yandex_mdb_mysql_cluster.wp-cluster.id
  name       = "wp-mysql-tutorial-db"
}

resource "yandex_mdb_mysql_user" "wp-user" {
  cluster_id            = yandex_mdb_mysql_cluster.wp-cluster.id
  name                  = "wordpress"
  password              = "password"
  authentication_plugin = "MYSQL_NATIVE_PASSWORD"
  permission {
    database_name = yandex_mdb_mysql_database.wp-db.name
    roles         = ["ALL"]
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
    description    = "ext-ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-msql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
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

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
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
  data    = ["${yandex_compute_instance.vm-wordpress-mysql.network_interface.0.nat_ip_address}"]
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
