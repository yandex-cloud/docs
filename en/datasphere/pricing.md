---
editable: false
---

# {{ ml-platform-name }} pricing

{% include [serverless-deprecation-note](../_includes/datasphere/serverless-deprecation-note.md) %}



## What goes into the cost of using {{ ml-platform-name }} {#rules}

When using {{ ml-platform-name }}, you pay for the use of computing resources: the compute and instance running time is charged per second.

### Running {{ ml-platform-name }} in the {{ ds }} mode {#serverless}

When performing computations and training models in the [{{ ds }} mode](concepts/project.md#serverless), you pay for the compute time. If you do not perform any computational operations in a project, the {{ ml-platform-name }} usage time is not charged. However, if you run computations using {{ dataproc-name }} clusters, they are charged separately. For more information, see [Using {{ dataproc-name }} clusters](#data-proc).

You are separately charged for [data storage](#storage) in datasets and project storage expansion.

### Running {{ ml-platform-name }} in the {{ dd }} mode {#dedicated}

When performing computations and training models in the [{{ dd }} mode](concepts/project.md#dedicated), you pay for the VM usage time since the first computations are run in a notebook until the VM is released regardless of whether any computations were performed after the initial run. If you run computations using {{ dataproc-name }} clusters, they are [charged separately](#data-proc).

You are separately charged for [data storage](#storage) in datasets and project storage expansion.

### Running jobs in {{ ml-platform-name }} Jobs {#jobs}

When you run computations remotely using [{{ ml-platform-name }} Jobs](concepts/jobs/index.md), you pay for the computation time in the selected computing resource configuration. You also pay for [storing data](#prices-jobs) required to run jobs: their cache, logs, input data, and execution results.

### Using models {#node}

{% include [pricing nodes](../_includes/datasphere/nodes-pricing-warn.md) %}

{% include [prices](../_includes/datasphere/migration/pricing.md) %}

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of using integration with the {{ dataproc-name }} service takes into account:
* {{ ml-platform-name }} c1.4 configuration computing resources.
   These resources are created for integration with the {{ dataproc-name }} cluster and are charged while computations are running on the cluster.
* The entire lifetime of the {{ dataproc-name }} cluster according to the [{{ dataproc-full-name }} pricing policy](../data-proc/pricing.md).

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Disk space usage {#storage}

Each {{ ml-platform-name }} project has a free-of-charge storage amount. If you increase the project size [quota]({{ link-console-quotas }}), the entire requested [storage capacity](#project-data) exceeding {{ ml-project-size }} is paid for separately. For more information about pricing, see [{#T}](concepts/limits.md).

[Data storage inside datasets](#prices-datasets) is charged separately.

If you need to store large amounts of data, you can use {{ objstorage-full-name }}. In this case, data storage will be charged according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

[Model storage](#prices-models) is charged separately. Its pricing depends on the model size that is calculated in GB and rounded up to an integer.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours a month.

## Pricing {#prices}

Prices for using configurations apply to [{{ ml-platform-name }} {{ ds }}](concepts/project.md#serverless), [background operations](../datasphere/concepts/async.md), [{{ ml-platform-name }} {{ dd }}](concepts/project.md#dedicated) and when you [use models](../datasphere/concepts/deploy/index.md#node).




{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}


### Storing data inside {{ ml-platform-name }} {#prices-storage}

#### Storing project data {#project-data}




{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}


#### Datasets {#prices-datasets}




{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}


#### Models {#prices-models}




{% include [usd-model.md](../_pricing/datasphere/usd-model.md) %}


#### {{ ml-platform-name }} Jobs {#prices-jobs}




{% include [usd-jobs.md](../_pricing/datasphere/usd-jobs.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


