# Live migration

{{ compute-name }} uses the live migration feature that allows you to move running [VMs](vm.md) across physical servers without stopping or restarting them. The downtime usually does not exceed 10 seconds.

Live migration does not change any VM settings. The live migration process moves a running VM from one server to another in the same [availability zone](../../overview/concepts/geo-scope.md). This does not affect any VM properties, including [internal and external IP addresses](../../vpc/concepts/address.md), [metadata](vm-metadata.md), memory, [network](../../vpc/concepts/network.md#network), OSs, or application status.

{{ compute-name }} starts live migration in the following cases:
* Scheduled hardware maintenance and upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* OS configuration updates.
* Security updates.

## Limitations {#limitations}

Live migration is not supported for:

* VMs with [GPUs](../concepts/gpus.md) ^1^
* VMs with the `RESTART` [maintenance policy](../concepts/vm-policies.md) ^1^
* [Preemptible](../concepts/preemptible-vm.md) VMs ^2^
* Managed DBMS VMs with local SSDs
* VMs on dedicated hosts with [local SSDs](../concepts/dedicated-host.md#resource-disks)
* VMs on dedicated hosts [attached to a specific host](../concepts/dedicated-host.md#bind-vm)

^1^ When under maintenance, these VMs stop and get restarted on a new server.
^2^ When under maintenance, these VMs stop.


## See also {#see-also}

* [VM maintenance policies](./vm-policies.md)
* [How to move a VM to a different availability zone](../operations/vm-control/vm-change-zone.md)
* [How to move a VM to another folder](../operations/vm-control/vm-change-folder.md)
* [How to move a VM to another cloud](../operations/vm-control/vm-change-cloud.md)
