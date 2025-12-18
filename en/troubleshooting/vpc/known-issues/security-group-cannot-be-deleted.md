# Unable to delete a security group



## Issue description {#issue-description}

When trying to delete a security group, you get this error:
```
code = FailedPrecondition desc = Security group with id *** not empty
```

## Solution {#issue-resolution}

Before deleting a security group, disassociate it from the VM. To do this, follow these steps:

1. In the management console, go to **{{ ui-key.yacloud_components.services.service_compute }}**.
1. Select the target VM.
1. In the VM settings, scroll down to network.
1. Click ![***](../../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}** from the drop-down list.
1. Disassociate the security group.
1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
