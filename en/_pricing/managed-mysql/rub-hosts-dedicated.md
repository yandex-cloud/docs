{% if audience != "draft" %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | ₽0.5500 |
| RAM (for 1 GB) | ₽0.1600 |
| **Intel Ice Lake** |
| 100% vCPU | ₽0.5000 |
| RAM (for 1 GB) | ₽0.1500 |

{% else %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v2.ram.dedicated|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.mysql.v3.ram.dedicated|string }} |

{% endif %}
