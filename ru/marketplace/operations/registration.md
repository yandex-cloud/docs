# Регистрация

Для доступа к [кабинету партнера Marketplace]({{ link-cloud-partners }}) необходим пользовательский аккаунт. Это может быть Яндекс ID или аккаунт Яндекс 360. Пользовательский аккаунт должен иметь [платежный аккаунт](../../billing/concepts/billing-account.md#ba-types) юридического лица — резидента Российской Федерации или Республики Казахстан. {{ marketplace-name }} не сотрудничает с физическими лицами и нерезидентами Российской Федерации или Республики Казахстан. 

{% note info %}

Если вы используете имеющийся платежный аккаунт для расчетов за потребление сервисов {{ yandex-cloud }}, рекомендуем вам завести новый платежный аккаунт для того же пользователя.

{% endnote %}

Если у вас уже есть пользовательский аккаунт, создайте [платежный аккаунт](../../billing/concepts/billing-account.md):

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

      {% include [billing-note](../../_includes/marketplace/billing-note.md) %}

   1. {% include [create-ba-ul-bank-card-step](../../billing/_includes/create-ba-ul-bank-card-step.md) %}
   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   Если вы выбрали способ оплаты `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}`, вы получите письмо с описанием дальнейших действий на почту, указанную в пользовательском аккаунте. После проверки документов ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.