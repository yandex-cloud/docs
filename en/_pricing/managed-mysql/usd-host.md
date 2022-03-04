| Resource       | Rate for 1 hour                                    |
|----------------|----------------------------------------------------|
| **Intel Broadwell** |
| 5% vCPU        | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v1.ram|string }}      |
| **Intel Cascade Lake** |
| 5% vCPU        | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c5|string }}   |
| 20% vCPU       | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c20|string }}  |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v2.ram|string }}      |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v3.ram|string }}      |


