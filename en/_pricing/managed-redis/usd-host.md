| Resource                           | Rate for 1 hour                                    |
|------------------------------------|----------------------------------------------------|
| **Intel Broadwell** |
| 5% vCPU (**burstable**, 2 GB RAM)  | {{ sku|USD|mdb.cluster.redis.v1.cpu.c5|string }}   |
| 20% vCPU (**burstable**, 4 GB RAM) | {{ sku|USD|mdb.cluster.redis.v1.cpu.c20|string }}  |
| 100% vCPU (**high-memory**)        | {{ sku|USD|mdb.cluster.redis.v1.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|USD|mdb.cluster.redis.v1.ram|string }}      |
| **Intel Cascade Lake** |
| 5% vCPU                            | {{ sku|USD|mdb.cluster.redis.v2.cpu.c5|string }}   |
| 50% vCPU                           | {{ sku|USD|mdb.cluster.redis.v2.cpu.c50|string }}  |
| 100% vCPU                          | {{ sku|USD|mdb.cluster.redis.v2.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|USD|mdb.cluster.redis.v2.ram|string }}      |
| **Intel Ice Lake** |
| 50% vCPU                           | {{ sku|USD|mdb.cluster.redis.v3.cpu.c50|string }}  |
| 100% vCPU                          | {{ sku|USD|mdb.cluster.redis.v3.cpu.c100|string }} |
| RAM (for 1 GB)                     | {{ sku|USD|mdb.cluster.redis.v3.ram|string }}      |

