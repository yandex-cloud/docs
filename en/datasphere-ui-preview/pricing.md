---
editable: false
---

# Pricing for {{ ml-platform-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ ml-platform-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

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

Learn more about [background operations](../datasphere/concepts/async.md).

{% if region == "ru"%}

{% include [rub-async.md](../_pricing/datasphere/rub-async-new.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-async.md](../_pricing/datasphere/kzt-async-new.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-async.md](../_pricing/datasphere/usd-async-new.md) %}

{% endif %}

### Storing data inside {{ ml-platform-name }} {#prices-storage}

#### Storing project data {#project-data}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/datasphere/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/datasphere/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/datasphere/usd-storage.md) %}

{% endif %}

#### Datasets {#prices-datasets}

{% if region == "ru"%}

{% include [rub-data-storage.md](../_pricing/datasphere/rub-dataset.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-data-storage.md](../_pricing/datasphere/kzt-dataset.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-data-storage.md](../_pricing/datasphere/usd-dataset.md) %}

{% endif %}

### Egress traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}
