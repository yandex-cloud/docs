| Resource       | {{ mmy-name }} markup for 1 hour                              |
| -------------- | ------------------------------------------------------------- |
| **Intel Cascade Lake**                                                         |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v2.ram.dedicated|string }}      |
| **Intel Ice Lake**                                                             |
| 100% vCPU      | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v3.ram.dedicated|string }}      |
