---
title: "Как создать новый платежный аккаунт в {{ billing-name }}"
description: "Следуя данной инструкции, вы сможете создать новый платежный аккаунт." 
---

# Создать новый платежный аккаунт

Участник любого облака может создать один или несколько [платежных аккаунтов](../concepts/billing-account.md). Для этого:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}

1. {% include [create-account-button-step](../_includes/create-account-button-step.md) %}

1. {% include [choose-country-step](../_includes/choose-country-step.md) %}

   {% include [billing-account-payers](../_includes/billing-account-payers.md) %}

1. {% include [choose-name-step](../_includes/choose-name-step.md) %}

1. {% include [choose-balance-payer](../_includes/choose-balance-payer.md) %}

1. {% include [choose-type-step](../_includes/choose-type-step.md) %}

1. Заполните анкету:

   {% list tabs group=customers %}

    - Физические лица {#individuals}

       Укажите ваши фамилию, имя, отчество и привяжите банковскую карту:
       
         {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note-2](../_includes/pin-card-note-2.md) %}

        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}

    - Юридические лица и ИП {#businesses}

      7.1. Выберите способ оплаты (банковская карта или банковский перевод):
      - **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_card }}**.
      <br/>Привяжите корпоративную банковскую карту:
      
        {% include [pin-card-data](../_includes/pin-card-data.md) %}

        {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

        {% include [pin-card-note](../_includes/pin-card-note.md) %}

        {% include [yandex-account](../_includes/payment-card-validation.md) %}
      - **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**.
      
      7.1. Укажите юридическую информацию о вашей организации.

   {% endlist %}

1. Проверьте, что контактные данные заполнены корректно.

    {% include [contacts-note](../_includes/contacts-note.md) %}

1. {% include [activate-button-step](../_includes/activate-button-step.md) %}

    {% include [account-roles](../_includes/account-roles.md) %}


