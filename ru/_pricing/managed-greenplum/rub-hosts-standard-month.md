
| Ресурс        | Цена за 1 месяц,<br>вкл. НДС                                 | Цена с CVoS на 6 месяцев,<br>вкл. НДС                                               | Цена с CVoS на 1 год,<br>вкл. НДС                                                               |
|---------------|-------------------------------------------------------------:|------------------------------------------------------------------------------------:|------------------------------------------------------------------------------------------------:|
| **Intel Cascade Lake**                                                                                                                                                                                                                                               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100|month|string }} | —                                                                                   | —                                                                                               |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.greenplum.v2.ram|month|string }}      | —                                                                                   | —                                                                                               |
| **Intel Ice Lake**                                                                                                                                                                                                                                                   |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.greenplum.cpu.c100.v3|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.greenplum.cpu.c100.v3|month|string }} (-22%) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.greenplum.v3.ram|month|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.greenplum.ram.v3|month|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.greenplum.ram.v3|month|string }} (-22%)      |
| **Intel Ice Lake (Compute Optimized)** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.greenplum.highfreq-v3.cpu.c100|month|string }} | — | — |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.greenplum.highfreq-v3.ram|month|string }} | — | — |


