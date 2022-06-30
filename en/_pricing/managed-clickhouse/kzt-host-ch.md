| Resource       | Rate for 1 hour                                         |
|----------------|---------------------------------------------------------|
| **Intel Broadwell**                                                      |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v1.ram|string }}      |
| **Intel Cascade Lake**                                                   |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v2.ram|string }}      |
| **Intel Ice Lake**                                                       |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }}      |

{% if audience == "cvos" %}

| Resource       | Rate for 1 hour                                         | With CVoS for 1 year                                            | With CVoS for 3 years                                           |
|----------------|---------------------------------------------------------|-----------------------------------------------------------------|-----------------------------------------------------------------|
| **Intel Broadwell**                                                                                                                                                                                          |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c100|string }} | −                                                               | −                                                               |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v1.ram|string }}      | −                                                               | −                                                               |
| **Intel Cascade Lake**                                                                                                                                                                                       |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.ch.cpu.c100.v2|string }} (-27%) | {{ sku|KZT|v1.commitment.y3.mdb.ch.cpu.c100.v2|string }} (-43%) |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.ch.ram.v2|string }} (-36%)      | {{ sku|KZT|v1.commitment.y3.mdb.ch.ram.v2|string }} (-52%)      |
| **Intel Ice Lake**                                                                                                                                                                                           |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c50|string }}  | —                                                               | —                                                               |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.ch.cpu.c100.v3|string }} (-27%) | {{ sku|KZT|v1.commitment.y3.mdb.ch.cpu.c100.v3|string }} (-43%) |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.ch.ram.v3|string }} (-36%)      | {{ sku|KZT|v1.commitment.y3.mdb.ch.ram.v3|string }} (-52%)      |

{% endif %}
