# Boot disk size failed to increase



## Issue description {#issue-description}

After increasing the boot disk size, it updated in the [management console]({{ link-console-main }}) but remained unchanged on the VM.

## Solution {#issue-resolution}

If the partition on the boot disk failed to expand automatically after increasing the disk size, use these commands:

```
bash
sudo mount -o size=10M,rw,nodev,nosuid -t tmpfs tmpfs /tmp
sudo growpart /dev/vda 2
sudo resize2fs /dev/vda2
df -h
sudo umount /tmp
```