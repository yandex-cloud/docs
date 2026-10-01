| v1 (блочный синтаксис)                                   | v2 (синтаксис присваивания)               |
| --- | --- |
| `clickhouse { }`                                         | `clickhouse = { }`                        |
| `zookeeper { }`                                          | `zookeeper = { }`                         |
| `access { }`                                             | `access = { }`                            |
| `cloud_storage { }`                                      | `cloud_storage = { }`                     |
| `backup_window_start { }`                                | `backup_window_start = { }`               |
| `clickhouse.config.kafka { }`                            | `kafka = { }` (внутри `config`)           |
| `clickhouse.config.rabbitmq { }`                         | `rabbitmq = { }` (внутри `config`)        |
| `clickhouse.config.compression { }` (повторяющийся блок) | `compression = [{ method = "LZ4", ... }]` |
| `host { }` (повторяющийся блок)                          | `hosts = { "key" = { } }`                 |
| `shard { }` (повторяющийся блок)                         | `shards = { "shard1" = { } }`             |