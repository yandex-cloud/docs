| Resource | Cost per hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.greenplum.v2.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.greenplum.v2.ram|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.greenplum.v3.cpu.c100|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.greenplum.v3.ram|string }} |

{% if audience == "cvos" %}

| Resource | Cost per hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
|------------------|---------------|------------------------------------------------------------------------|-----------------------|
| **Intel Cascade Lake** |
| 100% vCPU | ₸8.9760 | {{ sku|KZT|v1.commitment.y1.mdb.greenplum.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.greenplum.cpu.c100.v2|string }} (-45%) |
| RAM (for 1 GB) | ₸2.3760 | {{ sku|KZT|v1.commitment.y1.mdb.greenplum.ram.v2|string }} (-35%) | {{ sku|KZT|v1.commitment.y3.mdb.greenplum.ram.v2|string }} (-50%) |
| **Intel Ice Lake** |
| 100% vCPU | ₸8.0640 | {{ sku|KZT|v1.commitment.y1.mdb.greenplum.cpu.c100.v3|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.greenplum.cpu.c100.v3|string }} (-45%) |
| RAM (for 1 GB) | ₸2.1360 | {{ sku|KZT|v1.commitment.y1.mdb.greenplum.ram.v3|string }} (-35%) | {{ sku|KZT|v1.commitment.y3.mdb.greenplum.ram.v3|string }} (-50%) |

{% endif %}