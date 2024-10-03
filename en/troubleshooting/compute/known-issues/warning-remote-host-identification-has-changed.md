# Fixing the "WARNING REMOTE HOST IDENTIFICATION HAS CHANGED" error


## Issue description {#issue-description}

When attempting to connect via SSH, you see this error: `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED`.

## Solution {#issue-resolution}

You need to verify that you are connecting to your server, after which you can delete the record pointing to the server's IP address from the `known_hosts` file:

```
ssh-keygen -f C:\User\Username/.ssh/known_hosts -R "00.000.00.000"
```

and reconnect to the VM with a static IP address `00.000.00.000`.

This error may occur if you previously created a VM, then deleted it, and created a new VM with the same static IP. In this case, SSH will be protected against man-in-the-middle attacks and communication channel compromise.
