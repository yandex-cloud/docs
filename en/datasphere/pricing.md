---
editable: false
---

# Pricing for {{ ml-platform-name }}



## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using {{ ml-platform-name }}, you pay for the use of computing resources: the compute and instance running time is charged per second.

1. When performing computations and training models, you pay for the compute time. If you don't perform any computational operations in a project, the {{ ml-platform-name }} usage time is not charged. However, if you run calculations using {{ dataproc-name }} clusters, they are charged separately. For more information, see [Using {{ dataproc-name }} clusters](#data-proc). You're separately charged for [data storage in datasets](#storage).

1. {% include [pricing nodes](../_includes/datasphere/nodes-pricing-warn.md) %}

### Pricing unit {#unit}

A pricing unit is one billing unit. The number of billing units spent on calculations depends on:
* The computing resources used.
* The time spent on calculations.

  The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit is the cost of using 1 CPU core per second. The number of units depends on [computing resource configurations](concepts/configurations.md).

| Configuration | Number of units per second |
----- | ---- 
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

Example of cost calculation
- **Computing resources:** g1.1 configuration with 8 CPUs and 1 GPU.
- **Operation execution time:** 1400 ms (rounded up to an integer number of seconds).

Cost calculation:

> 72 × 2 = 144 units per computation 
> 144 × 0.0000096 = $0.0013824
>
> Total: $0.0013824

Where:
* 72 is the number of units per g1.1 configuration.
* 2 is 1400 ms rounded up to the nearest second.
* $0.0000096 is the cost of 1 unit.

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of using integration with the {{ dataproc-name }} service takes into account:

* {{ ml-platform-name }} c1.4 configuration computing resources.
  These resources are created for integration with the {{ dataproc-name }} cluster and are charged while calculations are running on the cluster.
* The entire lifetime of the {{ dataproc-name }} cluster according to the [{{ dataproc-full-name }} pricing policy](../data-proc/pricing.md).

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Disk space usage {#storage}

Each {{ ml-platform-name }} project has a free-of-charge storage amount. If you increase the quota on project size, the [storage](#project-data) exceeding {{ ml-project-size }} is paid separately. For more information about pricing, see [{#T}](concepts/limits.md).

[Data storage inside datasets](#prices-datasets) is charged separately.

If you need to store large amounts of data, you can use {{ objstorage-full-name }}. In this case, data storage will be charged according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours a month.

## Pricing {#prices}




{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}


### Performing background operations {#async}

Learn more about [background operations](concepts/async.md).




{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}


### Storing data inside {{ ml-platform-name }} {#prices-storage}

#### Storing project data {#project-data}




{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}


#### Datasets {#prices-datasets}




{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}



### Labeling audio files {#markup}

This section specifies the cost of [audio markup](tutorials/markup.md). The cost is per rating unit. The final markup cost depends on the data amount and will be calculated after the data is uploaded.



