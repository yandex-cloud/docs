# Fixing connection issues with Kosmos VM


## Issue description {#issue-description}

* You cannot connect to a VM created based on a Kosmos VM image.

## Solution {#issue-resolution}

1. Check if the Kosmos VM is pingable from other VM instances within the same cloud network.
2. Try to connect to the SAC console and check the statuses of services.

If the SAC console on the problematic VM is unavailable (when trying to connect to it, you see the message: `Unable to launch a Command Prompt. The service responsible for launching is not available`), perform the following actions:

1. Create an image of the disk of the problematic VM.
2. Attach this image as a secondary disk to another VM based on the Kosmos image.
3. Run these commands in the ``command prompt``:

```
        bcdedit /store <mountedvolume>\boot\bcd /ems {default} on
        bcdedit /store <mountedvolume>\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200
```

    Where `<mountedvolume>` is the letter of the additional disk mounted to another VM based on the Kosmos image.

1. Detach the secondary disk from the VM.
2. Create a VM using the modified image as a boot disk.
3. Connect to the newly created VM.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the problem, create a [request for technical support]({{ link-console-support }}).
When creating the request, provide the following information:

1. ID of the VM.
2. The time range during which you tried to connect to the VM.
