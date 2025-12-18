# How to change the time zone on {{ managed-k8s-name }} cluster nodes


## Case description {#case-description}

* You need to change the default time zone on {{ managed-k8s-name }} cluster nodes.
* You need to set the time zone for one or more {{ managed-k8s-name }} cluster nodes.

## Solution {#case-resolution}

All VMs created in {{ yandex-cloud }}, including {{ managed-k8s-name }} cluster nodes, synchronize their system clock with the physical hypervisor in the `UTC+0` time zone.

{% note tip %}

We recommend updating your app code to change the time zone to the one you need, e.g., `UTC+3` (Moscow/Riyadh).

{% endnote %}

Setting the time zone can also be important when running `CronJob` events, as such events in {{ managed-k8s-name }} default to the time specified on the Controller Manager. For step-by-step guide on specifying the time zone for specific `CronJob` events, refer to [this {{ k8s }} article](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones).

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Your use case that involves changing the default time zone to the one of your choice.