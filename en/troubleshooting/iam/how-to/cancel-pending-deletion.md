# How to cancel pending cloud deletion



## Case description {#case-description}

* The billing account owner received an email stating: `Your cloud b1g***************** will be deleted on **/**/20**`.
* The cloud is `PENDING_DELETION`.

## Solution {#case-resolution}

You can manually cancel the deletion while the cloud is `PENDING_DELETION`.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

To cancel the deletion of a cloud, you need the `{{ roles-cloud-owner }}` role for the cloud. If you cannot perform this operation, contact the [cloud owner](../../../resource-manager/concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

  1. Open the [management console]({{ link-console-main }}).
  1. Select the cloud from the list and click ![***](../../../_assets/options.svg) in the top right-hand corner of the page. In the menu that opens, select **{{ ui-key.yacloud.component.console-dashboard.button_cancel-deletion }}**.

  The pending cloud deletion will be canceled.

- API

  Currently, you cannot cancel cloud deletion using the API.

{% endlist %}

To continue using resources in this cloud, resume your billing account. [This list of statuses and their causes](../../../billing/concepts/billing-account-statuses.md) might help you. Check the [status of your billing account]({{ link-console-billing }}) and activate it.

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Cloud ID.
1. ID of the cloud deletion operation returning an error (for the selected cloud, you can find it on [this page]({{ link-console-cloud }}/?section=operations)).
