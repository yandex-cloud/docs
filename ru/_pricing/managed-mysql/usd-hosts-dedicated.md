{% if audience != "draft" %}

| Ресурс        | Наценка {{ mmy-name }} за 1 час |
| ------------- | ------------------------------- |
| **Intel Cascade Lake**                          |
| 100% vCPU     | 0,007051 $                      |
| RAM (за 1 ГБ) | 0,002051 $                      |
| **Intel Ice Lake**                              |
| 100% vCPU     | 0,006410 $                      |
| RAM (за 1 ГБ) | 0,001923 $                      |

{% else %}

| Ресурс        | Наценка {{ mmy-name }} за 1 час                              |
| ------------- | ------------------------------------------------------------ |
| **Intel Cascade Lake**                                                       |
| 100% vCPU     | {{ sku|USD|mdb.cluster.mysql.v2.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|USD|mdb.cluster.mysql.v2.ram.dedicated|string }}      |
| **Intel Ice Lake**                                                           |
| 100% vCPU     | {{ sku|USD|mdb.cluster.mysql.v3.cpu.c100.dedicated|string }} |
| RAM (за 1 ГБ) | {{ sku|USD|mdb.cluster.mysql.v3.ram.dedicated|string }}      |

{% endif %}
