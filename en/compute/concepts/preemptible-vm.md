# Preemptible VMs

*Preemptible instances* are instances that may be terminated at any time. This can occur in two cases:
* If 24 hours have passed since the instance was started.
* If there are insufficient resources to launch a regular instance in the same availability zone. The probability of termination is low, but varies depending on the day.

Preemptible instances are available at a [lower price](../pricing.md#prices-instance-resources) than regular instances. However, they don't provide fault-tolerance.

You can [create](../operations/vm-create/create-preemptible-vm.md#create-preemptible) a preemptible instance or [change the type](../operations/vm-create/create-preemptible-vm.md#preemptible-to-regular) of an existing one.

This will change pricing for the VM instance. For more information, see the [pricing policy](../pricing.md).


## Limitations {#restrictions}

In addition to the fact that preemptible instances can be forcibly stopped, they have the following limitations:

* If there aren't enough resources in the specified availability zone to launch a preemptible instance, it won't launch.
* Preemptible stances aren't subject to an [SLA](../../overview/sla.md).

## How to work with preemptible instances {#work-with-preemptible-vm}

The instance isn't deleted after it's stopped and all its data is saved. When you need the instance again, [start it](../operations/vm-control/vm-stop-and-start#start).

{% note info %}

In [{{ ig-name }}](instance-groups/index.md), stopped instances start automatically thanks to [autohealing](instance-groups/autohealing.md).

{{ ig-name }} stops preemptible instances in the group not exactly after 24 hours, but after a random interval from 22 to 24 hours. This prevents all instances in the group from restarting at the same time and ceasing to handle the load of running applications.

{% endnote %}
