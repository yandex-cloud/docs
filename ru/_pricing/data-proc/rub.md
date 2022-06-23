{% list tabs %}

- Стандартные хосты

    | Вычислительные ресурсы | Цена за 1 час, вкл. НДС |
    |------------------------|-------------------------|
    | **Intel Broadwell**                              |
    | 20% vCPU               | 0,90 ₽                  |
    | 100% vCPU              | 1,23 ₽                  |
    | 1 GPU                  | 274,47 ₽                |
    | RAM (за 1 ГБ)          | 0,42 ₽                  |
    | **Intel Cascade Lake**                           |
    | 20% vCPU               | 0,51 ₽                  |
    | 50% vCPU               | 0,78 ₽                  |
    | 100% vCPU              | 1,31 ₽                  |
    | RAM (за 1 ГБ)          | 0,34 ₽                  |
    | **Intel Ice Lake**                               |
    | 50% vCPU               | 0,70 ₽                  |
    | 100% vCPU              | 1,17 ₽                  |
    | RAM (за 1 ГБ)          | 0,31 ₽                  |


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
