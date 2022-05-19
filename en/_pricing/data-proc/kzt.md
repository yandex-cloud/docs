{% list tabs %}

- Standard hosts

    | Computing resources    | Rate for 1 hour, with VAT | |
    |------------------------|------------------------------|---|
    | | **Up until April 12, 2022** | **Starting April 13, 2022** |
    | **Intel Broadwell**                                   | |
    | 20% vCPU               | ₸3.3852                      | ₸4.50 |
    | 100% vCPU              | ₸4.6362                      | ₸6.15 |
    | 1 GPU                  | ₸1029.2940                   | ₸1372.35 |
    | RAM (for 1 GB)         | ₸1.5846                      | ₸2.10 |
    | **Intel Cascade Lake**                                | |
    | 20% vCPU               | ₸1.9260                      | ₸2.55 |
    | 50% vCPU               | ₸2.9178                      | ₸3.90 |
    | 100% vCPU              | ₸4.9356                      | ₸6.55 |
    | RAM (for 1 GB)         | ₸1.3080                      | ₸1.70 |
    | **Intel Ice Lake**                                    | |
    | 50% vCPU               | ₸2.6430                      | ₸3.50 |
    | 100% vCPU              | ₸4.4820                      | ₸5.85 |
    | RAM (for 1 GB)         | ₸1.1880                      | ₸1.55 |

- Dedicated hosts

    Pricing for resources on dedicated hosts is provided in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices-dedicated-host).

    | Computing resources | {{ dataproc-name }} surcharge for 1 hour, with VAT | |
    |------------------------|------------------------------------------------|---|
    | | **Up until April 12, 2022** | **Starting April 13, 2022** |
    | **Intel Cascade Lake**                                    | |
    | 100% vCPU | {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }} | ₸0.60 |
    | RAM (for 1 GB) | {{ sku|KZT|mdb.dataproc.v2.ram|string }} | ₸0.15 |
    | **Intel Ice Lake**                                        | |
    | 100% vCPU | {{ sku|KZT|mdb.dataproc.v3.cpu.c100|string }} | ₸0.60 |
    | RAM (for 1 GB) | {{ sku|KZT|mdb.dataproc.v3.ram|string }} | ₸0.15 |

{% endlist %}
