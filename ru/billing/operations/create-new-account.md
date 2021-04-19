# Создать новый платежный аккаунт

{% if region == "ru" %}

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md). Для этого:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. {% include [choose-type-step](../_includes/choose-type-step.md) %}

1. Заполните анкету:

   {% list tabs %}

    - Физическое лицо

       Укажите ваши ФИО и привяжите банковскую карту:
       
         {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../_includes/payment-card-types.md) %}

        {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

    - Юридическое лицо или ИП

      7.1. Выберите способ оплаты (банковская карта или банковский перевод):
      - **Банковская карта**.
      <br/>Привяжите корпоративную банковскую карту:
      
        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../_includes/payment-card-types.md) %}

        {% include [pin-card-note](../_includes/pin-card-note.md) %}

        {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **Банковский перевод**.
      
      7.2. Укажите юридическую информацию о вашей организации.

   {% endlist %}

   {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [contract-step](../_includes/contract-step.md) %}

1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

    {% include [account-roles](../_includes/account-roles.md) %}

{% endif %}

{% if region == "kz" %}

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md). Для этого:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. Выберите тип плательщика: **Юридическое лицо или ИП**.
   
   {% note info %}

   Доступ для физических лиц появится в ближайшее время.

   {% endnote %}

1. Заполните анкету:

   {% list tabs %}

    - Юридическое лицо или ИП

      7.1. Выберите способ оплаты (банковская карта или банковский перевод):
      - **Банковская карта**.
      <br/>Привяжите корпоративную банковскую карту:
      
        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../_includes/payment-card-types.md) %}

        {% include [pin-card-note](../_includes/pin-card-note.md) %}

        {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **Банковский перевод**.
      
      7.2. Укажите юридическую информацию о вашей организации.

   {% endlist %}

   {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [contract-step](../_includes/contract-step.md) %}

1. Нажмите кнопку **Активировать**.
   
   Платежный аккаунт будет создан в одном из [статусов](../concepts/billing-account-statuses.md):
   * `NEW` — для юридических лиц-резидентов РФ или РК со способом оплаты **Банковская карта**.
   * `PAYMENT_NOT_CONFIRMED` — для ИП и организаций, являющихся резидентами РФ или РК, со способом оплаты **Банковский перевод**, и организаций-нерезидентов РФ и РК с любым способом оплаты. На почту, указанную в аккаунте Яндекса или Яндекс.Коннекта, будет отправлено письмо с описанием дальнейших действий. Активация платежного аккаунта может занять до трех рабочих дней.

    {% include [account-roles](../_includes/account-roles.md) %}
    
{% endif %}