
| Ресурс                             | Цена за 1 час,<br>вкл. НДС                         | Цена с CVoS на 6 месяцев,<br>вкл. НДС                                           | Цена с CVoS на 1 год,<br>вкл. НДС                                               |
|------------------------------------|---------------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------:|
| **Intel Broadwell**                                                                                                                                                                                                                                         |
| 5% vCPU (**burstable**, 2 ГБ RAM)  | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c5|string }}   | −                                                                               | −                                                                               |
| 20% vCPU (**burstable**, 4 ГБ RAM) | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c20|string }}  | −                                                                               | −                                                                               |
| 100% vCPU (**high-memory**)        | {{ sku|RUB|mdb.cluster.redis.v1.cpu.c100|string }} | −                                                                               | −                                                                               |
| RAM (за 1 ГБ)                      | {{ sku|RUB|mdb.cluster.redis.v1.ram|string }}      | −                                                                               | −                                                                               |
| **Intel Cascade Lake**                                                                                                                                                                                                                                      |
| 5% vCPU                            | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c5|string }}   | −                                                                               | −                                                                               |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c50|string }}  | −                                                                               | −                                                                               |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.redis.cpu.c100.v2|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.redis.cpu.c100.v2|string }} (-22%) |
| RAM (за 1 ГБ)                      | {{ sku|RUB|mdb.cluster.redis.v2.ram|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.redis.ram.v2|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.redis.ram.v2|string }} (-22%)      |
| **Intel Ice Lake**                                                                                                                                                                                                                                          |
| 50% vCPU                           | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c50|string }}  | −                                                                               | −                                                                               |
| 100% vCPU                          | {{ sku|RUB|mdb.cluster.redis.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.redis.cpu.c100.v3|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.redis.cpu.c100.v3|string }} (-22%) |
| RAM (за 1 ГБ)                      | {{ sku|RUB|mdb.cluster.redis.v3.ram|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.redis.ram.v3|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.redis.ram.v3|string }} (-22%)      |
| **Intel Ice Lake (Compute Optimized)** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.redis.highfreq-v3.cpu.c100|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.redis.highfreq-v3.ram|string }} | − | − |


