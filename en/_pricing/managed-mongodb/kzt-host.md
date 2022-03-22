| Resource       | Rate for 1 hour                                      | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| **Intel Broadwell** | |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c5|string }}   | ₸0.20 |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c20|string }}  | ₸2.30 |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c50|string }}  | ₸3.75 |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c100|string }} | ₸8.00 |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v1.ram|string }}      | ₸4.50 |
| **Intel Cascade Lake** | |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c5|string }}   | ₸0.20 |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c20|string }}  | ₸2.30 |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c50|string }}  | ₸3.75 |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c100|string }} | ₸8.00 |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v2.ram|string }}      | ₸4.50 |
| **Intel Ice Lake** | |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c50|string }}  | ₸3.75 |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c100|string }} | ₸8.00 |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v3.ram|string }}      | ₸4.50 |

{% if audience == "cvos" %}

| Resource       | Rate for 1 hour                                      | With CVoS for 1 year | With CVoS for 3 years |
|----------------|------------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c5|string }}   | − | − |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c20|string }}  | − | − |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c50|string }}  | − | − |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c100|string }} | − | − |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU        | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c5|string }}   | − | − |
| 20% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c20|string }}  | − | − |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c50|string }}  | − | − |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.mongodb.ram.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mongodb.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mongodb.ram.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mongodb.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c50|string }}  | —              | —              |
| 100% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c100|string }} | ₸4.7400 (-21%) | ₸3.5400 (-41%) |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mongodb.v3.ram|string }}      | ₸2.6400 (-12%) | ₸2.2800 (-24%) |

{% endif %}

