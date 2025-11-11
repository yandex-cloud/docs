| Resource       | Price per hour,<br>without VAT                       | Price per month,<br>without VAT                            |
|----------------|-----------------------------------------------------:|-----------------------------------------------------------:|
| **Intel Broadwell** |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mongodb.v1.cpu.c50|string }}  | {{ sku|USD|mdb.cluster.mongodb.v1.cpu.c50|month|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mongodb.v1.cpu.c100|string }} | {{ sku|USD|mdb.cluster.mongodb.v1.cpu.c100|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mongodb.v1.ram|string }}      | {{ sku|USD|mdb.cluster.mongodb.v1.ram|month|string }}      |
| **Intel Cascade Lake** |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mongodb.v2.cpu.c50|string }}  | {{ sku|USD|mdb.cluster.mongodb.v2.cpu.c50|month|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|USD|mdb.cluster.mongodb.v2.cpu.c100|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|USD|mdb.cluster.mongodb.v2.ram|month|string }}      |
| **Intel Ice Lake** |
| 50% vCPU       | {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c50|string }}  | {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c50|month|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|string }} | {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mongodb.v3.ram|string }}      | {{ sku|USD|mdb.cluster.mongodb.v3.ram|month|string }}      |
| **AMD Zen 4**  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|string }} | {{ sku|USD|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mongodb.v4a.ram|string }}      | {{ sku|USD|mdb.cluster.mongodb.v4a.ram|month|string }}      |