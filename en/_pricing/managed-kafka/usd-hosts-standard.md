{% list tabs %}

- Costs per hour

   | Resource | Cost per hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   |----------------|---------------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c50|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v2|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v2|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v2.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v2|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v2|string }} (-22%) |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c50|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v3|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v3.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v3|string }} (-22%) |

- Costs per month

   | Resource | Cost for 1 month | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
   |----------------|---------------------------------------------------------:|--------------------------------------------------------------------------------------:|--------------------------------------------------------------------------------------:|
   | **Intel Cascade Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c50|month|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.kafka.v2.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v2|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v2|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v2.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v2|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v2|month|string }} (-22%) |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c50|month|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v3|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.kafka.v3.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v3|month|string }} (-22%) |

{% endlist %}
