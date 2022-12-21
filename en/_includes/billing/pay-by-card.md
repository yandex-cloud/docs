Funds are automatically debited from the bank card linked to the billing account at the beginning of the next reporting month if the total debited amount is greater than zero.

 {% note info %}

 {{ yandex-cloud }} reserves the right to automatically debit funds during the current reporting period if your account balance exceeds the established [billing threshold](../concepts/billing-threshold.md).

 {% endnote %}

{% if region == "ru" %}

The payment is usually transferred within 15 to 20 minutes. In accordance with Russian Federal Law No. [FZ-54 "On the use of cash registers"](http://base.garant.ru/12130951/), you will be sent a [payment receipt](../concepts/individual-bill.md) by email. We recommend that you keep payment receipts, but even if you delete them, you can [view your payment history](../operations/check-bill-history.md).

{% endif %}

{% if region == "kz" %}

The payment is usually transferred within 15 to 20 minutes. You can track payment execution in your [payment history](../operations/check-bill-history.md).

{% endif %}

If you do not have enough funds on your bank card on the day when funds are to be debited, the debit transaction will be repeated later. If the funds cannot be debited within one day, they may be debited from one of the bank cards linked to your Yandex account.

