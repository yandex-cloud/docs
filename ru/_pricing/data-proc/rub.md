{% list tabs %}

- Стандартные хосты

    | Вычислительные ресурсы | Цена за 1 час, вкл. НДС |
    |------------------------|-------------------------|
    | **Intel Broadwell**                              |
    | 20% vCPU               | 0,5642 ₽                |
    | 100% vCPU              | 0,7727 ₽                |
    | 1 GPU                  | 171,5490 ₽              |
    | RAM (за 1 ГБ)          | 0,2641 ₽                |
    | **Intel Cascade Lake**                           |
    | 20% vCPU               | 0,3210 ₽                |
    | 50% vCPU               | 0,4863 ₽                |
    | 100% vCPU              | 0,8226 ₽                |
    | RAM (за 1 ГБ)          | 0,2180 ₽                |
    | **Intel Ice Lake**                               |
    | 50% vCPU               | 0,4405 ₽                |
    | 100% vCPU              | 0,7470 ₽                |
    | RAM (за 1 ГБ)          | 0,1980 ₽                |

- Выделенные хосты

    Цены на вычислительные ресурсы выделенных хостов представлены в [документации {{ compute-full-name }}](../../compute/pricing.md#prices-dedicated-host).

    | Вычислительные ресурсы | Наценка {{ dataproc-name }} за 1 час, вкл. НДС |
    |------------------------|------------------------------------------------|
    | **Intel Cascade Lake**                                                  |
    | 100% vCPU              | {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }}  |
    | RAM (за 1 ГБ)          | {{ sku|RUB|mdb.dataproc.v2.ram|string }}       |
    | **Intel Ice Lake**                                                      |
    | 100% vCPU              | {{ sku|RUB|mdb.dataproc.v3.cpu.c100|string }}  |
    | RAM (за 1 ГБ)          | {{ sku|RUB|mdb.dataproc.v3.ram|string }}       |

{% endlist %}
