| v1 (section syntax)                                   | v2 (assignment syntax)               |
| --- | --- |
| `clickhouse { }`                                         | `clickhouse = { }`                        |
| `zookeeper { }`                                          | `zookeeper = { }`                         |
| `access { }`                                             | `access = { }`                            |
| `cloud_storage { }`                                      | `cloud_storage = { }`                     |
| `backup_window_start { }`                                | `backup_window_start = { }`               |
| `clickhouse.config.kafka { }`                            | `kafka = { }` (inside `config`)           |
| `clickhouse.config.rabbitmq { }`                         | `rabbitmq = { }` (inside `config`)        |
| `clickhouse.config.compression { }` (repeat section) | `compression = [{ method = "LZ4", ... }]` |
| `host { }` (repeat section)                          | `hosts = { "key" = { } }`                 |
| `shard { }` (repeat section)                         | `shards = { "shard1" = { } }`             |