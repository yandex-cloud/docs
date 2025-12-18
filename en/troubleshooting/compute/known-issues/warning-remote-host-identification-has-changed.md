# Fixing the `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED` error



## Issue description {#issue-description}

When attempting to connect over SSH, you get the `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED` error.

## Solution {#issue-resolution}

You need to verify that you are connecting to the correct server, and then delete the record pointing to the server IP address from the `known_hosts` file:

```
ssh-keygen -f C:\User\Username/.ssh/known_hosts -R "00.000.00.000"
```

Following these steps, you can reconnect to the VM with the `00.000.00.000` static IP address.

{% note info %}

This error may occur if you previously created a VM, deleted it, and then created a new VM with the same static IP address. This protects the SSH connection against man-in-the-middle attacks and communication channel compromise.

{% endnote %}