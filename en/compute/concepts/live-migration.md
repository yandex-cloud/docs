# Live migration

{{ compute-full-name }} uses a live migration mechanism that allows the service to move running VMs between physical servers without stopping or restarting them. Pauses don't usually exceed 10 seconds.

Live migration doesn't change any VM settings. The real-time migration process moves a running VM from one server to another in the same availability zone. This doesn't affect any VM properties, including internal and external IP addresses, metadata, memory, network, OS, or application status.

{{ compute-short-name }} starts live migration in the following cases:

* Scheduled hardware maintenance and upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* Changes in the OS configuration.
* Security updates.

## Limitations {#limitations}

The following types of virtual machines can't be moved:

* Virtual machines with [GPUs](../concepts/gpus.md)*.
* [Preemptible](../concepts/preemptible-vm.md) virtual machines*.
* {{ sf-name }} virtual machines.
* Managed DBMS virtual machines with local SSDs.
* Virtual machines with migration disabled.

\* These VMs are dynamically moved after a [manual stop](../operations/vm-control/vm-stop-and-start.md#stop).
