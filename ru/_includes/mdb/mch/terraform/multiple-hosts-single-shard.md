{% cut "cluster.tf" %}

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "mych" {
  name               = "mych"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.cluster-net.id
  security_group_ids = [yandex_vpc_default_security_group.cluster-sg.id]

  clickhouse = {
    resources = {
      resource_preset_id = "{{ host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 32
    }
  }

  zookeeper = {
    resources = {
      resource_preset_id = "{{ zk-host-class }}"
      disk_type_id       = "{{ disk-type-example }}"
      disk_size          = 10
    }
  }

  shards = {
    "shard1" = {
      weight = 1
    }
  }

  hosts = {

    "h1" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-a"
      subnet_id  = yandex_vpc_subnet.cluster-subnet-a.id
      shard_name = "shard1"
    }

    "h2" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-b"
      subnet_id  = yandex_vpc_subnet.cluster-subnet-b.id
      shard_name = "shard1"
    }

    "h3" = {
      type       = "CLICKHOUSE"
      zone       = "ru-central1-d"
      subnet_id  = yandex_vpc_subnet.cluster-subnet-d.id
      shard_name = "shard1"
    }

    "h4" = {
      type      = "ZOOKEEPER"
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.cluster-subnet-a.id
    }

    "h5" = {
      type      = "ZOOKEEPER"
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.cluster-subnet-b.id
    }

    "h6" = {
      type      = "ZOOKEEPER"
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.cluster-subnet-d.id
    }
  }

  maintenance_window {
    type = "ANYTIME"
  }
}

resource "yandex_mdb_clickhouse_database" "db1" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.mych.id
  name       = "db1"
}

resource "yandex_mdb_clickhouse_user" "user1" {
  cluster_id = yandex_mdb_clickhouse_cluster_v2.mych.id
  name       = "user1"
  password   = "user1user1"
  permission {
    database_name = yandex_mdb_clickhouse_database.db1.name
  }
}
```

{% endcut %}
