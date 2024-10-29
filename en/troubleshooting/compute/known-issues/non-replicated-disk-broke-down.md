# Fixing a non-replicable disk breakdown


## Issue description {#issue-description}

A non-replicable disk failure has occurred.

## Solution {#issue-resolution}

We do not recommend making a non-replicable disk bootable. If it fails, the VM instance may become inaccessible. It is impossible to recover data from such disks. In this case, we can recommend creating a new disk with the same parameters.

For added reliability, you can set up backup creation using specialized software. Additionally, you can set up a software RAID using OS tools to preserve data on your non-replicable disk.

Several non-replicable disks can be grouped into a placement group for redundant application-level data storage. In this case, individual disks are physically placed in different racks in a data center to minimize the risk of simultaneous failure of all disks in the group.

To learn more about disks, see the [documentation](https://cloud.yandex.ru/docs/compute/concepts/disk#nr-disks).