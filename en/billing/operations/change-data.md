# Change your billing account data

Billing account details can only be updated by the account owner: a user with the `billing.accounts.owner` role. For more information, see [Access control](../security/index.md).

The sequence of user actions depends on the type of update.

## Renaming a billing account {#change-name}

You can rename your billing account both on the management console home page and in the Billing section:
1. Open the [management console]({{ link-console-main }}){{ yandex-cloud }}.
1. In the upper-left corner, click ![image](../../_assets/main-menu.svg) **All services**.
1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).
1. Select an account on the **List of accounts** page.
1. Go to the **Overview** page.
1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Rename** at the top next to the account name.
1. Enter a new name.
1. Click **Rename**.

## Change payer contact information {#change-address}

You can change the payer's contact information (for example, mailing address or phone number) in [Yandex Balance](https://balance.yandex.ru/):
1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.
1. Select an account on the **List of accounts** page.
1. Go to the **Overview** page.
1. Click **Edit data in Yandex Balance**. <br/>This redirects you to [Yandex Balance](https://balance.yandex.ru/).
1. Follow the [instructions in the Help](https://yandex.ru/support/balance/operations/change-data.html) for Yandex Balance.

## Changing billing details {#change-details}

[Write a request](../qa/common.md) to {{ yandex-cloud }} support. In the request, specify the details to modify and the number of the [contract](../concepts/contract.md) and attach a copy of the certificate verifying these changes (signed and stamped with the company's seal).

##### See also

* [Link another bank card](pin-card.md)
* [Unlink a card](unlink-card.md)
* [Change the payment method](change-payment-method.md)
* [Configuring notifications ](budgets.md)
