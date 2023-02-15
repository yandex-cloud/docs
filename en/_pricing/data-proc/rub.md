{% list tabs %}

- Standard hosts

   | Computing resources | Cost per hour, including VAT |
   |------------------------|-------------------------|
   | **Intel Broadwell** |
   | 20% vCPU | ₽0.90 |
   | 100% vCPU | ₽1.23 |
   | 1 GPU | ₽274.47 |
   | RAM (for 1 GB) | ₽0.42 |
   | **Intel Cascade Lake** |
   | 20% vCPU | ₽0.51 |
   | 50% vCPU | ₽0.78 |
   | 100% vCPU | ₽1.31 |
   | RAM (for 1 GB) | ₽0.34 |
   | **Intel Ice Lake** |
   | 50% vCPU | ₽0.70 |
   | 100% vCPU | ₽1.17 |
   | RAM (for 1 GB) | ₽0.31 |

{% if product == "yandex-cloud" %}

- Dedicated hosts

   Pricing for resources on dedicated hosts is provided in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices-dedicated-host).

   | Computing resources | {{ dataproc-name }} surcharge for 1 hour, including VAT |
   |------------------------|------------------------------------------------|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.dataproc.v2.ram|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|RUB|mdb.dataproc.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|RUB|mdb.dataproc.v3.ram|string }} |

{% endif %}

{% endlist %}
