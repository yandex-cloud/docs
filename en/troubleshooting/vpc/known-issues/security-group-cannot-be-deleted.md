# Could not delete a security group



## Issue description {#issue-description}

You cannot delete the security group and see this error:
```
code = FailedPrecondition desc = Security group with id *** not empty
```

## Solution {#issue-resolution}

Before deleting a security group, detach it from the VM instance.

To do this:
1. In the management console, go to Compute Cloud.
2. Select the target VM instance.
3. In the VM settings, scroll down to the network settings.
4. Click on the **···** button and in the drop-down list, select **Change network interface**.
5. Detach the security group.
6. Click **Save**.
