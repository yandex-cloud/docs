---
editable: false
---

# Pricing policy for {{ serverless-containers-name }}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ serverless-containers-name }} can be used free of charge.

Until and including September 23st of 2021, {{ serverless-containers-name }} can be used free of charge. Since September 24st of 2021, service will become paid.

## What goes into the cost of using {{ serverless-containers-name }} {#rules}

In In {{ serverless-containers-name }}, you're billed for the number of containers invoked, computing resources allocated for the applications, and outgoing traffic.

When billing computing resources, the number of cores (vCPU), the memory allocated for the application and application execution time are taken into account:
* The number of cores specified when creating a revision is measured in vCPU and is a positive real number.
* The amount of memory specified when creating a revision, in GB.
* The total running time of the container in hours, rounded up to the nearest multiple of 100 ms.

{% note warning %}

You're charged for all the containers invoked that trigger your application to run.

{% endnote %}

## Pricing {#prices}

### Invoking a container {#prices-invoke}

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
