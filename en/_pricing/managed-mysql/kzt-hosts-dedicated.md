{% if audience != "draft" %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | ₸2.7500 |
| RAM (for 1 GB) | ₸0.8000 |
| **Intel Ice Lake** |
| 100% vCPU | ₸2.5000 |
| RAM (for 1 GB) | ₸0.7500 |

{% else %}

| Resource | {{ mmy-name }} markup for 1 hour |
| ----- | ----- |
| **Intel Cascade Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mysql.v2.ram.dedicated|string }} |
| **Intel Ice Lake** |
| 100% vCPU | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (for 1 GB) | {{ sku|KZT|mdb.cluster.mysql.v3.ram.dedicated|string }} |

{% endif %}
