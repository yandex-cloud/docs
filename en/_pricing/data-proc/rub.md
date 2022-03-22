{% list tabs %}

- Standard hosts

    | Computing resources    | Rate for 1 hour, with VAT | |
    |------------------------|------------------------------|---|
    | | **Up until April 12, 2022** | **Starting April 13, 2022** |
    | **Intel Broadwell**                                | |
    | 20% vCPU               | ₽0.5642                   | ₽0.90 |
    | 100% vCPU              | ₽0.7727                   | ₽1.23 |
    | 1 GPU                  | ₽171.5490                 | ₽274.47 |
    | RAM (for 1 GB)         | ₽0.2641                   | ₽0.42 |
    | **Intel Cascade Lake**                        | |
    | 20% vCPU               | ₽0.3210                   | ₽0.51 |
    | 50% vCPU               | ₽0.4863                   | ₽0.78 |
    | 100% vCPU              | ₽0.8226                   | ₽1.31 |
    | RAM (for 1 GB)         | ₽0.2180                   | ₽0.34 |
    | **Intel Ice Lake**                            | |
    | 50% vCPU               | ₽0.4405                   | ₽0.70 |
    | 100% vCPU              | ₽0.7470                   | ₽1.17 |
    | RAM (for 1 GB)         | ₽0.1980                   | ₽0.31 |


- Dedicated hosts

    The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices-dedicated-host) and {{ dataproc-name }} markup for using these resources.

    | Resource | Markup for {{ dataproc-name }}, with VAT ||
    |------------------------|-------------------------|---|
    | | **Up until April 12, 2022** | **Starting April 13, 2022** |
    | **Intel Cascade Lake**                                                  | |
    | 100% vCPU              | {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }}  | ₽0.12 |
    | RAM (for 1 GB)          | {{ sku|RUB|mdb.dataproc.v2.ram|string }}       | ₽0.03 |
    | **Intel Ice Lake**                                                   | |
    | 100% vCPU              | {{ sku|RUB|mdb.dataproc.v3.cpu.c100|string }}  | ₽0.12 |
    | RAM (for 1 GB)          | {{ sku|RUB|mdb.dataproc.v3.ram|string }}       | ₽0.03 |

{% endlist %}