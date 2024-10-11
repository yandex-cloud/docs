Чтобы создать платежный аккаунт:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}

1. Войдите в свой Яндекс ID или аккаунт в Яндекс 360. Если у вас еще нет аккаунта, [зарегистрируйтесь](https://yandex.ru/support/id/authorization/registration.html) и в сервисе [{{ org-full-name }}]({{ link-org-cloud-center }}) создайте [организацию](../../organization/quickstart.md), в которой вы будете работать. Если для входа на Яндекс вы используете профиль в социальной сети, [заведите логин и пароль](https://passport.yandex.ru/passport?mode=postregistration&create_login=1).

1. На странице **{{ ui-key.yacloud_billing.billing.title_accounts }}** нажмите кнопку **Создать платёжный аккаунт**. Заполните данные:
  
   * {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   * {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   * {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}
  
     {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

1. Если в блоке **{{ ui-key.yacloud_billing_account.create-account-wizard.field_person-id }}** показан список доступных плательщиков, вы можете выбрать одного из них или добавить нового. Чтобы добавить плательщика:
  
   * Выберите тип плательщика: **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.person-type-invididual }}** и нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   * Укажите ваше имя и фамилию.
   * (Опционально) Укажите отчество и почтовый адрес.
   * Нажмите кнопку **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
  
   {% include [pin-card-data](pin-card-data.md) %}
  
   {% include [payment-card-types](payment-card-types.md) %}
  
   {% include [payment-card-validation](payment-card-validation.md) %}

   Ваш аккаунт будет создан с платным потреблением: после использования стартового гранта с карты начнут списываться средства за используемые ресурсы сервисов {{ yandex-cloud }}. 

1. Укажите актуальные почту и телефон. Контактные данные нужны не только для связи с вами, но и для выставления счетов и финансовых документов. Если вы уже зарегистрированы в {{ yandex-cloud }}, проверьте правильность контактных данных.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.