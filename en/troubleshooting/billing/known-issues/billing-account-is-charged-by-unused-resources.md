# Funds for unused resources are debited from the billing account balance



## Issue description {#issue-description}

* Your billing account is debited for resources you created but no longer use.
* You need to stop or minimize debiting of funds from the billing account balance.

## Solution {#issue-resolution}

Check if there are active and/or billable resources in your cloud.
For example, if you stop a VM instance in Yandex Compute Cloud, you will no longer be billed only for the VM's computing resorces: vCPU cores and RAM. However, you will still be billed for the disks, images, and snapshots attached to your VM, as well as its reserved public IP addresses.

To understand which cloud products continue consuming your resources and balance, review the {{ yandex-cloud }} usage details. For this, go to the **By product** tab under **Details** [on your billing account page]({{ link-console-billing }}).
By reviewing your usage details, you can see which resources are still enabled and billed to you, and delete the unused resources.

If you are not planning to use {{ yandex-cloud }}, you can delete all your existing resources. To do this, delete all folders and clouds from your cloud organization. You can do it by following the guides for deleting [folders](../../../resource-manager/operations/folder/delete.md) and [clouds](../../../resource-manager/operations/cloud/delete.md).

When you delete the resources, you will no longer be charged for them.

{% note alert %}

Note that deleting folders and clouds is an irreversible operation.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
When creating a request, make sure to include the following information:

1. The ID of the billing account charged for unused resources.
   The billing account ID has the format: `d2nXXXXXXXXXXXXXXXXX`. You can find this ID on the [page with the billing account details](https://console.cloud.yandex.ru/billing/accounts).
2. Description of the problem (whether you have determined from the details which services and resources are still incurring charges, and whether the charges cease after you delete the resources).
