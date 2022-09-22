---
editable: false
---

# Pricing for {{ serverless-containers-name }}

## What goes into the cost of using {{ serverless-containers-name }} {#rules}

In {{ serverless-containers-name }}, you're billed for the number of container calls, computing resources allocated for the application, the prepared instances downtime and outgoing traffic.

When billing computing resources, the number of cores (vCPUs), the memory allocated for the application, and the time that the application runs are taken into account:

* The number of cores specified when creating a revision is measured in vCPUs and is a positive real number.
* The memory size specified when creating a revision is measured in GB.
* The total container time is measured in hours and is rounded up to a multiple of 100 ms.

{% note warning %}

You're charged for all the container invocations that trigger your code to run.

{% endnote %}

## Pricing {#prices}

### Invoking a container {#prices-invoking}

{% if region == "ru" %}

{% include notitle [rub-invocation.md](../_pricing/serverless-containers/rub-invocations.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-invocation.md](../_pricing/serverless-containers/kzt-invocations.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-invocation.md](../_pricing/serverless-containers/usd-invocations.md) %}

{% endif %}

### RAM usage time when processing requests {#prices-ram}

{% if region == "ru" %}

{% include notitle [rub-ram.md](../_pricing/serverless-containers/rub-ram.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-ram.md](../_pricing/serverless-containers/kzt-ram.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-ram.md](../_pricing/serverless-containers/usd-ram.md) %}

{% endif %}

### CPU usage time when processing requests {#prices-cpu}

{% if region == "ru" %}

{% include notitle [rub-cpu.md](../_pricing/serverless-containers/rub-cpu.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-cpu.md](../_pricing/serverless-containers/kzt-cpu.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-cpu.md](../_pricing/serverless-containers/usd-cpu.md) %}

{% endif %}

### Provisioned instances {#provisioned-instances}

{% note info %}

Prices are valid from October 17, 2022.

{% endnote %}

#### RAM usage time {#prices-ram-provisioned-instances}

{% if region == "ru" %}

{% include notitle [rub-ram-provisioned-instances.md](../_pricing/serverless-containers/rub-ram-provisioned-instances.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-ram-provisioned-instances.md](../_pricing/serverless-containers/kzt-ram-provisioned-instances.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-ram-provisioned-instances.md](../_pricing/serverless-containers/usd-ram-provisioned-instances.md) %}

{% endif %}

#### CPU usage time {#prices-cpu-provisioned-instances}

{% if region == "ru" %}

{% include notitle [rub-cpu-provisioned-instances.md](../_pricing/serverless-containers/rub-cpu-provisioned-instances.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-cpu-provisioned-instances.md](../_pricing/serverless-containers/kzt-cpu-provisioned-instances.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-cpu-provisioned-instances.md](../_pricing/serverless-containers/usd-cpu-provisioned-instances.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}
