# Resolving connection issues with Kosmos VM



## Issue description {#issue-description}

You cannot connect to a VM created based on a Kosmos VM image.

## Solution {#issue-resolution}

Check if the Kosmos VM is pingable from other VM instances within the same cloud network, then try to connect to the SAC console and check the statuses of services.

If the SAC console on the affected VM is unavailable (when trying to connect to it, you see this message: `Unable to launch a Command Prompt. The service responsible for launching is not available`), follow these steps:

1. Create an image of the disk of the problematic VM.
1. Attach this image as a secondary disk to another VM based on the Kosmos image.
1. Run these commands in your command prompt:

```
        bcdedit /store <mountedvolume>\boot\bcd /ems {default} on
        bcdedit /store <mountedvolume>\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200
```

    Where `<mountedvolume>` is the letter of the secondary disk mounted to another VM booted from the Kosmos image.

1. Detach the secondary disk from the VM.
1. Create a VM using the modified image as a boot disk.
1. Connect to the newly created VM.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the VM.
1. The time range during which you tried to connect to the VM.
