# Изменить способ оплаты

Изменить способ оплаты можно только в платежном аккаунте с типом **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}**. 

Чтобы изменить способ оплаты:

1. Составьте запрос на изменение способа оплаты.

   В запросе должны содержаться:
   
   {% list tabs group=customers %}
   
   - Юридические лица {#businesses}
   
     * Полное название организации.
     * Копия протокола или решения о назначении генерального директора.
     * Идентификатор [платежного аккаунта](../concepts/billing-account.md) (billing account ID).
   
   - ИП {#entrepreneurs}
   
     * Скан-копия листа записи [ЕГРИП](https://egrul.nalog.ru/index.html) или уведомления о постановке на учет физического лица в качестве ИП в налоговом органе.
     * Идентификатор [платежного аккаунта](../concepts/billing-account.md) (billing account ID).
     
   {% endlist %}

1. Отправьте запрос на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}). Запрос рассматривается в течение трех рабочих дней. Менеджер {{ yandex-cloud }} сообщит вам о принятом решении.

{% note info %}

При переходе на способ оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** ваша карта будет отвязана от платежного аккаунта и вы не сможете привязать новую карту. [Пополнять лицевой счет](pay-the-bill.md) можно будет только с помощью [перевода средств с расчетного счета (через банк)](../payment/payment-methods-business.md).

{% endnote %}