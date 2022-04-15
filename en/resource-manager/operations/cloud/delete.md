# Deleting a cloud

To be able to delete a cloud, you must have the `{{ roles-cloud-owner }}` role to the cloud. If you can't do this, please contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the cloud from the list.
   1. Click ![image](../../../_assets/options.svg) and select **Delete**.
   1. Select a cloud deletion delay, after which the cloud will be deleted. Select one of the available delays or **Delete now**. The default cloud deletion delay is 7 days.
   1. Click **Delete**.

{% endlist %}

The resources will be stopped, and the cloud's status will change to `PENDING_DELETION`. You can [cancel](delete-cancel.md) the deletion of a cloud whose status is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

Once the delay ends, the cloud's status will change to `DELETING`. When a cloud has this status, it is being irreversibly deleted, which can take up to 72 hours.
