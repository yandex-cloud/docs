# How to stop money withdrawals from the billing account


## Scenario description {#case-description}

You need to avoid debiting your billing account for unused resources.

## Solution {#case-resolution}

To understand which cloud products continue to consume your resources and balance, review the usage details in the **{{ ui-key.yacloud_billing.billing.account.detail.tab_product }}** tab on your account page.

If you stop your VM, you are no longer charged only for its computing resources: vCPU and RAM.
However, you will continue paying for VM-attached disks, generated snapshots and images.

Moreover, if you reserved an IP address, you will be charged regardless of whether the VM is running.
You can learn more about how VMs are charged from the [documentation section](../../../compute/pricing.md)

You can also erase all your resources at once by deleting all folders from all your clouds. You can do this only by yourself, using [this guide](../../../resource-manager/operations/folder/delete.md)
 This will stop all deductions.


## If nothing helped {#if-issue-still-persists}

If the above actions did not help, [create a request for technical support]({{ link-console-support }}).
When creating the request, make sure to specify:

1. Billing account ID.
   You can find this ID on the [page with billing account details]({{ link-console-support }}).
2. Problem description.
