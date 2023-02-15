{% list tabs %}

- Standard hosts

   | Computing resources | Cost per hour, without VAT |
   |---------------------|------------------------------|
   | **Intel Broadwell** |
   | 20% vCPU | $0.007233 |
   | 100% vCPU | $0.009906 |
   | 1 GPU | $2.199346 |
   | RAM (for 1 GB) | $0.003386 |
   | **Intel Cascade Lake** |
   | 20% vCPU | $0.004115 |
   | 50% vCPU | $0.006231 |
   | 100% vCPU | $0.010545 |
   | RAM (for 1 GB) | $0.002795 |
   | **Intel Ice Lake** |
   | 50% vCPU | $0.005647 |
   | 100% vCPU | $0.009577 |
   | RAM (for 1 GB) | $0.002538 |

{% if product == "yandex-cloud" %}

- Dedicated hosts

   Dedicated hosts are charged as described in [{{ compute-full-name }} documentation](../../compute/pricing.md#prices-dedicated-host).

   | Computing resources | Markup for {{ dataproc-name }} per hour, without VAT |
   |----------------------|--------------------------------------------------------|
   | **Intel Cascade Lake** |
   | 100% vCPU | {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.dataproc.v2.ram|string }} |
   | **Intel Ice Lake** |
   | 100% vCPU | {{ sku|USD|mdb.dataproc.v3.cpu.c100|string }} |
   | RAM (for 1 GB) | {{ sku|USD|mdb.dataproc.v3.ram|string }} |

{% endif %}

{% endlist %}
