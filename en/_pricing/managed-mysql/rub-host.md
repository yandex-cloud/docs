| Resource       | Rate for 1 hour                                    |
|----------------|----------------------------------------------------|
| **Intel Broadwell** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v1.ram|string }}      |
| **Intel Cascade Lake** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v2.ram|string }}      |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v3.ram|string }}      |

{% if audience == "cvos" %}

| Resource       | Rate for 1 hour                                    | With CVoS for 1 year                                                                                                                              | With CVoS for 3 years |
|----------------|----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c5|string }}   | −                                                                                                                                                 | − |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c20|string }}  | −                                                                                                                                                 | − |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c50|string }}  | −                                                                                                                                                 | − |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c100|string }} | −                                                                                                                                                 | − |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v1.ram|string }}      | −                                                                                                                                                 | − |
| **Intel Cascade Lake** |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c5|string }}   | −                                                                                                                                                 | − |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c20|string }}  | −                                                                                                                                                 | − |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c50|string }}  | −                                                                                                                                                 | − |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mysql.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mysql.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mysql.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mysql.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.mysql.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mysql.ram.v2|cud.y1|discount|percent|string }})           | {{ sku|RUB|v1.commitment.y3.mdb.mysql.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mysql.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c50|string }}  | —                                                                                                                                                 | —              |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mysql.cpu.c100.v3|string }} (-31%)                                                                                | {{ sku|RUB|v1.commitment.y3.mdb.mysql.cpu.c100.v3|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v3.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.mysql.ram.v3|string }} (-34%)                                                                                     | {{ sku|RUB|v1.commitment.y3.mdb.mysql.ram.v3|string }} (-50%) |

{% endif %}

