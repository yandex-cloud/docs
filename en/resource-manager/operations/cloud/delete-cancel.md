# Canceling cloud deletion

This section provides instructions on canceling cloud deletion if you previously [initiated deletion](delete.md) by mistake. For information about canceling deletion due to outstanding payments, see [Billing cycle for individuals](../../../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../../../billing/payment/billing-cycle-business.md).

You can cancel deletion while a cloud's status is `PENDING_DELETION`.


{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}


To be able to cancel the deletion of a cloud, you must have the `{{ roles-cloud-owner }}` role to the cloud. If you can't do this, please contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. Open the [management console]({{ link-console-main }}).

   1. Select a cloud from the list and click ![***](../../../_assets/options.svg) in the top right-hand corner of the page. In the menu that opens, select **Cancel deletion**.

{% endlist %}

The pending cloud deletion will be canceled.
