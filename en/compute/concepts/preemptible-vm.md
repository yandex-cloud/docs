# Preemptible VMs

Preemptible virtual machine is an additional option when creating a machine, which allows you to use Yandex.Cloud computing resources at a lower price. Virtual machines with this option will be forcibly stopped within 24 hours of their creation. Stopped machines can be restarted without any data loss.

> [!NOTE]
>
> Preemptible VMs can be forcibly stopped at any time.

Preemptible VMs are cheaper than regular ones, but they do not provide full failover. For more information about pricing, see the section [[!TITLE]](../pricing.md#prices-preemptible-instance-resources).

To create a preemptible VM, [follow the instructions](../operations/vm-create/create-preemptible-vm.md).

## Restrictions

Preemptible VMs run like regular VMs, but they have the following restrictions:

- There are no SLA obligations.
- A preemptible VM can terminate at any time. The probability of such an event is low, but it can change daily and from one availability zone to another.
- You cannot change the VM type.
- A preemptible VM always terminates within 24 hours.
