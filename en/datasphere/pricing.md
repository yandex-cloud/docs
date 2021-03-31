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




{% include [usd.md](../_pricing/datasphere/usd.md) %}

{% include [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}



