# Live migration

{{ compute-full-name }} uses the live migration feature that allows you to move running VMs across physical servers without stopping or restarting them. The downtime usually does not exceed 10 seconds.

Live migration does not change any VM settings. The live migration process moves a running VM from one server to another in the same availability zone. This does not affect any VM properties, including internal and external IP addresses, metadata, memory, network, OS's, or application status.

{{ compute-short-name }} starts live migration in the following cases:

* Scheduled hardware maintenance and upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* Changes in the OS configuration.
* Security updates.

## Limitations {#limitations}

The following types of virtual machines cannot be moved:

* Virtual machines with [GPUs](../concepts/gpus.md)*.
* [Preemptible](../concepts/preemptible-vm.md)* virtual machines.
* {{ sf-name }} virtual machines.
* Managed DBMS virtual machines with local SSDs.
* Virtual machines with disabled migration.

\* These VMs are dynamically moved after a [manual stop](../operations/vm-control/vm-stop-and-start.md#stop).
