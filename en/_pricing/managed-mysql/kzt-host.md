Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
----- | ----- | ----- | -----
**Intel Broadwell** |
5% vCPU | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c5|string }} | − | −
20% vCPU | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c20|string }} | − | −
50% vCPU | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c50|string }} | − | −
100% vCPU | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c100|string }} | − | −
RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mysql.v1.ram|string }} | − | −
**Intel Cascade Lake** |
5% vCPU | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c5|string }} | − | −
20% vCPU | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c20|string }} | − | −
50% vCPU | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c50|string }} | − | −
100% vCPU | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.mysql.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mysql.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mysql.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mysql.cpu.c100.v2|cud.y3|discount|percent|string }})
RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mysql.v2.ram|string }} | {{ sku|KZT|v1.commitment.y1.mdb.mysql.ram.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mysql.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mysql.ram.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mysql.ram.v2|cud.y3|discount|percent|string }})