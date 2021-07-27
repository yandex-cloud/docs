---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Preemptible VMs

*Preemptible instances* are instances that may be terminated at any time. This can occur in two cases:

* If 24 hours have passed since the instance was started.
* If there are insufficient resources to launch a regular instance in the same availability zone. The probability of termination is low, but varies depending on the day.

Preemptible instances are available at a [lower price](../pricing.md#prices-preemptible-instance-resources) than regular instances. However, they don't provide fault-tolerance.

## Limits {#restrictions}

In addition to the fact that preemptible instances can be forcibly stopped, they have the following limitations:

- If there aren't enough resources in the specified availability zone to launch a preemptible instance, it won't launch.
- A preemptible instance can't be turned into a standard VM and vice versa.
- Preemptible stances aren't subject to an [SLA](../../overview/sla.md).

## How to work with preemptible instances {#work-with-preemptible-vm}

To create a preemptible VM, [follow the instructions](../operations/vm-create/create-preemptible-vm.md).

The instance isn't deleted after it's stopped and all its data is saved. When you need the instance again, [start it](../operations/vm-control/vm-stop-and-start#start) again.

{% note info %}

In [{{ ig-name }}](instance-groups/index.md), stopped instances start automatically thanks to [auto-healing](instance-groups/autohealing.md).

{{ ig-name }} stops preemptible instances in the group not exactly after 24 hours, but after a random interval from 22 to 24 hours. This prevents all instances in the group from restarting at the same time and ceasing to handle the load of running applications.

{% endnote %}

