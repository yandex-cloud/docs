---
editable: false
---

# {{ ml-platform-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using {{ ml-platform-name }}, you pay for the use of computing resources: the computation and instance running time is charged per second.

### Billing unit {#unit}

Pricing is based on a billing unit. The number of billing units spent on computation depends on:
* Computing resource capacity.
* Computation time.

  The computation time is rounded up to an integer of seconds.

One billing unit represents the cost of using one CPU core for one second. The number of units depends on the computing resource configuration.

### {{ ds-nb }} {#dedicated}

When performing computations and training models in {{ ml-platform-name }} notebooks, you pay for the whole time the VM is used since the first computations are run in a notebook until the VM is released, regardless of whether any computations were performed after the first run. If you run computations using {{ dataproc-name }} clusters, they are [charged separately](#data-proc).

You are separately charged for [data storage](#storage) in datasets and project storage expansion.

### Running jobs in {{ ml-platform-name }} Jobs {#jobs}

When you run computations remotely using [{{ ml-platform-name }} Jobs](concepts/jobs/index.md), you pay for the computation time in the selected computing resource configuration. You also pay for [storing data](#prices-storage) required to run jobs: their cache, logs, input data, and execution results.

### {{ ds-inf }} {#node}

When deploying models in {{ ds-inf }}, you pay for the uptime of each node instance: from its start to deletion.

You pay for additional [node instance disks](#prices-storage) separately.

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of computations in {{ dataproc-name }} clusters includes:
* Computing resources of the selected {{ ml-platform-name }} configuration.
* The {{ dataproc-name }} cluster's full lifetime duration according to the [{{ dataproc-full-name }}](../data-proc/pricing.md) pricing policy.

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Disk space usage {#storage}

Each {{ ml-platform-name }} project has a free-of-charge storage amount. If you increase the project size [quota]({{ link-console-quotas }}), the entire requested [storage capacity](#prices-storage) exceeding {{ ml-project-size }} is paid for separately. For more information about pricing, see [{#T}](concepts/limits.md).

[Data storage inside datasets](#prices-storage) is charged separately.

If you need to store large amounts of data, you can use {{ objstorage-full-name }}. In which case you will pay for data storage according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

[Model storage](#prices-storage) is charged separately. Its pricing depends on the model size that is calculated in GB and rounded up to an integer.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly prices are based on 720 hours per month.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The prices of the configurations are valid for computations in [{{ ds-nb }}](concepts/project.md#mode), [{{ ds-jobs }}](concepts/jobs/index.md) jobs, and the use of [{{ ds-inf }}](../datasphere/concepts/deploy/index.md).



{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}


### Storing data inside {{ ml-platform-name }} {#prices-storage}



{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Examples of cost calculation {#price-example}

### {{ ds-nb }} {#price-example-notebook}

Cost of using {{ ml-platform-name }} with the following parameters:

* **Computing resources**: g1.1 configuration with 8 CPUs and 1 GPU
* **VM usage time**: 10 minutes

The cost of using the service will be:



{% include [usd-datasphere-notebook](../_pricing_examples/datasphere/usd-notebook.md) %}


### {{ ds-inf }} {#price-example-node}

Cost of using {{ ds-inf }} with the following parameters:

* **Number of instances per node**: 2.
* **Instance configuration**: g1.1 with 8 CPUs and 1 GPU.
* **Node runtime**: 2 days 3 hours 36 minutes.

Converting node runtime into seconds:

> 2 × (24 × 60 × 60) + 3 × (60 × 60) + 36 × 60 = 172,800 + 10,800 + 2,160 = 185,760

Where:
* (24 × 60 × 60): Number of seconds in 24 hours.
* (60 × 60): Number of seconds in 1 hour.
* 60: Number of seconds in 1 minute.

The cost of using {{ ds-inf }} will be:



{% include [usd-datasphere-inference](../_pricing_examples/datasphere/usd-inference.md) %}


