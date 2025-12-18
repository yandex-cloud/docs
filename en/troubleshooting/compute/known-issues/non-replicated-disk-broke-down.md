# Fixing a non-replicated disk failure



## Issue description {#issue-description}

A non-replicated disk failed.

## Solution {#issue-resolution}

We do not recommend using a non-replicated disk as a boot disk. If it fails, the VM instance may become inaccessible, with further data recovery impossible.

For added reliability, you can set up backups using specialized software. Moreover, you can set up software RAID using OS tools to preserve data on your non-replicated disk.

{% note info %}

You can create a placement group with multiple non-replicated disks for redundant application-level data storage. In this case, individual disks will be physically placed in different racks in a data center to minimize the risk of simultaneous failure of all disks in the group.

{% endnote %}

For more information, see [this guide](../../../compute/concepts/disk.md#nr-disks).