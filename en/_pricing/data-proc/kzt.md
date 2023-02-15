{% list tabs %}

- Standard hosts

   | Computing resources | Cost per hour, including VAT |
   |------------------------|-------------------------|
   | **Intel Broadwell** |
   | 20% vCPU | ₸4.50 |
   | 100% vCPU | ₸6.15 |
   | 1 GPU | ₸1372.35 |
   | RAM (for 1 GB) | ₸2.10 |
   | **Intel Cascade Lake** |
   | 20% vCPU | ₸2.55 |
   | 50% vCPU | ₸3.90 |
   | 100% vCPU | ₸6.55 |
   | RAM (for 1 GB) | ₸1.70 |
   | **Intel Ice Lake** |
   | 50% vCPU | ₸3.50 |
   | 100% vCPU | ₸5.85 |
   | RAM (for 1 GB) | ₸1.55 |

{% if product == "yandex-cloud" %}

- Dedicated hosts

   Pricing for resources on dedicated hosts is provided in the [{{ compute-full-name }} documentation](../../compute/pricing.md#prices-dedicated-host).

   | Computing resources | {{ dataproc-name }} surcharge for 1 hour, including VAT |
   |------------------------|------------------------------------------------|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|KZT|mdb.dataproc.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.dataproc.v2.ram|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|KZT|mdb.dataproc.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|KZT|mdb.dataproc.v3.ram|string }} |

{% endif %}

{% endlist %}
