# Link another bank card to your billing account

The owner of a billing account of the **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_individual }}** or **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}** type may link different bank cards to it.
A billing account may have only one bank card linked at the same time; however, you can change your card in the billing account settings.
Funds for the consumed resources will only be debited from the bank card specified on the billing account page.

{% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

{% note info %}

If the selected bank card expires, it will no longer be linked to your billing account. If you have already received a new bank card, add it or select one of the previously added bank cards. You can't change the details of a previously added bank card.

{% endnote %}

## Changing a bank card for payment {#change_card}

To set a different bank card:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. Under **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}**, click **{{ ui-key.yacloud_billing.billing.account.overview.card_label_edit }}**.
   1. Specify your card details: 16-digit number, expiration date, and CVV (you can find it on the back side of your card).
   1. Click **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

   {% include [yandex-account](../_includes/payment-card-validation.md) %}

{% endlist %}

## Deleting a bank card {#remove-card}

You can unlink a bank card only from an [inactive billing account](delete-account.md).
To delete a bank card from your account profile, please contact [support]({{ link-console-support }}).
