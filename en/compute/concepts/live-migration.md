---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Live migration

{{ compute-full-name }} uses a live migration mechanism that allows the service to move running VMs between physical servers without stopping or restarting them. Interruptions are usually less than 10 seconds long.

Live migration doesn't change any VM settings. The real-time migration process moves a running VM from one server to another in the same availability zone. This doesn't affect any VM properties, including internal and external IP addresses, metadata, memory, network, OS, or application status.

{{ compute-short-name }} starts live migration in the following cases:

* Scheduled hardware maintenance and upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* Changes in the OS configuration.
* Security updates.

## Restrictions {#limitations}

The following types of virtual machines can't be moved:

* Virtual machines with [GPUs](../concepts/gpus.md)*.
* [Preemptible](../concepts/preemptible-vm.md) virtual machines*.
* {{ sf-name }} virtual machines.
* Managed DBMS virtual machines with SSDs.
* Virtual machines running on an older version of QEMU.
* Virtual machines with migration disabled.

\* These VMs are dynamically moved after a [manual stop](../operations/vm-control/vm-stop-and-start.md#stop).