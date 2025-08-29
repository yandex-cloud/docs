Чтобы создать платежный аккаунт:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   В открывшемся окне:

   1. {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   1. {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}
  
      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-choose-ul-step](../../billing/_includes/create-ba-choose-ul-step.md) %}
   1. {% include [create-ba-choose-payment-method-step](../../billing/_includes/create-ba-choose-payment-method-step.md) %}
   1. Нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. {% include [create-ba-import-egrul-step](../../billing/_includes/create-ba-import-egrul-step.md) %}
   1. {% include [create-ba-ul-bank-card-step](../../billing/_includes/create-ba-ul-bank-card-step.md) %}

      {% include [no-card](create-ba-without-card.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}

      {% note info %}

      Если это ваш первый платежный аккаунт в {{ yandex-cloud }}, вам доступно подключение [пробного периода](../../billing/concepts/trial-period.md). После его завершения доступ к вашим ресурсам будет приостановлен. Для возобновления работы потребуется перейти на [платную версию](../../billing/operations/activate-commercial.md).

      {% endnote %}

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      Если вы выбрали способ оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** или если плательщик — нерезидент РФ и РК, вы получите письмо с описанием дальнейших действий на почту, указанную в аккаунте Яндекса или Яндекс 360. Вы также можете получить такое письмо в случае выбора способа оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}**, если после создания платежного аккаунта потребуется его верификация. После проверки документов ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.

      Отправьте на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}) следующие документы:

      
      * Копию протокола или решения о назначении генерального директора.
      * Идентификатор [платежного аккаунта](../../billing/concepts/billing-account.md#billing-account-id) (billing account ID).



{% include [offices-and-foreign-companies](offices-and-foreign-companies.md) %}
