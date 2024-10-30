# Canceling cloud deletion


## Issue description {#case-description}

* The billing account owner received an email stating "Your cloud `b1gXXXXXXXXXXXXXXXXX` will be deleted on 20XX-XX-XX".
* The cloud is in the `PENDING_DELETION` state.

## Solution {#case-resolution}

You can manually cancel the deletion while the cloud is in the `PENDING_DELETION` state.

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

To be able to cancel the deletion of a cloud, you must have the `{{ roles-cloud-owner }}` role for the cloud. If you cannot perform this operation, contact the [cloud owner](../../../resource-manager/concepts/resources-hierarchy.md#owner).

{% list tabs %}

- Management console

   1. Open the [management console]({{ link-console-main }}).

   2. Select a cloud from the list and click ![***](../../../_assets/options.svg) in the top right-hand corner of the page. In the menu that opens, select **Cancel deletion**.

   The pending cloud deletion will be canceled.

- API

   Currently, you cannot cancel cloud deletion using the API.

{% endlist %}

To continue using resources in this cloud, resume your billing account. This [list of statuses and their causes](../../../billing/concepts/billing-account-statuses.md) will help you.

Check the [status of your billing account](https://console.cloud.yandex.com/billing) and activate it.

## If nothing helped {#if-nothing-worked}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).

Provide the following information in the request:

1. Cloud ID (displayed on the cloud page after selecting from the [list of organization's clouds](https://org.cloud.yandex.ru/services), has the format: `b1gXXXXXXXXXXXXXXXXX`).
2. ID of the cloud deletion operation ending with an error (for the currently selected cloud, it is located on the [page at this link](https://console.cloud.yandex.ru/cloud/?section=operations)).
