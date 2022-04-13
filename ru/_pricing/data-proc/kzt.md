{% list tabs %}

- Стандартные хосты

    | Вычислительные ресурсы | Цена за 1 час, вкл. НДС |
    |------------------------|-------------------------|
    | **Intel Broadwell**                              |
    | 20% vCPU               | 4,50 ₸                  |
    | 100% vCPU              | 6,15 ₸                  |
    | 1 GPU                  | 1 372,35 ₸              |
    | RAM (за 1 ГБ)          | 2,10 ₸                  |
    | **Intel Cascade Lake**                           |
    | 20% vCPU               | 2,55 ₸                  |
    | 50% vCPU               | 3,90 ₸                  |
    | 100% vCPU              | 6,55 ₸                  |
    | RAM (за 1 ГБ)          | 1,70 ₸                  |
    | **Intel Ice Lake**                               |
    | 50% vCPU               | 3,50 ₸                  |
    | 100% vCPU              | 5,85 ₸                  |
    | RAM (за 1 ГБ)          | 1,55 ₸                  |

- Выделенные хосты

    Цены на вычислительные ресурсы выделенных хостов представлены в [документации {{ compute-full-name }}](../../compute/pricing.md#prices-dedicated-host).

    | Вычислительные ресурсы | Наценка {{ dataproc-name }} за 1 час, вкл. НДС |
    |------------------------|------------------------------------------------|
    | **Intel Cascade Lake**                                                  |
    | 100% vCPU              | {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }}  |
    | RAM (за 1 ГБ)          | {{ sku|KZT|mdb.dataproc.v2.ram|string }}       |
    | **Intel Ice Lake**                                                      |
    | 100% vCPU              | {{ sku|KZT|mdb.dataproc.v3.cpu.c100|string }}  |
    | RAM (за 1 ГБ)          | {{ sku|KZT|mdb.dataproc.v3.ram|string }}       |

{% endlist %}
