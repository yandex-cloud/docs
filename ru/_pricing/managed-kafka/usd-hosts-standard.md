### {{ KF }} broker host computing resources {#prices-kafka-brokers}

| Resource       | Cost for 1 hour                                    | Cost with CVoS for 1 year                                          | Cost with CVoS for 3 years                                         |
|----------------|----------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                        |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                  | −                                                                  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|USD|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|USD|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%)      | {{ sku|USD|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                                                                                                                                                            |
| 50% vCPU       | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c50|string }}  | —                                                                  | —                                                                  |
| 100% vCPU      | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }} | $0.008551 (-29%)                                                   | $0.006577 (-46%)                                                   |
| RAM (for 1 GB) | $0.003231                                          | $0.002077 (-36%)                                                   | $0.001615 (-50%)                                                   |
