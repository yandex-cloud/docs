# Preemptible VMs

Preemptible virtual machines use computing resources in Yandex.Cloud at a lower price. You can choose this option when creating a VM. Preemptible VM instances are terminated at least once every 24 hours. Stopped instances can be restarted without data loss.

{% note info %}

Preemptible instances may be terminated at any time.

{% endnote %}

Preemptible instances are cheaper than standard virtual machines, but they don't ensure fault tolerance. To get more information about preemptible VM prices, see [{#T}](../pricing.md#prices-preemptible-instance-resources).

To create a preemptible VM, [follow the instructions](../operations/vm-create/create-preemptible-vm.md).

## Restrictions

Preemptible instances run like regular VMs, but they have the following restrictions:

- There are no SLA obligations.
- A preemptible instance can terminate at any time. The probability of termination is low, but it varies depending on the day and the availability zone.
- A preemptible instance cannot be turned into a standard VM and vice versa.
- A preemptible instance always terminates within 24 hours.

