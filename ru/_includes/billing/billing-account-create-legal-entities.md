Чтобы создать платежный аккаунт:

1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}

   При создании организации укажите ее имя, например, `Example organization`. В организации будет автоматически создан новый каталог с именем `default`.
   
1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   В открывшемся окне:

   1. {% include [create-ba-choose-ul-step](../../billing/_includes/create-ba-choose-ul-step.md) %}
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}

      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. {% include [create-ba-import-egrul-step](../../billing/_includes/create-ba-import-egrul-step.md) %}
   1. Выберите **{{ ui-key.yacloud_billing_account.create-account.section_payment_method }}** — с помощью банковского перевода или привязанной банковской карты:

      От выбранного способа оплаты зависит размер [стартового гранта](../../billing/concepts/bonus-account.md) и [условия его использования](../../getting-started/usage-grant.md#business).

      * Выберите **{{ ui-key.yacloud_billing_account.create-account.label_payment_invoice }}**. После создания аккаунта вы получите письмо с инструкциями по верификации. До прохождения верификации платные ресурсы будут недоступны.

      * Привяжите корпоративную банковскую карту, которой вы уполномочены распоряжаться. Если к аккаунту пользователя уже привязаны банковские карты, вы можете выбрать одну из них, не добавляя новую.

        {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}
        
        {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}      

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

Если вы выбрали способ оплаты **{{ ui-key.yacloud_billing_account.create-account.label_payment_invoice }}** или если плательщик — нерезидент РФ и РК, вы получите письмо с описанием дальнейших действий на почту, указанную в аккаунте Яндекса или Яндекс 360. Вы также можете получить такое письмо в случае выбора способа оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}**, если после создания платежного аккаунта потребуется его верификация. После проверки документов ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.

Отправьте на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}) следующие документы:


* Копию протокола или решения о назначении генерального директора.
* Идентификатор [платежного аккаунта](../../billing/concepts/billing-account.md#billing-account-id) (billing account ID).



{% include [offices-and-foreign-companies](offices-and-foreign-companies.md) %}

