| Resource | Cost per hour |
| ----- | ----- |
| **Intel Broadwell** |
| 5% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }} |
| 20% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }} |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }} |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} |
| **Intel Cascade Lake** |
| 5% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }} |
| 20% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }} |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }} |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} |
| **Intel Ice Lake** |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }} |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} |

The cost of RAM depends on the [MongoDB edition](../../managed-mongodb/concepts/editions.md).

* For Community Edition:

   | Resource | Cost per hour |
   | ----- | ----- |
   | **Intel Broadwell** |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }} |
   | **Intel Cascade Lake** |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }} |
   | **Intel Ice Lake** |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }} |

* For Enterprise Edition, RAM is allocated and paid for in quants of 100 GB. For example, the cost of 16 GB RAM is equal to 100 GB and the cost of 128 GB RAM is equal to 200 GB. Funds are debited once for an entire calendar month when a cluster is launched, regardless of the actual amount of time the cluster runs for and the launch date. The cost of RAM for Enterprise Edition clusters is ₽230000 per 100 GB for a calendar month.

{% if audience == "cvos" %}

| Resource | Cost per hour | Cost with CVoS for 1 year | Cost with CVoS for 3 years |
|---------------|------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }} | − | − |
| 20% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }} | − | − |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }} | − | − |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | − | − |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }} | − | − |
| **Intel Cascade Lake** |
| 5% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }} | − | − |
| 20% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }} | − | − |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }} | − | − |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }} | — | — |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v3|string }} (-21%) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v3|string }} (-41%) |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }} | ₽0.4400 (-12 %) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v3|string }} (-24%) |

{% endif %}
