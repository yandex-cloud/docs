| Resource       | Cost for 1 hour                                    | |
|----------------|----------------------------------------------------|---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
| **Intel Cascade Lake** | |
| 50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }} | ₸3.75 |
| 100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} | ₸8.40 |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }} | ₸2.25 |
| **Intel Ice Lake** | |
| 50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c50|string }} | ₸3.40 |
| 100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} | ₸7.55 |
| RAM (for 1 GB) | ₸1.5120 | ₸2.00 |


{% if audience == "cvos" %}

| Resource | Cost for 1 hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
| --------------- | ---------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------- |
| **Intel Cascade Lake** |
| 50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }} | − | − |
| 100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%) |
| **Intel Ice Lake** |
| 50% vCPU | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c50|string }} | — | — |
| 100% vCPU | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} | ₸4.0020 (-29%) | ₸3.0780 (-46%) |
| RAM (for 1 GB) | ₸1.5120 | ₸0.9720 (-36%) | ₸0.7560 (-50%) |

{% endif %}

