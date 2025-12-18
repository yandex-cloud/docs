# Funds for unused resources are debited from the billing account



## Issue description {#issue-description}

* Your billing account is debited for resources you created but no longer use.
* You need to stop or minimize debiting of funds from the billing account.

## Solution {#issue-resolution}

Check if there are active or billable resources in your cloud. For example, if you stop a VM instance in {{ compute-name }}, you will no longer be charged only for the VM computing resources, i.e., vCPUs and *RAM*. However, you will continue paying for the disks attached to your VM, images, and snapshots, as well as its reserved public IP addresses.

To understand which cloud products continue consuming your resources and balance, check the {{ yandex-cloud }} usage details. To do this, go to the **{{ ui-key.yacloud_billing.billing.account.detail.tab_product }}** tab under **{{ ui-key.yacloud_billing.billing.account.detail.label_title }}** on your [billing account page]({{ link-console-billing }}).

Thus you will be able to see which resources are still active and charged for, and delete the ones you no longer use.

If you are not planning to use {{ yandex-cloud }}, you can delete all your resources. To do this, delete all folders and clouds from your cloud organization. You can do it by following our guides on deleting [folders](../../../resource-manager/operations/folder/delete.md) and [clouds](../../../resource-manager/operations/cloud/delete.md).

After deleting the resources, you will no longer be charged for them.

{% note alert %}

Please note that deleting folders and clouds is irreversible.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the billing account debited for unused resources. You can find it on the [page with the billing account details]({{ link-console-billing }}).
1. Description of the issue: for which services and resources you are still charged based on the usage details, and whether deleting the resources solves the issue.
