# Change your billing account data

Billing account details can only be updated by the account owner: a user with the `billing.accounts.owner` role. For more information, see [Access control](../security/index.md).

The sequence of user actions depends on the type of update.

## Renaming a billing account {#change-name}

You can rename your billing account both on the management console home page and in the {{ billing-name }} service:
1. Open the [management console]({{ link-console-main }}){{ yandex-cloud }}.
1. In the top-left corner, click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
1. Select an account on the **{{ ui-key.yacloud.billing.label_accounts }}** page.
1. Go to the **{{ ui-key.yacloud.billing.account.switch_overview }}** page.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.billing.account.dashboard-resources.button_action-rename-account }}** at the top next to the account name.
1. Enter a new name.
1. Click **{{ ui-key.yacloud.billing.account.dashboard-resources.button_action-rename-account }}**.

## Updating payer details {#change-address}

You can use [Yandex Balance](https://balance.yandex.ru/) to update payer's contact details (e.g., email address or phone number) or add payment details (e.g., bank account):
1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/console-icons/dots-9.svg) and select **{{ billing-name }}**.
1. Select an account on the **{{ ui-key.yacloud.billing.label_accounts }}** page.
1. Go to the **{{ ui-key.yacloud.billing.account.switch_overview }}** page.
1. Click **{{ ui-key.yacloud.billing.account.dashboard-info.company_label_edit_ru }}**. <br/>This redirects you to [Yandex Balance](https://balance.yandex.ru/).
1. Follow the Yandex Balance [guide](https://yandex.ru/support/balance/operations/change-data.html).

## Changing any details other than TIN {#change-details}

[Write a request](../qa/common.md) to {{ yandex-cloud }} support. In the request, specify the details to modify and the number of the [contract](../concepts/contract.md) and attach a copy of the certificate verifying these changes (signed and stamped with the company's seal).

## Changing a business or TIN {#change-legal-entity}

You cannot change a business or TIN in the billing account settings. If these details have changed:
1. [Create](create-new-account.md) a billing account with new details by selecting **Business or individual entrepreneur** as the payer type.
1. Wait until the billing account is activated to avoid downtime of resources.
1. Transfer all clouds from the old billing account to the new one. All you have to do is [link](pin-cloud.md) them to the new billing account.

##### See also

* [Link another bank card](pin-card.md)
* [Change the payment method](change-payment-method.md)
* [Configuring notifications](budgets.md)