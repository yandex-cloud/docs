# Deleting a cloud


## Issue description {#case-description}

You need to delete a cloud.

## Solution {#case-resolution}

{% note info %}

The `resource-manager.clouds.owner` role is required to delete a cloud.

{% endnote %}

To delete a cloud in the management console:

1. Select the cloud from the list
2. Click **···** and select **Delete**
3. Choose the period after which the cloud will be deleted: select one of the possible periods, or click **Delete now**. The default cloud deletion period is seven days.
4. Click **Delete**.

After this, the resources will be stopped and the cloud will change to the `PENDING_DELETION` status. You can cancel the deletion of a cloud in the `PENDING_DELETION` status.

After the wait period expires, the cloud changes to the `DELETING` status. When a cloud has this status, it is being irreversibly deleted, which can take up to 72 hours.

For more information, see the [documentation](https://cloud.yandex.ru/docs/resource-manager/operations/cloud/delete).

## If nothing helped {#if-nothing-worked}

If the above actions did not help solve the task, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
Provide the following information in the request:

1. Cloud ID (displayed on the cloud page after selecting from the [list of organization's clouds](https://org.cloud.yandex.ru/services), has the format: `b1gXXXXXXXXXXXXXXXXX`).
2. ID of the cloud deletion operation ending with an error (for the currently selected cloud, it is located on the [page at this link](https://console.cloud.yandex.ru/cloud/?section=operations)).
