{% note info %}

{% include [agent-installation-timespan](../../../_includes/backup/agent-installation-timespan.md) %}

A policy is linked asynchronously after you create and initialize a VM, as well as install and configure a backup agent. This may take up to 10-15 minutes. As a result, the virtual machine will appear in the list of {{ backup-name }} VMs and in the list of VMs linked to the `weekly-backup` policy.

{% endnote %}

You can monitor the installation progress using the VM [serial port](../../../compute/operations/vm-info/get-serial-port-output.md) in the management console.