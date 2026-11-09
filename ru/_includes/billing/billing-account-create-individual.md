Чтобы создать платежный аккаунт:

1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}

   При создании организации укажите ее имя, например, `Example organization`. В организации будет автоматически создан новый каталог с именем `default`.

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   В открывшемся окне:

   1. В поле **{{ ui-key.yacloud_billing_account.create-account.section_account_type }}** выберите **Физическое лицо**.
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}

      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Выберите **{{ ui-key.yacloud_billing_account.create-account.section_payment_method }}** — с помощью привязанной банковской карты, пополнения вручную или [промокода](*promo-code):

      {% list tabs %}

      - Банковская карта
      
        Привяжите банковскую карту. Если к аккаунту пользователя уже привязаны банковские карты, вы можете выбрать одну из них, не добавляя новую.

        
        После привязки карты вам начислится [стартовый грант](../../billing/concepts/bonus-account.md), если ранее вы не пользовались сервисами {{ yandex-cloud }}. 

        {% include [bonus-account](bonus-account.md) %}

        {% include [no-card](create-ba-without-card.md) %}


        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}
                  
        {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

      - Пополнение вручную
      
        Выберите **{{ ui-key.yacloud_billing_account.create-account.label_option_card }}** — пополняйте баланс вручную по мере необходимости.
      
      - Промокод
      
        Выберите **{{ ui-key.yacloud_billing_account.create-account.button_has-promo-code }}** и введите промокод.
        
        После его успешной проверки будет создан аккаунт и на лицевой счет начислится сумма промокода. Вы можете использовать ее для оплаты ресурсов {{ yandex-cloud }}.

        Чтобы продолжить пользоваться сервисами {{ yandex-cloud }}, когда промокод будет израсходован, [привяжите](../../billing/operations/pin-card.md) к аккаунту банковскую карту и [пополните лицевой счет](../../billing/operations/pay-the-bill.md).

      {% endlist %}
   
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   {% note warning %}

   Обращаем ваше внимание, что в отношении клиентов-физических лиц применяется установленный порядок верификации, результатом которого может стать отказ в активации аккаунта.

   {% endnote %}