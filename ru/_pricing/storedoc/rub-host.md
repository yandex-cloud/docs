| Ресурс        | Цена за 1 час,<br>вкл. НДС                           | Цена за 1 месяц,<br>вкл. НДС                               |
| ------------- | ---------------------------------------------------: | ---------------------------------------------------------: |
| **Intel Broadwell** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }}      | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|month|string }}      |
| **Intel Cascade Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|month|string }}      |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }}      | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|month|string }}      |
| **Intel Ice Lake (Compute Optimized)** |
| 100% vCPU     | {% calc [currency=RUB] 2,9083 %} | {% calc [currency=RUB] 2 093,9760 %} |
| RAM (за 1 ГБ) | {% calc [currency=RUB] 0,9885 %} | {% calc [currency=RUB] 711,72 %} |
| **AMD Zen 4** |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v4a.ram|string }}      | {{ sku|RUB|mdb.cluster.mongodb.v4a.ram|month|string }}      |
| **AMD Zen 4 HighFreq** |
| 100% vCPU     | {% calc [currency=RUB] 3,5037 %} | {% calc [currency=RUB] 2 522,6640 %} |
| RAM (за 1 ГБ) | {% calc [currency=RUB] 1,2012 %} | {% calc [currency=RUB] 864,8640 %} |
