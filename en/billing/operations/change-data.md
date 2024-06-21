# Changing your billing account data

Billing account details can only be updated by the account owner: a user with the `billing.accounts.owner` role. For more information, see [Access control](../security/index.md).

The sequence of user actions depends on the type of update.

## Renaming a billing account {#change-name}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.dashboard.label_rename }}** at the top next to the account name.
   1. Enter a new name.
   1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.button_action-rename-account }}**.

{% endlist %}

## Updating payer details {#change-address}

You can use [Yandex Balance](https://balance.yandex.ru/) to update payer's contact details (e.g., email address or phone number) or add payment details (e.g., bank account):

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page.
   1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-info.company_label_edit_ru }}**. <br/>This will redirect you to [Yandex Balance](https://balance.yandex.ru/).
   1. Follow the Yandex Balance [guide](https://yandex.ru/support/balance/operations/change-data.html).

{% endlist %}

## Changing any details other than TIN {#change-details}

[Write a request](../qa/common.md) to {{ yandex-cloud }} support. In the request, specify the details to modify and the number of the [contract](../concepts/contract.md) and attach a copy of the certificate verifying these changes (signed and stamped with the company's seal).

## Changing a business or TIN {#change-legal-entity}

You cannot change a business or TIN in the billing account settings. If these details have changed:
1. [Create](create-new-account.md) a billing account with new details by selecting **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.person-type-company }}** as the payer type.
1. Wait until the billing account is activated to avoid downtime of resources.
1. Transfer all clouds from the old billing account to the new one. All you have to do is [link](pin-cloud.md) them to the new billing account.

##### See also

* [Change the payment method](change-payment-method.md)
* [Configuring notifications](budgets.md)