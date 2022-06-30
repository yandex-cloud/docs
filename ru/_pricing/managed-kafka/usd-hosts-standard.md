### {{ KF }} broker host computing resources {#prices-kafka-brokers}

| Resource       | Cost for 1 hour                                    |
|----------------|----------------------------------------------------|
| **Intel Cascade Lake**                                              |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v2.ram|string }}      |
| **Intel Ice Lake**                                                  |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c50|string }}  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }} |
| RAM (for 1 GB) | $0.003231                                          |

{% if audience == "cvos" %}

| Resource       | Cost for 1 hour                                    | Cost with CVoS for 1 year                                          | Cost with CVoS for 3 years                                         |
|----------------|----------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                        |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                  | −                                                                  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|USD|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|USD|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%)      | {{ sku|USD|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                                                                                                                                                            |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c50|string }}  | —                                                                  | —                                                                  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.kafka.cpu.c100.v3|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.kafka.cpu.c100.v3|string }} (-46%) |
| RAM (for 1 GB) | $0.003231                                          | {{ sku|USD|v1.commitment.y1.mdb.kafka.ram.v3|string }} (-36%)      | {{ sku|USD|v1.commitment.y3.mdb.kafka.ram.v3|string }} (-50%)      |

{% endif %}