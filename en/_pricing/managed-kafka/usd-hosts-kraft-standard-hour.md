| Resource      | Price for 1 hour,<br>without VAT           | 
|---------------|-------------------------------------------:|
| **Intel Cascade Lake**                                     |
| 50% vCPU      | {{ sku|USD|mdb.kafka.kraft.v2.cpu.c50|string }}     | 
| 100% vCPU     | {{ sku|USD|mdb.kafka.kraft.v2.cpu.c100|string }}   | 
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.v2.ram|string }}  | 
| **Intel Ice Lake**                                  |
| 50% vCPU      | {{ sku|USD|mdb.kafka.kraft.v3.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|USD|mdb.kafka.kraft.v3.cpu.c100|string }}  |
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.v3.ram|string }} |
| **Intel Ice Lake (Compute Optimized)**              |
| 100% vCPU | {{ sku|USD|mdb.kafka.kraft.highfreq-v3.cpu.c100|string }}      |
| RAM (for 1 GB) | {{ sku|USD|mdb.kafka.kraft.highfreq-v3.ram|string }} |
