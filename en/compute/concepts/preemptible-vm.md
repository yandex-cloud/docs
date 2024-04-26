---
title: "Preemptible VMs in {{ compute-full-name }}"
---

# Preemptible VMs

*Preemptible VMs* are VM instances that may be forcibly stopped at any time. This can happen in these two cases:
* If 24 hours elapsed since the VM was started.
* If there is a lack of resources to launch a regular VM in the same [availability zone](../../overview/concepts/geo-scope.md). Such an event is usually unlikely, but this may vary day to day.

Preemptible VMs are available at a [lower price](../pricing.md#prices-instance-resources) than regular ones. However, they do not provide fault-tolerance.

You can [create](../operations/vm-create/create-preemptible-vm.md#create-preemptible) a preemptible VM or [change the type](../operations/vm-create/create-preemptible-vm.md#preemptible-to-regular) of an existing one.

This will change pricing for the VM instance. For more information, see our [pricing policy](../pricing.md).


## Limitations {#restrictions}

In addition to the fact that preemptible VMs can be forcibly stopped, they have the following limitations:

* If there are not enough resources in the specified availability zone to launch a preemptible VM, it will not get launched.
* Preemptible VMs are not subject to the [SLA](../../overview/sla.md).

## Working with preemptible VMs {#work-with-preemptible-vm}

When a preemptible VM is stopped, it is not deleted and all its data is saved. When you need the VM again, you can just [start it](../operations/vm-control/vm-stop-and-start#start).

With the [{{ sf-full-name }}](../../functions/) function, you can [configure](../tutorials/nodejs-cron-restart-vm.md) a stopped preemptible VM to run automatically.

{% note info %}

In [{{ ig-name }}](instance-groups/index.md), stopped VMs start automatically based on the [autohealing](instance-groups/autohealing.md) feature.

With {{ ig-name }}, preemptible VMs in the group get stopped after a random interval of 22 to 24 hours, rather than exactly after 24 hours. This helps avoid situations when all VMs in the group restart at the same time and stop handling the load of running applications.

{% endnote %}
