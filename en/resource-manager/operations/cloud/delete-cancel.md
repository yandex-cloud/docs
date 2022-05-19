# Canceling cloud deletion

This sections provides instructions on canceling cloud deletion if you previously [initiated deletion](delete.md) by mistake. Review the [{#T}](../../../billing/payment/billing-cycle.md) section for information on canceling deletion that is related to having an outstanding amount payable.

You can reverse a deletion while a cloud is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

To be able to cancel the deletion of a cloud, you must have the `{{ roles-cloud-owner }}` role to the cloud in question. If you are unable to do this, please contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. Open the [management console]({{ link-console-main }}).

   1. Select a cloud from the list and click ![***](../../../_assets/options.svg) in the top right-hand corner of the page. In the resulting menu, select **Cancel deletion**.

{% endlist %}

The pending cloud deletion will be reversed.
