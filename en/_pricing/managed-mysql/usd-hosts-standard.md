{% list tabs %}

- Prices per hour

   | Resource | Price per hour | With CVoS for 6 months | With CVoS for 1 year |
   |----------------|---------------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------:|
   | **Intel Broadwell** |
   | 5% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c5|string }} | − | − |
   | 20% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c20|string }} | − | − |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c50|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c100|string }} | − | − |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v1.ram|string }} | − | − |
   | **Intel Cascade Lake** |
   | 5% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c5|string }} | − | − |
   | 20% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c20|string }} | − | − |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c50|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.cpu.c100.v2|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.cpu.c100.v2|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v2.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.ram.v2|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.ram.v2|string }} (-22%) |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c50|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.cpu.c100.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.cpu.c100.v3|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v3.ram|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.ram.v3|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.ram.v3|string }} (-22%) |
   | **Intel Ice Lake (Compute Optimized)** |
   | 100% vCPU | $0.021520 | − | − |
   | RAM (for 1 GB) | $0.004240 | − | − |

- Prices per month

   | Resource | Price per month | With CVoS for 6 months | With CVoS for 1 year |
   |----------------|---------------------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------------------:|
   | **Intel Broadwell** |
   | 5% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c5|month|string }} | − | − |
   | 20% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c20|month|string }} | − | − |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c50|month|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v1.cpu.c100|month|string }} | − | − |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v1.ram|month|string }} | − | − |
   | **Intel Cascade Lake** |
   | 5% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c5|month|string }} | − | − |
   | 20% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c20|month|string }} | − | − |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c50|month|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.cpu.c100.v2|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.cpu.c100.v2|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v2.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.ram.v2|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.ram.v2|month|string }} (-22%) |
   | **Intel Ice Lake** |
   | 50% vCPU | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c50|month|string }} | − | − |
   | 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.cpu.c100.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.cpu.c100.v3|month|string }} (-22%) |
   | RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v3.ram|month|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.mdb.mysql.ram.v3|month|string }} (-15%) | {{ sku|USD|v1.commitment.selfcheckout.y1.mdb.mysql.ram.v3|month|string }} (-22%) |
   | **Intel Ice Lake (Compute Optimized)** |
   | 100% vCPU | $15.494400 | − | − |
   | RAM (for 1 GB) | $3.052800 | − | − |

{% endlist %}
