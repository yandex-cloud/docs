| Resource       | Rate for 1 hour                                      | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| **Intel Broadwell** | |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }}   | ₽0.04 |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }}  | ₽0.46 |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  | ₽0.75 |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | ₽1.60 |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }}      | ₽0.90 |
| **Intel Cascade Lake** | |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }}   | ₽0.04 |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }}  | ₽0.46 |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  | ₽0.75 |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | ₽1.60 |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }}      | ₽0.90 |
| **Intel Ice Lake** | |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  | ₽0.75 |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | ₽1.60 |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }}      | ₽0.90 |

{% if audience == "cvos" %}

| Resource       | Rate for 1 hour                                      | With CVoS for 1 year | With CVoS for 3 years |
|----------------|------------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }}   | − | − |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }}  | − | − |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  | − | − |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | − | − |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }}   | − | − |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }}  | − | − |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  | − | − |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  | —              | —              |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | ₽0.7900 (-21%) | ₽0.5900 (-41%) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }}      | ₽0.4400 (-12%) | ₽0.3800 (-24%) |

{% endif %}

