---
editable: false
---
# Pricing for {{ ml-platform-name }}

## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using the {{ ml-platform-name}} service, you pay for the actual use of computing resources: the calculation time or the operation of instances is charged per second.

1. When performing calculations and experiments or training models, you pay for the calculation time. If you do not perform computational operations in the project, the service usage time {{ ml-platform-name }} is not charged. However, if you perform calculations using {{ dataproc-name}} clusters, they are charged separately. For more information, see [using clusters {{dataproc-name }}](#data-proc). Also, storage of [datasets](#storage) is charged separately.

1. When deploying models, the cost of using {{ ml-platform-name }} consists of the operating time and capacity of all node instances. The operating time of each instance begins at the time of its launch and ends after the instance is deleted.

### Pricing unit {#unit}

A billing measure is a one billing unit. The number of billing units spent on calculation depends on:
* capacity of computing resources used;
* time spent on the calculation.
    
    The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit is the cost of using 1 CPU core for 1 second. The number of units depends on [computing resource configuration](concepts/configurations.md).

Configuration | Units per second
----- | ---- 
c1.4 | 4
c1.8 | 8
c1.32 | 32
c1.80 | 80
g1.1 | 72
g1.2 | 144
g1.4 | 288
g2.mig | 18
g2.1 | 116
g2.2 | 232
g2.4 | 464
g2.8 | 928

{% if region == "int"%}

### Example of cost calculation {#price-example}

Example of cost calculation:
- **Computing resource:** configuration c1.8 with 8 CPUs and 1 GPU.
- **Operation execution time:** 1,400 MS (rounded up to an integer number of seconds).

Cost calculation:

> 72 × 2 = 144 units per calculation
> 144 × 0.000009 = $0.001296
>
> Total: $0.001296

Where:
* 72 — number of units per configuration g1.1.
* 2 — rounded up 1,400 MS.
* $0.000009 — cost of 1 unit.

{% endif %}

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of using integration with the {{ dataproc-name}} service takes into account:
* Configuration c1.4 computing resources {{ml-platform-name }}.
  These resources are created for integration with the {{ dataproc-name}} cluster and are charged while the cluster is being calculated.
* The entire lifetime of the cluster {{ dataproc-name }} according to [pricing rules {{ dataproc-full-name }}](../data-proc/pricing.md).

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Storing data in the project {#storage}

Each project {{ml-platform-name }} has a storage within which data storage is not charged. If the quota for the project size is increased, the [storage volume](#project-data) over {{ ml-project-size }} is paid separately. For more information about quotas and limits of the service, see [{#T}](concepts/limits.md).

If you need to store large amounts of data that exceed the specified limits, use the {{ objstorage-full-name }} service. In this case, data storage will be charged according to [pricing rules {{ objstorage-name }}](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours a month.

## Pricing {#prices}

{% if region != "int" %}

{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}

{% endif %}

{% if region == "ru"%}

{% include [rub-unit-and-resource.md](../_pricing/datasphere/rub-unit-and-resource.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-unit-and-resource.md](../_pricing/datasphere/kzt-unit-and-resource.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}

{% endif %}

### Performing background operations {#async}

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async-new.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async-new.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}

{% endif %}

### {{ ml-platform-name }} data storing {#prices-storage}

#### Project data {#project-data}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/datasphere/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/datasphere/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}

{% endif %}

#### Datasets {#datasets}

{% if region == "ru"%}

{% include [rub-data-storage.md](../_pricing/datasphere/rub-dataset.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-data-storage.md](../_pricing/datasphere/kzt-dataset.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz"%}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int"%}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

### Marking up audio files {#markup}

This section shows the price of [{#T}](tutorials/markup.md). The price is indicated per billable unit, the total cost of markup depends on the amount of data and will be calculated after the data is uploaded.

{% if region == "ru" %}

Service | Rate for the billable unit, with VAT 
---|---
[Marking up audio files](tutorials/markup.md) | {{ sku|RUB|ai.speech.transcribe.human.v1|string }} 

{% endif %}

{% if region == "kz" %}

Service | Rate for the billable unit, with VAT 
---|---
[Marking up audio files](tutorials/markup.md) | {{ sku|KZT|ai.speech.transcribe.human.v1|string }} 

{% endif %}

{% if region == "int" %}

Service | Rate for the billable unit, without VAT
---|---
[Marking up audio files](tutorials/markup.md) | {{ sku|USD|ai.speech.transcribe.human.v1|string }} 

{% endif %}