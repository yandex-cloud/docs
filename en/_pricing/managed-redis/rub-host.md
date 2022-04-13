| Resource                           | Rate for 1 hour                                    |
|------------------------------------|----------------------------------------------------|
| **Intel Broadwell** |
| 5% vCPU (**burstable**, 2 GB RAM)  | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c5|string }}   |
| 20% vCPU (**burstable**, 4 GB RAM) | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c20|string }}  |
| 100% vCPU (**high-memory**)        | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v1.ram|string }}      |
| **Intel Cascade Lake** |
| 5% vCPU                            | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c5|string }}   |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c50|string }}  |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v2.ram|string }}      |
| **Intel Ice Lake** |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c50|string }}  |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v3.ram|string }}      |

{% if audience == "cvos" %}

| Resource                           | Rate for 1 hour                                    | With CVoS for 1 year | With CVoS for 3 years |
|------------------------------------|----------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU (**burstable**, 2 GB RAM)  | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c5|string }}   | — | — |
| 20% vCPU (**burstable**, 4 GB RAM) | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c20|string }}  | — | — |
| 100% vCPU (**high-memory**)        | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c100|string }} | — | — |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v1.ram|string }}      | — | — |
| **Intel Cascade Lake** |
| 5% vCPU                            | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c5|string }}   | — | — |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c50|string }}  | — | — |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.redis.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.redis.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.redis.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.redis.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.redis.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.redis.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.redis.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.redis.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c50|string }}  | —              | — |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|string }} | ₽0.6660 (-30%) | ₽0.5130 (-46%) |
| RAM (for 1 GB)                     | {{ sku|RUB|mdb.cluster.redis.v3.ram|string }}      | ₽0.1620 (-36%) | ₽0.1260 (-50%) |

{% endif %}
