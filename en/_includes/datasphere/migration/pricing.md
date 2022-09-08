## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using {{ ml-platform-name }}, you pay for the use of computing resources: the compute and instance running time is charged per second.
1. When performing computations and training models, you pay for the compute time. If you don't perform any computational operations in a project, the {{ ml-platform-name }} usage time is not charged. However, if you run calculations using {{ dataproc-name }} clusters, they are charged separately. For more information, see [Using {{ dataproc-name }} clusters](#data-proc). You're separately charged for [data storage in datasets](#storage).
1. {% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

### Pricing unit {#unit}

A pricing unit is one billing unit. The number of billing units spent on calculations depends on:
* The computing resources used.
* The time spent on calculations.

   The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit is the cost of using 1 CPU core for 1 second. The number of units depends on computing resource configurations.

| Configuration | Number of units per second |
|--------------|-----------------------------|
| c1.4 | 4 |
| c1.8 | 8 |
| c1.32 | 32 |
| c1.80 | 80 |
| g1.1 | 72 |
| g1.2 | 144 |
| g1.4 | 288 |
| g2.mig | 18 |
| g2.1 | 116 |
| g2.2 | 232 |
| g2.4 | 464 |
| g2.8 | 928 |

[Background operation costs](#async) are calculated separately.

#### Example of cost calculation {#price-example}

The cost of using {{ ml-platform-name }} with the following parameters:

* **Computing resources:** g1.1 configuration with 8 CPUs and 1 GPU.
* **Operation execution time:** 1400 ms (rounded up to an integer number of seconds).

Cost calculation:

> 72 × 2 = 144 units per computation
> 144 × {% if region == "ru"%}0.0012{% endif %}{% if region == "int"%}0.0000096{% endif %}{% if region == "kz"%}0.0060{% endif %} = {% if region == "ru"%}₽0.1728{% endif %}{% if region == "int"%}$0.0013824{% endif %}{% if region == "kz"%}₸0.8640{% endif %}
>
> Total: {% if region == "ru"%}₽0.1728{% endif %}{% if region == "int"%}$0.0013824{% endif %}{% if region == "kz"%}₸0.8640{% endif %} is the cost of using {{ ml-platform-name }}.

Where:
* 72 is the number of units per g1.1 configuration.
* 2 is 1400 ms rounded up to the nearest second.
* {% if region == "ru"%}₽0.0012{% endif %}{% if region == "int"%}$0.0000096{% endif %}{% if region == "kz"%}₸0.0060{% endif %} is the cost per unit.