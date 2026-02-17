---
subcategory: Managed Service for SPQR
---

# yandex_mdb_sharded_postgresql_cluster (Resource)

Manages a Sharded Postgresql cluster within the Yandex Cloud.

## Example usage

```terraform
//
// Create a new MDB Sharded PostgreSQL Cluster.
//
resource "yandex_mdb_sharded_postgresql_cluster" "default" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config = {
    backup_retain_period_days = 10
    sharded_postgresql_config = {
      common = {
        console_password = "P@ssw0rd"
        log_level = "INFO"
      }
      router = {
        resources = {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 32
        }
        config = {
          show_notice_messages = false
          prefer_same_availability_zone = true
        }
      }
      coordinator = {
        resources = {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 32
        }
      }
      balancer = {}
    }
  }

  hosts = {
    "router1" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.foo.id
      assign_public_ip = false
      type = "ROUTER"
    }
    "router2" = {
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.foo.id
      assign_public_ip = false
      type = "ROUTER"
    }
    "coordinator" = {
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.foo.id
      assign_public_ip = false
      type = "COORDINATOR"
    }
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```
```terraform
locals {
  shards = 4
  users = {
    alice: {
      "password": "password",
      "conn_limit": 30
    },
    bob: {
      "password": "mysupercoolpassword",
      "conn_limit": 15

    }
  }
  dbs = {"testdb": "alice", "anotherdb": "bob"}

  user_shard_combinations = flatten([
    for shard in range(local.shards) : [
      for user, cfg in local.users : {
        shard = shard
        name  = user
        settings = cfg
        key   = "${shard}-${user}"
      }
    ]
  ])
  db_shard_combinations = flatten([
    for shard in range(local.shards) : [
      for db, owner in local.dbs : {
        shard = shard
        db  = db
        owner = owner
        key   = "${shard}-${db}"
        owner_key = "${shard}-${owner}"
      }
    ]
  ])
}

/****************** PostgreSQL Shards Management ******************/

resource "yandex_mdb_postgresql_cluster_v2" "shard" {
  count = local.shards

  name        = "shard${count.index}"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {
    version = 17
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 16
    }

    postgresql_config = {
      max_connections                = 395
      enable_parallel_hash           = true
      autovacuum_vacuum_scale_factor = 0.34
      default_transaction_isolation  = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries       = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
      max_wal_senders = 20
      shared_buffers = 2147483648
    }
  }

  hosts = {
    "first" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.test-subnet-a.id
    }
    "second" = {
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.test-subnet-b.id
    }
    "third" = {
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.test-subnet-d.id
    }
  }
}

resource "yandex_mdb_postgresql_user" "shard_user" {
  for_each = { for combo in local.user_shard_combinations : combo.key => combo }

  cluster_id = yandex_mdb_postgresql_cluster_v2.shard[each.value.shard].id
  name       = "${each.value.name}"
  password   = "${each.value.settings.password}"
  conn_limit = "${each.value.settings.conn_limit}"
  settings = {
    default_transaction_isolation = "read committed"
    log_min_duration_statement    = 5000
  }
}

resource "yandex_mdb_postgresql_database" "shard_db" {
  for_each = { for combo in local.db_shard_combinations : combo.key => combo }

  cluster_id = yandex_mdb_postgresql_cluster_v2.shard[each.value.shard].id
  name       = "${each.value.db}"
  owner      = yandex_mdb_postgresql_user.shard_user[each.value.owner_key].name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
  extension {
    name = "uuid-ossp"
  }
  extension {
    name = "xml2"
  }
}

/****************** Sharded PostgreSQL Cluster Management ******************/

resource "yandex_mdb_sharded_postgresql_cluster" "default" {
  name        = "diphantxm-full"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.foo.id

  hosts = {
    "router2" = {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.test-subnet-a.id
      assign_public_ip = false
      type = "ROUTER"
    }
    "router1" = {
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.test-subnet-b.id
      assign_public_ip = false
      type = "ROUTER"
    }
    "router3" = {
      zone      = "ru-central1-d"
      subnet_id = yandex_vpc_subnet.test-subnet-d.id
      assign_public_ip = false
      type = "ROUTER"
    }
  }

  config = {
    backup_retain_period_days = 10
    sharded_postgresql_config = {
        common = {
            console_password = "password"
            log_level = "INFO"
        }
        router = {
            resources = {
                resource_preset_id = "s2.micro"
                disk_type_id       = "network-ssd"
                disk_size          = 32
            }
            config = {
              show_notice_messages = false
              prefer_same_availability_zone = true
            }
        }
        balancer = {}
    }
  }
}

resource "yandex_mdb_sharded_postgresql_database" "spqr_db" {
  for_each = local.dbs

  cluster_id = yandex_mdb_sharded_postgresql_cluster.default.id
  name       = "${each.key}"
}

resource "yandex_mdb_sharded_postgresql_user" "spqr_user" {
  for_each = local.users

  cluster_id = yandex_mdb_sharded_postgresql_cluster.default.id
  name       = "${each.key}"
  password   = "${each.value.password}"
  settings = {
    connection_limit = "${each.value.conn_limit}"
    connection_retries = 5
  }
}

resource "yandex_mdb_sharded_postgresql_shard" "shard" {
  count = local.shards

	cluster_id = yandex_mdb_sharded_postgresql_cluster.default.id
	name       = "shard${count.index}"
	shard_spec = {
		mdb_postgresql = yandex_mdb_postgresql_cluster_v2.shard[count.index].id
	}
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "test-subnet-a" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}
resource "yandex_vpc_subnet" "test-subnet-b" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}
resource "yandex_vpc_subnet" "test-subnet-d" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.3.0.0/24"]
}
```

## Arguments & Attributes Reference

- `config` [Block]. Configuration of the Sharded PostgreSQL cluster.
  - `access` [Block]. Access policy to the Sharded PostgreSQL cluster.
    - `data_lens` (Bool). Allow access for Yandex DataLens.
    - `data_transfer` (Bool). Allow access for DataTransfer
    - `serverless` (Bool). Allow access for connection to managed databases from functions
    - `web_sql` (Bool). Allow access for SQL queries in the management console
  - `backup_retain_period_days` (Number). The period in days during which backups are stored.
  - `backup_window_start` [Block]. Time to start the daily backup, in the UTC timezone.
    - `hours` (Number). The hour at which backup will be started (UTC).
    - `minutes` (Number). The minute at which backup will be started (UTC).
  - `sharded_postgresql_config` [Block]. Sharded PostgreSQL cluster configuration.
    - `balancer` (Map Of String). Balancer specific configuration.
    - `common` (Map Of String). General settings for all types of hosts.
    - `coordinator` [Block]. Coordinator specific configuration.
      - `config` (Map Of String). Coordinator settings.
      - `resources` [Block]. Resources allocated to routers of the Sharded PostgreSQL cluster.
        - `disk_size` (**Required**)(Number). Size of the disk in bytes.
        - `disk_type_id` (**Required**)(String). ID of the disk type that determines the disk performance characteristics.
        - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.
    - `infra` [Block]. 
      - `coordinator` (Map Of String). Coordinator settings.
      - `resources` [Block]. Resources allocated to routers of the Sharded PostgreSQL cluster.
        - `disk_size` (**Required**)(Number). Size of the disk in bytes.
        - `disk_type_id` (**Required**)(String). ID of the disk type that determines the disk performance characteristics.
        - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.
      - `router` (Map Of String). Router settings.
    - `router` [Block]. Router specific configuration.
      - `config` (Map Of String). Router settings.
      - `resources` [Block]. Resources allocated to routers of the Sharded PostgreSQL cluster.
        - `disk_size` (**Required**)(Number). Size of the disk in bytes.
        - `disk_type_id` (**Required**)(String). ID of the disk type that determines the disk performance characteristics.
        - `resource_preset_id` (**Required**)(String). ID of the resource preset that determines the number of CPU cores and memory size for the host.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). Description of the Sharded PostgreSQL cluster.
- `environment` (**Required**)(String). Deployment environment of the Sharded PostgreSQL cluster.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `hosts` [Block]. A host configuration of the Sharded PostgreSQL cluster.
  - `assign_public_ip` (Bool). Assign a public IP address to the host.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `subnet_id` (String). ID of the subnet where the host is located.
  - `type` (**Required**)(String). 
  - `zone` (**Required**)(String). The availability zone where the host is located.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_window` [Block]. Maintenance policy of the Sharded PostgreSQL cluster.
  - `day` (String). Day of the week (in DDD format). Allowed values: "MON", "TUE", "WED", "THU", "FRI", "SAT","SUN"
  - `hour` (Number). Hour of the day in UTC (in HH format). Allowed value is between 1 and 24.
  - `type` (String). Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window.
- `name` (**Required**)(String). Name of the Sharded PostgreSQL cluster. Provided by the client when the cluster is created.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_sharded_postgresql_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_sharded_postgresql_cluster.my_cluster ...
```
