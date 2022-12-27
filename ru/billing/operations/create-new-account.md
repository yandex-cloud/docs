# Создать новый платежный аккаунт

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md). {% if product == "yandex-cloud" %}Для этого:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-type-step](../_includes/choose-type-step.md) %}

1. Заполните анкету:

   {% list tabs %}

    - Физическое лицо

       Укажите ваши фамилию, имя, отчество и привяжите банковскую карту:
       
         {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

    - Юридическое лицо или ИП

      7.1. Выберите способ оплаты (банковская карта или банковский перевод):
      - **Банковская карта**.
      <br/>Привяжите корпоративную банковскую карту:
      
        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note](../_includes/pin-card-note.md) %}

        {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **Банковский перевод**.
      
      7.2. Укажите юридическую информацию о вашей организации.

   {% endlist %}

1. Проверьте, что контактные данные заполнены корректно.

    {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

    {% include [account-roles](../_includes/account-roles.md) %}

{% endif %}

{% if product == "cloud-il" %}

{% list tabs %}

- Физическое лицо

  Чтобы создать платежный аккаунт:

   1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.

   1. Войдите в аккаунт Google, который используется для авторизации в {{ yandex-cloud }}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. На странице **Список аккаунтов** нажмите кнопку **Создать аккаунт**.

   1. Укажите имя платежного аккаунта. Имя будет отображаться в списке ваших платежных аккаунтов и поможет выбрать нужный.

   1. Чтобы добавить плательщика:

      * Выберите тип плательщика: **Физическое лицо**.
      * Укажите ваше имя и фамилию.
      * Укажите номер вашего Теудат-зеут и почтовый адрес.

   1. Привяжите банковскую карту.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      * В блоке **Банковская карта** нажмите **Привязать**.
      * Укажите данные карты: 16-значный номер, I.D. Number, срок действия и код CVV (с обратной стороны карты).
      * Нажмите **Pay now**.

      {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

      {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Укажите вашу актуальную почту. Контактные данные нужны не только для связи с вами, но и для выставления счетов и финансовых документов.

   1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

       {% include [account-roles](../_includes/account-roles.md) %}

- Юридическое лицо

  Чтобы создать платежный аккаунт:

   1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.

   1. Войдите в аккаунт Google, который используется для авторизации в {{ yandex-cloud }}.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

   1. На странице **Список аккаунтов** нажмите кнопку **Создать аккаунт**.

   1. Укажите имя платежного аккаунта. Имя будет отображаться в списке ваших платежных аккаунтов и поможет выбрать нужный.

   1. Чтобы добавить плательщика:

      * Выберите тип плательщика: **Юридическое лицо**.
      * Укажите название вашей организации, налоговый идентификационный номер и почтовый адрес.

   1. Привяжите банковскую карту.

      {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

      * В блоке **Банковская карта** нажмите **Привязать**.
      * Укажите данные карты: 16-значный номер, I.D. Number, срок действия и код CVV (с обратной стороны карты).
      * Нажмите **Pay now**.

      {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

      {% include [payment-card-validation](../../_includes/billing/payment-card-validation.md) %}

   1. Укажите вашу актуальную почту. Контактные данные нужны не только для связи с вами, но и для выставления счетов и финансовых документов.

   1. Подтвердите, что привязанная карта является корпоративной и вы уполномочены ею распоряжаться.

   1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

       {% include [account-roles](../_includes/account-roles.md) %}

{% endlist %}

{% endif %}