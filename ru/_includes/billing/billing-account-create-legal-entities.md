Чтобы создать платежный аккаунт:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}

1. Войдите в свой Яндекс ID или аккаунт в Яндекс 360. Если у вас еще нет аккаунта, [зарегистрируйтесь](https://yandex.ru/support/id/authorization/registration.html) и в сервисе [{{org-full-name}}]({{link-org-main}}) создайте [организацию](../../organization/quickstart.md), в которой вы будете работать. Если для входа на Яндекс вы используете профиль в социальной сети, [заведите логин и пароль](https://passport.yandex.ru/passport?mode=postregistration&create_login=1).

1. На странице **{{ ui-key.yacloud.billing.label_accounts }}** нажмите кнопку **Создать платёжный аккаунт**. Заполните данные:
   
   * {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   * {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   * {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}
   
     {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

1. Если в блоке **{{ ui-key.yacloud_billing_account.create-account-wizard.field_person-id }}** показан список доступных плательщиков, вы можете выбрать одного из них или добавить нового.

1. Выберите тип плательщика: **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.person-type-company }}**.

1. Выберите способ оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}** или **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**. В любой момент после создания платежного аккаунта вы можете [изменить способ оплаты](../../billing/operations/change-payment-method.md).

1. Нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**

1. Если вы выбрали способ оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}**:
   
   1. Укажите юридическую информацию о вашей организации и ваши контактные данные.
   
      {% include [contacts-note](contacts-note.md) %}
   
   1. Привяжите корпоративную банковскую карту:
   
      {% include [pin-card-data](pin-card-data.md) %}
      
      * Подтвердите, что карта является корпоративной и вы уполномочены ею распоряжаться.
      
      * Нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
      
      {% include [payment-card-types](payment-card-types-business.md) %}
      
      {% include [yandex-account](payment-card-validation.md) %}
   
   1. Укажите актуальные почту и телефон. Контактные данные нужны не только для связи с вами, но и для выставления счетов и финансовых документов. Если вы уже зарегистрированы в {{ yandex-cloud }}, проверьте правильность контактных данных.

1. Если вы выбрали способ оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**:
   
   1. Укажите юридическую информацию о вашей организации и ваши контактные данные.
   
   1. Укажите актуальные почту и телефон. Контактные данные нужны не только для связи с вами, но и для выставления счетов и финансовых документов. Если вы уже зарегистрированы в {{ yandex-cloud }}, проверьте правильность контактных данных.

1. Если это ваш первый платежный аккаунт в {{ yandex-cloud }}, вам доступно подключение пробного периода.
   
   * Подключая пробный период, помните, что после его завершения ваши ресурсы будут приостановлены. Для возобновления работы потребуется перейти на [платную версию](../../billing/operations/activate-commercial.md).
   * Если не подключать пробный период на данном этапе, ваш аккаунт будет создан с платным потреблением: после [использования стартового гранта](../../getting-started/usage-grant.md) вам не придется переходить на платную версию.

1. Нажмите кнопку **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**.

   Если вы выбрали способ оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}** или если плательщик — нерезидент РФ и РК, вы получите письмо с описанием дальнейших действий на почту, указанную в аккаунте Яндекса или Яндекс 360. Активация платежного аккаунта может занять до трех рабочих дней.

   
   {% include [offices-and-foreign-companies](offices-and-foreign-companies.md) %}

