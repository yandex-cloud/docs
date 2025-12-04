| Ресурс        | Цена за 1 час,<br>вкл. НДС                           | Цена за 1 месяц,<br>вкл. НДС                               |
| ------------- | ---------------------------------------------------: | ---------------------------------------------------------: |
| **Intel Broadwell** |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c50|string }}  | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c100|string }} | {{ sku|KZT|mdb.cluster.mongodb.v1.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mongodb.v1.ram|string }}      | {{ sku|KZT|mdb.cluster.mongodb.v1.ram|month|string }}      |
| **Intel Cascade Lake** |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c50|string }}  | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|KZT|mdb.cluster.mongodb.v2.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|KZT|mdb.cluster.mongodb.v2.ram|month|string }}      |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c50|string }}  | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c100|string }} | {{ sku|KZT|mdb.cluster.mongodb.v3.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mongodb.v3.ram|string }}      | {{ sku|KZT|mdb.cluster.mongodb.v3.ram|month|string }}      |
| **Intel Ice Lake (Compute Optimized)** |
| 100% vCPU     | {% calc [currency=KZT] 2,9083 × 5 %} | {% calc [currency=KZT] 2 093,9760 × 5 %} |
| RAM (за 1 ГБ) | {% calc [currency=KZT] 0,9885 × 5 %} | {% calc [currency=KZT] 711,72 × 5 %} |
| **AMD Zen 4** |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|string }} | {{ sku|KZT|mdb.cluster.mongodb.mongocfg.v4a.cpu.c100|month|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mongodb.v4a.ram|string }}      | {{ sku|KZT|mdb.cluster.mongodb.v4a.ram|month|string }}      |
| **AMD Zen 4 HighFreq** |
| 100% vCPU     | {% calc [currency=KZT] 3,5037 × 5 %} | {% calc [currency=KZT] 2 522,6640 × 5 %} |
| RAM (за 1 ГБ) | {% calc [currency=KZT] 1,2012 × 5 %} | {% calc [currency=KZT] 864,8640 × 5 %} |