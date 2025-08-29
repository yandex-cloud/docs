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

   1. В поле **{{ ui-key.yacloud_billing_account.create-account-wizard.field_person-type }}** выберите `Физическое лицо` и нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. На странице **{{ ui-key.yacloud_billing_account.create-account-wizard.label_step-individual_title }}** укажите ваши фамилию и имя и нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. (Опционально) На странице **{{ ui-key.yacloud_billing_account.create-account-wizard.label_step-payment_title }}** привяжите вашу банковскую карту к создаваемому платежному аккаунту:
   
      {% include [pin-card-data](pin-card-data.md) %}

      Если к аккаунту пользователя уже привязаны банковские карты, вы можете выбрать одну из них, не добавляя новую.
  
      {% include [payment-card-types](payment-card-types.md) %}
  
      {% include [payment-card-validation](payment-card-validation.md) %}

      Ваш аккаунт будет создан с платным потреблением: после использования стартового гранта с карты начнут списываться средства за используемые ресурсы сервисов {{ yandex-cloud }}. 

      Закончив с добавлением банковской карты, нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.

      {% include [no-card](create-ba-without-card.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      {% note warning %}

      Обращаем ваше внимание, что в отношении клиентов-физических лиц применяется установленный порядок верификации, результатом которого может стать отказ в активации аккаунта.
      
      {% endnote %} 