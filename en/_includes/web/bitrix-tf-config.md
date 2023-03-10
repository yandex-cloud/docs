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
  zone = "{{ region-id }}-a"
}

resource "yandex_compute_instance" "vm-bitrix" {
  name        = "bitrixwebsite"
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3"
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
    nat                = true
  }

  metadata = {
    ssh-keys = "<username>:<SSH_key_contents>"
  }
}

resource "yandex_mdb_mysql_cluster" "bitrix-cluster" {
  name               = "BitrixMySQL"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.network-1.id
  version            = "8.0"
  security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = "10"
  }

  host {
    zone             = "{{ region-id }}-a"
    subnet_id        = yandex_vpc_subnet.subnet-1.id
    assign_public_ip = false
  }

  host {
    zone             = "{{ region-id }}-b"
    subnet_id        = yandex_vpc_subnet.subnet-2.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_mysql_database" "bitrix-db" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = "db1"
}

resource "yandex_mdb_mysql_user" "bitrix-user" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = "user1"
  password   = "p@s$woRd!"
  permission {
    database_name = yandex_mdb_mysql_database.bitrix-db.name
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
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "{{ region-id }}-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
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
  zone      = "{{ region-id }}-a"
}

resource "yandex_compute_instance" "vm-bitrix" {
  name        = "bitrixwebsite"
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8kdq6d0p8sij7h5qe3"
      type     = "network-ssd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]
    nat                = true
  }

  metadata = {
    ssh-keys = "<username>:<SSH_key_contents>"
  }
}

resource "yandex_mdb_mysql_cluster" "bitrix-cluster" {
  name               = "BitrixMySQL"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.network-1.id
  version            = "8.0"
  security_group_ids = ["${yandex_vpc_security_group.sg-1.id}"]

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = "10"
  }

  host {
    zone             = "{{ region-id }}-a"
    subnet_id        = yandex_vpc_subnet.subnet-1.id
    assign_public_ip = false
  }

  host {
    zone             = "{{ region-id }}-b"
    subnet_id        = yandex_vpc_subnet.subnet-2.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_mysql_database" "bitrix-db" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = "db1"
}

resource "yandex_mdb_mysql_user" "bitrix-user" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = "user1"
  password   = "p@s$woRd!"
  permission {
    database_name = yandex_mdb_mysql_database.bitrix-db.name
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
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "{{ region-id }}-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}
```

{% endif %}
