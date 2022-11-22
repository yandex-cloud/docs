---
editable: false
---

# Pricing for {{ ml-platform-name }}



{% include [prices](../_includes/datasphere/migration/pricing.md) %}

### Using {{ dataproc-name }} clusters {#data-proc}

The cost of using integration with the {{ dataproc-name }} service takes into account:
* {{ ml-platform-name }} c1.4 configuration computing resources.
   These resources are created for integration with the {{ dataproc-name }} cluster and are charged while calculations are running on the cluster.
* The entire lifetime of the {{ dataproc-name }} cluster according to the [{{ dataproc-full-name }} pricing policy](../data-proc/pricing.md).

Learn more about [integration with {{ dataproc-name }}](concepts/data-proc.md).

### Disk space usage {#storage}

Each {{ ml-platform-name }} project has a free-of-charge storage amount. If you increase the [quota]({{ link-console-quotas }}) on project size, the [storage size](#project-data) exceeding {{ ml-project-size }} is paid separately. For more information about pricing, see [{#T}](concepts/limits.md).

[Data storage inside datasets](#prices-datasets) is charged separately.

If you need to store large amounts of data, you can use {{ objstorage-full-name }}. In this case, data storage will be charged according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly usage rate is based on 720 hours a month.

## Pricing {#prices}




{% include [usd-unit-and-resource.md](../_pricing/datasphere/usd-unit-and-resource.md) %}


### Performing background operations {#async}

Learn more about [background operations](../datasphere/concepts/async.md).




{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}


### Storing data inside {{ ml-platform-name }} {#prices-storage}

#### Storing project data {#project-data}




{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}


#### Datasets {#prices-datasets}




{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


