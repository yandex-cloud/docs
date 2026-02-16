{% cut "cluster.tf" %}

```hcl
resource "yandex_mdb_clickhouse_cluster" "mych" {
  name               = "mych"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.cluster-net.id
  security_group_ids = [yandex_vpc_default_security_group.cluster-sg.id]

  clickhouse {
    resources {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.cluster-subnet-a.id
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.cluster-subnet-b.id
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "{{ region-id }}-d"
    subnet_id = yandex_vpc_subnet.cluster-subnet-d.id
  }

  zookeeper {
    resources {
      resource_preset_id = "{{ zk-host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.cluster-subnet-a.id
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.cluster-subnet-b.id
  }

  host {
    type      = "ZOOKEEPER"
    zone      = "{{ region-id }}-d"
    subnet_id = yandex_vpc_subnet.cluster-subnet-d.id
  }

  lifecycle {
    ignore_changes = [database, user]
  }
}

resource "yandex_mdb_clickhouse_database" "db1" {
  cluster_id = yandex_mdb_clickhouse_cluster.mych.id
  name       = "db1"
}

resource "yandex_mdb_clickhouse_user" "user1" {
  cluster_id = yandex_mdb_clickhouse_cluster.mych.id
  name       = "user1"
  password   = "user1user1"
  permission {
    database_name = yandex_mdb_clickhouse_database.db1.name
  }
}
```

{% endcut %}
