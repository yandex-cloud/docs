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

### Unit cost {#unit}

{% list tabs %}

- Prices in USD

    Number | Price per 1 second of calculation, <br>without VAT
    ----- | ---- |
    One unit | $0.000009

- Prices in roubles

    Number | Price per 1 second of calculation, <br>with VAT
    ----- | ---- |
    One unit | ₽0.00075 
  
{% endlist %}

### Computing resource {#paug}

{% list tabs %}

- Prices in USD
  
    Configuration | Number of units <br> per configuration | Duration of <br>calculation | Price per calculation, <br>without VAT
    ----- | ---- | ---- | ---- 
    S (4 vCPU, 0 GPU) | 4 | 1 second | $0.000038
    S (4 vCPU, 0 GPU) | 4 | 1 minute | $0.002307 
    S (4 vCPU, 0 GPU) | 4 | 1 hour | $0.138461 
    M (8 vCPU, 0 GPU) | 8 | 1 second | $0.000076
    M (8 vCPU, 0 GPU) | 8 | 1 minute | $0.004614
    M (8 vCPU, 0 GPU) | 8 | 1 hour | $0.276922
    L (8 vCPU, 1 GPU) | 72 | 1 second | $0.000692
    L (8 vCPU, 1 GPU) | 72 | 1 minute| $0.041538
    L (8 vCPU, 1 GPU) | 72 | 1 hour | $2.492307
    XL (32 vCPU, 4 GPU) | 288 | 1 second | $0.002768
    XL (32 vCPU, 4 GPU) | 288 | 1 minute | $0.166152
    XL (32 vCPU, 4 GPU) | 288 | 1 hour | $9.969228
  
- Prices in roubles
  
    Configuration | Number of units <br> per configuration | Duration of <br>calculation | Price per calculation, <br>with VAT
    ----- | ---- | ---- | ---- 
    S (4 vCPU, 0 GPU) | 4 | 1 second | ₽0.003
    S (4 vCPU, 0 GPU) | 4 | 1 minute | ₽0.18
    S (4 vCPU, 0 GPU) | 4 | 1 hour | ₽10.8
    M (8 vCPU, 0 GPU) | 8 | 1 second | ₽0.006
    M (8 vCPU, 0 GPU) | 8 | 1 minute | ₽0.36
    M (8 vCPU, 0 GPU) | 8 | 1 hour | ₽21.6
    L (8 vCPU, 1 GPU) | 72 | 1 second | ₽0.054
    L (8 vCPU, 1 GPU) | 72 | 1 minute | ₽3.24
    L (8 vCPU, 1 GPU) | 72 | 1 hour | ₽194.4 
    XL (32 vCPU, 4 GPU) | 288 | 1 second | ₽0.216
    XL (32 vCPU, 4 GPU) | 288 | 1 minute | ₽12.96
    XL (32 vCPU, 4 GPU) | 288 | 1 hour | ₽777.6 
  
{% endlist %}

### Performing asynchronous operations {#async}

{% list tabs %}

- Prices in USD

    Configuration | Number of units |  Duration of <br>calculation | Price per calculation, <br>without VAT
    ----- | ---- | ---- | -----
    S (4 vCPU, 0 GPU) | 1 | 1 second | $0.000009
    S (4 vCPU, 0 GPU) | 1 | 1 minute | $0.000576
    S (4 vCPU, 0 GPU) | 1 | 1 hour | $0.034615
    M (8 vCPU, 0 GPU) | 2 | 1 second | $0.000019
    M (8 vCPU, 0 GPU) | 2 | 1 minute | $0.001153
    M (8 vCPU, 0 GPU) | 2 | 1 hour | $0.069230 
    L (8 vCPU, 1 GPU) | 15 | 1 second | $0.000144
    L (8 vCPU, 1 GPU) | 15 | 1 minute | $0.008653
    L (8 vCPU, 1 GPU) | 15 | 1 hour | $0.519230
    XL (32 vCPU, 4 GPU) | 60  | 1 second | $0.000576
    XL (32 vCPU, 4 GPU) | 60 | 1 minute | $0.034615
    XL (32 vCPU, 4 GPU) | 60  | 1 hour  | $2.076923

- Prices in roubles

    Configuration | Number of units |  Duration of <br>calculation | Price per calculation, <br>with VAT
    ----- | ---- | ---- | ----
    S (4 vCPU, 0 GPU) | 1  | 1 second | ₽0.00075 
    S (4 vCPU, 0 GPU) | 1  | 1 minute | ₽0.045
    S (4 vCPU, 0 GPU) | 1  | 1 hour | ₽2.7
    M (8 vCPU, 0 GPU) | 2 | 1 second | ₽0.0015
    M (8 vCPU, 0 GPU) | 2 | 1 minute | ₽0.09
    M (8 vCPU, 0 GPU) | 2 | 1 hour | ₽5.4
    L (8 vCPU, 1 GPU) | 15 | 1 second | ₽0.01125 
    L (8 vCPU, 1 GPU) | 15 | 1 minute | ₽0.675 
    L (8 vCPU, 1 GPU) | 15 | 1 hour | ₽40.5 
    XL (32 vCPU, 4 GPU) | 60 | 1 second  | ₽0.045 
    XL (32 vCPU, 4 GPU) | 60 | 1 minute  | ₽2.7 
    XL (32 vCPU, 4 GPU) | 60 | 1 hour  | ₽162 

{% endlist %}

{% include [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}



