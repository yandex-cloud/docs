---
title: Как пополнить лицевой счет
description: Следуя данной инструкции, вы сможете пополнить лицевой счет.
---

# Пополнить лицевой счет

{% include [personal-account-balance](../_includes/personal-account-balance.md) %}

{{ yandex-cloud }} оставляет за собой право автоматически списать средства с привязанной карты в течение текущего отчетного периода, если баланс вашего лицевого счета превысит установленный размер порога оплаты.

{% include [initial_payment](../../_includes/billing/initial-payment-amount.md) %}

Способ пополнения лицевого счета зависит от вашего юридического статуса.

{% note info %}

Цикл оплаты выполняется автоматически для [физических лиц](../payment/billing-cycle-individual.md), а также для [организаций и ИП](../payment/billing-cycle-business.md), если к платежному аккаунту привязана банковская карта.

{% endnote %}

Пополнить счет можно в сервисе {{ billing-name }} или в виджете консоли управления.

Пополнение счета доступно пользователям со следующими ролями:

* `billing.accounts.owner` на [платежном аккаунте](../security/index.md#set-role) для пополнения лицевого счета с помощью банковской карты.
* `billing.accounts.editor` или выше на [платежном аккаунте](../security/index.md#set-role) для пополнения лицевого счета с помощью лицевого счета.
* `resource-manager.clouds.member` или выше на [облако](../../resource-manager/operations/cloud/set-access-bindings.md) для пополнения лицевого счета из консоли управления.

## Физическим лицам {#individuals}

Чтобы пополнить лицевой счет:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
  1. В открывшемся окне введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
  1. {% include [individual_payment_methods](../_includes/individual-payment-methods.md) %}

- Консоль управления {#console}

    1. Откройте [консоль управления]({{ link-console-main }}).
    1. В правом верхнем углу нажмите ![credit-card](../../_assets/console-icons/credit-card.svg).
    1. В открывшемся виджете нажмите **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.

        {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}
    1. В открывшемся окне введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
    1. {% include [individual_payment_methods](../_includes/individual-payment-methods.md) %}

{% endlist %}

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

Платеж происходит в режиме реального времени и зачисляется в течение 15 минут.

## Организациям и ИП {#legal-entities}


{% note info %}

Если ваша организация является представительством или филиалом иностранного юридического лица на территории РФ и вы впервые собираетесь пополнить лицевой счет, убедитесь, что вы отправили нам официальное [письмо](https://storage.yandexcloud.net/doc-files/offer-agreement.docx), подтверждающее ваше согласие с условиями [оферты]({{ billing-oferta-url }}). Если это не так, пожалуйста, отправьте письмо через обращение в [техническую поддержку]({{ link-console-support }}). Это необходимо для выполнения требований законодательства РФ в области валютного регулирования.

{% endnote %}


Чтобы пополнить лицевой счет:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Выберите платежный аккаунт.
    1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Эта кнопка доступна только после [перехода на платное потребление](activate-commercial.md).
    1. {% include [business_payment_methods](../_includes/business-payment-methods.md) %}
  
- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. В правом верхнем углу нажмите ![credit-card](../../_assets/console-icons/credit-card.svg).
  1. В открывшемся виджете нажмите **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Эта кнопка доступна только после [перехода на платное потребление](activate-commercial.md).

      {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}
  1. {% include [business_payment_methods](../_includes/business-payment-methods.md) %}

{% endlist %}
