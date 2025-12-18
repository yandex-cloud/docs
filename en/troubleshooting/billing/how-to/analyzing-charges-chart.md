# How to stop funds being debited from the billing account



## Case description {#case-description}

You need to stop funds being debited from your billing account for unused resources.

## Solution {#case-resolution}

To understand which cloud products continue consuming your resources and balance, check the usage details in the **{{ ui-key.yacloud_billing.billing.account.detail.tab_product }}** tab on your account page.

If you stop your VM instance, you will no longer be charged only for its computing resources: vCPUs and RAM.
However, you will continue paying for disks attached to the VM instance, as well as for snapshots and images you created.

Moreover, if you reserved an IP address, you will be charged for it regardless of the VM state. To learn more about the VM instance pricing, see [Compute Cloud pricing policy](../../../compute/pricing.md).

You can also remove all your resources at once by deleting all folders from all your clouds. You can only do this manually by following [this guide](../../../resource-manager/operations/folder/delete.md). This will stop all charges.

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Billing account ID. You can find it on the [page with the billing account details]({{ link-console-support }}).
1. Issue description.
