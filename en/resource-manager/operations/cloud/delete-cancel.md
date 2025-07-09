# Canceling cloud deletion

This section explains how to cancel cloud deletion if [initiated](delete.md) by mistake. You cannot cancel the deletion of a cloud linked to a billing account with the `SUSPENDED` status. For information about canceling deletion due to outstanding payments, see [Billing cycle for individuals](../../../billing/payment/billing-cycle-individual.md) and [Billing cycle for businesses and individual entrepreneurs](../../../billing/payment/billing-cycle-business.md).

You can cancel deletion while the cloud status is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

To be able to cancel the deletion of a cloud, you must have the `{{ roles-cloud-owner }}` role for the cloud. If you cannot perform this operation, contact the [cloud owner](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the appropriate cloud from the list on the left.
  
  1. In the upper-right corner, click ![***](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.component.console-dashboard.button_cancel-deletion }}**.

  The pending cloud deletion will be canceled.

- API {#api}

  Currently, you cannot cancel cloud deletion using the API.

{% endlist %}


