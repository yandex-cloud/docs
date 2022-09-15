# Disaster recovery

#### What should I do if virtual machine disks have errors? {#disk-failure}

{% note warning %}

Don't try to restart your VM yourself. This may result in data loss.

{% endnote %}

If an attempt to access one or more disks of your VM returns an error:
1. [Create a new disk](../operations/disk-create/empty.md) and attach it to your VM.
1. Copy the critical data from damaged disks to the new disk. Make sure you don't use the [O_DIRECT](https://man7.org/linux/man-pages/man2/open.2.html) flag when reading files.
1. Once all the critical data is copied, detach the damaged disks from your VM and delete them.
1. If you fail to copy the data and need to recover the disk, [contact us]({{ link-console-support }}). We'll stop the VM on our own and check the disk integrity. This may take several days.