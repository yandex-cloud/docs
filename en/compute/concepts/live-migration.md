# Live migration

{{ compute-name }} uses the live migration feature that allows you to move running [VMs](vm.md) across physical servers without stopping or restarting them. The downtime usually does not exceed 10 seconds.

Live migration does not change any VM settings. The live migration process moves a running VM from one server to another in the same [availability zone](../../overview/concepts/geo-scope.md). This does not affect any VM properties, including [internal and external IP addresses](../../vpc/concepts/address.md), [metadata](vm-metadata.md), memory, [network](../../vpc/concepts/network.md#network), OS's, or application status.

{{ compute-name }} starts live migration in the following cases:
* Scheduled hardware maintenance and upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* OS configuration updates.
* Security updates.

## Limitations {#limitations}

The following types of VMs cannot be moved:
* VMs with [GPUs](../concepts/gpus.md)[^1].
* [Preemptible](../concepts/preemptible-vm.md)[^1] VMs.
* [{{ sf-full-name }}](../../functions/) VMs.
* Managed DBMS VMs with local SSDs.
* VMs with disabled migration.

[^1]: These VMs are dynamically moved after a [manual stop](../operations/vm-control/vm-stop-and-start.md#stop).