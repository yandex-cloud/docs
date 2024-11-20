# Регистрация

Для доступа к [кабинету партнера Marketplace]({{ link-cloud-partners }}) необходим пользовательский аккаунт. Это может быть Яндекс ID или аккаунт Яндекс 360. Пользовательский аккаунт должен иметь [платежный аккаунт](../../billing/concepts/billing-account.md#ba-types) юридического лица — резидента РФ или РК. {{ marketplace-name }} не сотрудничает с физическими лицами и нерезидентами РФ или РК. 

{% note info %}

Если вы используете имеющийся платежный аккаунт для расчетов за потребление сервисов {{ yandex-cloud }}, рекомендуем вам завести новый платежный аккаунт для того же пользователя.

{% endnote %}

Если у вас уже есть пользовательский аккаунт, войдите в консоль управления и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):

1. Убедитесь, что к вашему пользовательскому аккаунту привязан актуальный номер телефона.
1. В консоли управления перейдите в раздел [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}).
1. На странице **{{ ui-key.yacloud_billing.billing.title_accounts }}** нажмите кнопку **{{ ui-key.yacloud_billing.billing.accounts.main-banner_button_create }}**. Заполните данные:
   * Выберите страну плательщика.
   * Укажите имя платежного аккаунта, которое будет отображаться в списке платежных аккаунтов.
1. Если в блоке **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_persons }}** показан список доступных плательщиков, вы можете выбрать одного из них или добавить нового.
1. Для добавления нового плательщика выберите **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_person-type }}** — `Юридическое лицо или ИП`.
   
   * Выберите способ оплаты: `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}` или `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}`. В любой момент после создания платежного аккаунта вы можете [изменить способ оплаты](../../billing/operations/change-payment-method.md).
   * Укажите юридическую информацию о вашей организации.
   
     {% include [billing-note](../../_includes/marketplace/billing-note.md) %}
   
   * Если вы выбрали способ оплаты `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}`, привяжите корпоративную банковскую карту:
   
     {% include [pin-card-data](../../_includes/billing/pin-card-data.md) %}
   
      * Подтвердите, что карта является корпоративной и вы уполномочены ею распоряжаться.
   
     {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}
   
     {% include [yandex-account](../../_includes/billing/payment-card-validation.md) %}
   
   * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   Если вы выбрали способ оплаты `{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}`, вы получите письмо с описанием дальнейших действий на почту, указанную в пользовательском аккаунте. После проверки документов ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.