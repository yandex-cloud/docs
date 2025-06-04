| Resource      | Price for 1 month,<br>without VAT              |
|---------------|-----------------------------------------------:|
| **Intel Cascade Lake**                                         |
| 50% vCPU      | {{ sku|USD|mdb.kafka.kraft.v2.cpu.c50|month|string }}    | 
| 100% vCPU     | {{ sku|USD|mdb.kafka.kraft.v2.cpu.c100|month|string }}  | 
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.v2.ram|month|string }} | 
| **Intel Ice Lake**                                      |
| 50% vCPU      | {{ sku|USD|mdb.kafka.kraft.v3.cpu.c50|month|string }}  |
| 100% vCPU     | {{ sku|USD|mdb.kafka.kraft.v3.cpu.c100|month|string }}  |
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.v3.ram|month|string }} |
| **Intel Ice Lake (Compute Optimized)**                  |
| 100% vCPU | {{ sku|USD|mdb.kafka.kraft.highfreq-v3.cpu.c100|month|string }}      |
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.highfreq-v3.ram|month|string }} |
