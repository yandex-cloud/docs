| Resource                           | Rate for 1 hour                                    | |
| ----- | ----- | ----- |
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| **Intel Broadwell** | |
| 5% vCPU (**burstable**, 2 GB RAM)  | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c5|string }}   | ₸0.05 |
| 20% vCPU (**burstable**, 4 GB RAM) | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c20|string }}  | ₸1.80 |
| 100% vCPU (**high-memory**)        | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c100|string }} | ₸10.00 |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v1.ram|string }}      | ₸2.70 |
| **Intel Cascade Lake** | |
| 5% vCPU                            | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c5|string }}   | ₸0.55 |
| 50% vCPU                           | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c50|string }}  | ₸5.05 |
| 100% vCPU                          | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c100|string }} | ₸8.40 |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v2.ram|string }}      | ₸2.25 |
| **Intel Ice Lake** | |
| 50% vCPU                           | {{ sku|KZT|mdb.cluster.redis.v3.cpu.c50|string }}  | ₸4.55 |
| 100% vCPU                          | {{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|string }} | ₸7.55 |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v3.ram|string }}      | ₸2.00 |

{% if audience == "cvos" %}

| Resource                           | Rate for 1 hour                                    | With CVoS for 1 year | With CVoS for 3 years |
|------------------------------------|----------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU (**burstable**, 2 GB RAM)  | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c5|string }}   | — | — |
| 20% vCPU (**burstable**, 4 GB RAM) | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c20|string }}  | — | — |
| 100% vCPU (**high-memory**)        | {{ sku|KZT|mdb.cluster.redis.v1.cpu.c100|string }} | — | — |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v1.ram|string }}      | — | — |
| **Intel Cascade Lake** |
| 5% vCPU                            | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c5|string }}   | — | — |
| 50% vCPU                           | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c50|string }}  | — | — |
| 100% vCPU                          | {{ sku|KZT|mdb.cluster.redis.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.redis.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.redis.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.redis.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.redis.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.redis.ram.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.redis.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.redis.ram.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.redis.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU                           | {{ sku|KZT|mdb.cluster.redis.v3.cpu.c50|string }}  | —              | — |
| 100% vCPU                          | {{ sku|KZT|mdb.cluster.redis.v3.cpu.c100|string }} | ₸3.9960 (-30%) | — |
| RAM (for 1 GB)                     | {{ sku|KZT|mdb.cluster.redis.v3.ram|string }}      | ₸0.9720 (-36%) | — |

{% endif %}
