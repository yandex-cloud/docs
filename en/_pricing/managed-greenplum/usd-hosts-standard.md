| Resource | Cost per hour |
|------------------|---------------|
| **Intel Cascade Lake** |
| 100% vCPU | $0.019179 |
| RAM (for 1 GB) | $0.005077 |
| **Intel Ice Lake** |
| 100% vCPU | $0.017231 |
| RAM (for 1 GB) | $0.004564 |

{% if audience == "cvos" %}

| Resource | Cost per hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
|------------------|---------------|------------------------------------------------------------------------|-----------------------|
| **Intel Cascade Lake** |
| 100% vCPU | $0.019179 | {{ sku|USD|v1.commitment.y1.mdb.greenplum.cpu.c100.v2|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.cpu.c100.v2|string }} (-45%) |
| RAM (for 1 GB) | $0.005077 | {{ sku|USD|v1.commitment.y1.mdb.greenplum.ram.v2|string }} (-35%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.ram.v2|string }} (-50%) |
| **Intel Ice Lake** |
| 100% vCPU | $0.017231 | {{ sku|USD|v1.commitment.y1.mdb.greenplum.cpu.c100.v3|string }} (-29%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.cpu.c100.v3|string }} (-45%) |
| RAM (for 1 GB) | $0.004564 | {{ sku|USD|v1.commitment.y1.mdb.greenplum.ram.v3|string }} (-35%) | {{ sku|USD|v1.commitment.y3.mdb.greenplum.ram.v3|string }} (-50%) |

{% endif %}