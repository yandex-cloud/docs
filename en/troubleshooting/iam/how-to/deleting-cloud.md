# How to delete a cloud



## Case description {#case-description}

You need to delete a cloud.

## Solution {#case-resolution}

{% note info %}

To delete a cloud, you need the `{{ roles-cloud-owner }}` role for that cloud.

{% endnote %}

To delete a cloud in the [management console]({{ link-console-main }}):

1. Select the cloud from the list.
1. Click ![***](../../../_assets/options.svg) and select **{{ ui-key.yacloud_components.cloud.button_delete }}**.
1. Specify the time frame after which the cloud will be deleted (select one of the suggested options) or click **{{ ui-key.yacloud_components.cloud.label_delete-now }}**. The default period is seven days.
1. Click **{{ ui-key.yacloud_components.cloud.button_delete }}**.

This will stop the resources and change the cloud status to `PENDING_DELETION`. You can cancel the deletion of the cloud while it is `PENDING_DELETION`.

Once the waiting timeout expires, the cloud status switches to `DELETING`. This status means it is being permanently deleted, which can take up to 72 hours.

For more information, see [this guide](../../../resource-manager/operations/cloud/delete.md).

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Cloud ID. You can find it on the cloud page that opens after you select the cloud from the [list of organization's clouds](https://org.yandex.cloud/services). It has the `b1g*****************` format.
1. ID of the cloud deletion operation returning an error. For the selected cloud, you can find it on [this page]({{ link-console-main }}/cloud/?section=operations).
