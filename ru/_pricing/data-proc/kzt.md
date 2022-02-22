{% list tabs %}

- Стандартные хосты

    | Вычислительные ресурсы | Цена за 1 час, вкл. НДС |
    |------------------------|-------------------------|
    | **Intel Broadwell**                              |
    | 20% vCPU               | 3,3852 ₸                |
    | 100% vCPU              | 4,6362 ₸                |
    | 1 GPU                  | 1029,2940 ₸             |
    | RAM (за 1 ГБ)          | 1,5846 ₸                |
    | **Intel Cascade Lake**                           |
    | 20% vCPU               | 1,9260 ₸                |
    | 50% vCPU               | 2,9178 ₸                |
    | 100% vCPU              | 4,9356 ₸                |
    | RAM (за 1 ГБ)          | 1,3080 ₸                |
    | **Intel Ice Lake**                               |
    | 50% vCPU               | 2,6430 ₸                |
    | 100% vCPU              | 4,4820 ₸                |
    | RAM (за 1 ГБ)          | 1,1880 ₸                |

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

{% endlist  %}
