| Resource       | Rate for 1 hour                                    |
|----------------|----------------------------------------------------|
{% if product != "cloud-il" %}
| **Intel Broadwell**                                                 |
| 5% vCPU        | {{ sku|ILS|mdb.zk.clickhouse.v1.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|ILS|mdb.zk.clickhouse.v1.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|ILS|mdb.zk.clickhouse.v1.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|ILS|mdb.zk.clickhouse.v1.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|ILS|mdb.zk.clickhouse.v1.ram|string }}      |
| **Intel Cascade Lake**                                              |
| 5% vCPU        | {{ sku|ILS|mdb.zk.clickhouse.v2.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|ILS|mdb.zk.clickhouse.v2.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|ILS|mdb.zk.clickhouse.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|ILS|mdb.zk.clickhouse.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|ILS|mdb.zk.clickhouse.v2.ram|string }}      |{% endif %}
| **Intel Ice Lake**                                                  |
| 50% vCPU       | {{ sku|ILS|mdb.zk.clickhouse.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|ILS|mdb.zk.clickhouse.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|ILS|mdb.zk.clickhouse.v3.ram|string }}      |
