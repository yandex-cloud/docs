You can monitor VM instance statuses in the list of VMs in your folder.

{% note info %}

It usually takes up to 6 minutes to start a VM and initialize the RDP. In rare cases, loading may take much longer than the time specified. For example, when using:

* [VMs with less than 100% guaranteed vCPU performance](../compute/concepts/performance-levels).
* VMs that generate a load that exceeds the boot disk [IOPS limit](../compute/concepts/performance-levels).
* Network HDD drives with small storage capacity.

{% endnote %}        