{% if audience != "draft" %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | $0.007051 |
| RAM (for 1 GB) | $0.002051 |
| **Intel Ice Lake** |
| 100% vCPU | $0.006410 |
| RAM (for 1 GB) | $0.001923 |

{% else %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v2.ram.dedicated|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|USD|mdb.cluster.mysql.v3.ram.dedicated|string }} |

{% endif %}
