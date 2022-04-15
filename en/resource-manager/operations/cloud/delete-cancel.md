# Canceling cloud deletion

This sections provides instructions on canceling cloud deletion if you previously [initiated deletion](delete.md) by mistake. See [{#T}](../../../billing/payment/billing-cycle.md) for information abut canceling deletion due to outstanding payments.

You can cancel deletion while a cloud's status is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

To be able to cancel the deletion of a cloud, you must have the `{{ roles-cloud-owner }}` role to the cloud. If you can't do this, please contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. Open the [management console]({{ link-console-main }}).

   1. Select a cloud from the list and click ![image](../../../_assets/options.svg) in the top right-hand corner of the page. In the menu that opens, select **Cancel deletion**.

{% endlist %}

The pending cloud deletion will be canceled.
