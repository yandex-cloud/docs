# Live migration

{{ compute-full-name }} uses a live migration mechanism that allows the service to move running VMs between physical servers without stopping or restarting them. Interruptions are usually less than 10 seconds long.

Live migration doesn't change any VM settings. The real-time migration process moves a running VM from one server to another in the same availability zone. This doesn't affect any VM properties, including internal and external IP addresses, metadata, memory, network, OS, or application status.

{{ compute-short-name }} starts live migration in the following cases:

* Scheduled technical maintenance and hardware upgrades.
* Unscheduled maintenance in the event of failed hardware, including CPUs, NICs, and power supply units.
* OS, BIOS, and firmware updates.
* Changes in the OS configuration.
* Security updates.

{% note info %}

Live migration isn't available for VMs with a [GPU](../concepts/gpus.md) or [preemptible](../concepts/preemptible-vm.md) VMs. They need to be [stopped](../operations/vm-control/vm-stop-and-start.md#stop) to be migrated.

{% endnote %}

