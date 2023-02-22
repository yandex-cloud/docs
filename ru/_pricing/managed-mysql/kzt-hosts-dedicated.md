{% if audience != "draft" %}

| Ресурс        | Наценка {{ mmy-name }} за 1 час |
| ------------- | ------------------------------- |
| **Intel Cascade Lake**                          |
| 100% vCPU     | 2,7500 ₸                        |
| RAM (за 1 ГБ) | 0,8000 ₸                        |
| **Intel Ice Lake**                              |
| 100% vCPU     | 2,5000 ₸                        |
| RAM (за 1 ГБ) | 0,7500 ₸                        |

{% else %}

| Ресурс        | Наценка {{ mmy-name }} за 1 час                              |
| ------------- | ------------------------------------------------------------ |
| **Intel Cascade Lake**                                                       |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v2.ram.dedicated|string }}      |
| **Intel Ice Lake**                                                           |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v3.ram.dedicated|string }}      |

{% endif %}
