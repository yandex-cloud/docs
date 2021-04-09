---
editable: false
---
# Pricing for {{ ml-platform-name }}

## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using the {{ ml-platform-name}} service, you pay for the actual use of computing resources: the calculation time is charged per second.

If you do not perform computational operations in the project, the service usage time {{ml-platform-name }} is not charged. However, if you perform calculations using {{ dataproc-name}} clusters, they are charged separately. For more information, see [using clusters {{dataproc-name }}](#data-proc).

### Pricing unit {#unit}

A billing measure is a one billing unit. The number of billing units spent on calculation depends on:
* capacity of computing resources used;
* time spent on the calculation.
    
    The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit is the cost of using 1 CPU core for 1 second. The number of units depends on [computing resource configuration](concepts/configurations.md).
* S-configuration — 4 units per second.
* M-configuration — 8 units per second.
* L-configuration — 72 units per second.
* XL-configuration — 288 units per second.

{% if region == "int"%}

### Example of cost calculation {#price-example}

Example of cost calculation:
- **Computing resource:** L-configuration with 8 CPUs and 1 GPU.
- **Operation execution time:** 1,400 MS (rounded up to an integer number of seconds).

Cost calculation:

> 72 × 2 = 144 units per calculation
> 144 × 0.000009 = $0.001296
>
> Total: $0.001296

Where:
* 72 — number of units per L-configuration.
* 2 — rounded up 1,400 MS.
* $0.000009 — cost of 1 unit.

{% endif %}

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of using integration with the {{ dataproc-name}} service takes into account:
* S-configuration computing resources {{ml-platform-name }}.

    These resources are created for integration with the {{ dataproc-name}} cluster and are charged while the cluster is being calculated.
* The entire lifetime of the cluster {{ dataproc-name }} according to [pricing rules {{ dataproc-full-name }}](../data-proc/pricing.md).

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Storing data in the project {#storage}

Data storage inside {{ ml-platform-name }} is not charged within the established [quotas and limits](concepts/limits.md).
If you need to store large amounts of data that exceed the specified limits, use the {{ objstorage-full-name }} service. In this case, data storage will be charged according to [pricing rules {{ objstorage-name }}](../storage/pricing.md).

## Pricing {#prices}

{% if region == "ru"%}

{% include [rub-unit-and-resource.md](../_pricing/datasphere/rub-unit-and-resource.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt-unit-and-resource.md](../_pricing/datasphere/kzt-unit-and-resource.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}

{% endif %}

### Performing background operations {#async}

More about [background operations](concepts/async.md).

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async.md) %}

{% endif %}

{% if region == "pre-kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}