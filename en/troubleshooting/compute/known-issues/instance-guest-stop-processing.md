# VM instance shuts down on the "instance guest stop processing" operation


## Issue description {#issue-description}

You see an operation ran by the `yc.compute.tf-compute-node-sa` user in the list of VM instance operations, with the description: `Instance guest stop processing`.

## Solution {#issue-resolution}

This operation indicates that the VM instance was removed from the guest operating system. You need to check the system log for events related to the shutdown.
