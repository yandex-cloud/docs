---
title: Как изменить способ оплаты в {{ billing-name }}
description: Следуя данной инструкции, вы сможете изменить способ оплаты в {{ billing-name }}.
---

# Изменить способ оплаты

Изменить способ оплаты можно только в платежном аккаунте с типом **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}**. 

Чтобы изменить способ оплаты:

1. Составьте запрос на изменение способа оплаты.

   {% include [change-payment-docs](../_includes/change-payment-docs.md) %}

1. Отправьте запрос на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}). Запрос рассматривается в течение трех рабочих дней. Менеджер {{ yandex-cloud }} сообщит вам о принятом решении.

{% note info %}

При переходе на способ оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** ваша карта будет отвязана от платежного аккаунта и вы не сможете привязать новую карту. [Пополнять лицевой счет](../operations/pay-the-bill.md) можно будет только с помощью [перевода средств с расчетного счета (через банк)](../payment/payment-methods-business.md).

{% endnote %}
