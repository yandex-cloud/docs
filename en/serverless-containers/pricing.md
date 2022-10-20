---
editable: false
---

# Pricing for {{ serverless-containers-name }}

## What goes into the cost of using {{ serverless-containers-name }} {#rules}

In {{ serverless-containers-name }}, you're billed for the number of container invocations, computing resources allocated for the application, downtime of [provisioned instances](concepts/container.md#provisioned-instances), and outgoing traffic.

When billing computing resources, the number of cores (vCPUs), the memory allocated for the application, and the time that the application runs are taken into account:
* The number of cores specified when creating a revision is measured in vCPUs and is a positive real number.
* The memory size specified when creating a revision is measured in GB.
* The total container time is measured in hours and is rounded up to a multiple of 100 ms.

{% note warning %}

You're charged for all the container invocations that trigger your code to run.

{% endnote %}

## Pricing {#prices}

### Invoking a container {#prices-invoking}




{% include notitle [usd-invocation.md](../_pricing/serverless-containers/usd-invocations.md) %}


### RAM usage time when processing requests {#prices-ram}




{% include notitle [usd-ram.md](../_pricing/serverless-containers/usd-ram.md) %}


### CPU usage time when processing requests {#prices-cpu}




{% include notitle [usd-cpu.md](../_pricing/serverless-containers/usd-cpu.md) %}


### Provisioned instances {#provisioned-instances}

{% note info %}

The prices are in effect as of October 17, 2022.

{% endnote %}

#### RAM usage time {#prices-ram-provisioned-instances}




{% include notitle [usd-ram-provisioned-instances.md](../_pricing/serverless-containers/usd-ram-provisioned-instances.md) %}


#### CPU usage time {#prices-cpu-provisioned-instances}




{% include notitle [usd-cpu-provisioned-instances.md](../_pricing/serverless-containers/usd-cpu-provisioned-instances.md) %}


### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

