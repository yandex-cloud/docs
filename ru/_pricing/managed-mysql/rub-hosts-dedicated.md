| Ресурс        | Наценка {{ mmy-name }} за 1 час,<br>вкл. НДС                 |
| ------------- | -----------------------------------------------------------: |
| **Intel Cascade Lake**                                                       |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.v2.ram.dedicated|string }}      |
| **Intel Ice Lake**                                                           |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.v3.ram.dedicated|string }}      |
| **Intel Ice Lake (Compute Optimized)** |
| 100% vCPU | 0,80 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.highfreq-v3.ram.dedicated|string }} |
