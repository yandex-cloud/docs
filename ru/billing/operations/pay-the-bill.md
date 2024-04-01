---
title: "Как пополнить лицевой счет"
description: "Следуя данной инструкции, вы сможете пополнить лицевой счет."
---

# Пополнить лицевой счет

{% include [personal-account-balance](../_includes/personal-account-balance.md) %}

{{ yandex-cloud }} оставляет за собой право автоматически списать средства с привязанной карты в течение текущего отчетного периода, если баланс вашего лицевого счета превысит установленный размер порога оплаты.

Способ пополнения лицевого счета зависит от вашего юридического статуса.

{% note info %}

Цикл оплаты выполняется автоматически для [физических лиц](../payment/billing-cycle-individual.md), а также для [организаций и ИП](../payment/billing-cycle-business.md), если к платежному аккаунту привязана банковская карта.

{% endnote %}

## Физическим лицам {#individuals}

Чтобы пополнить лицевой счет:

{% list tabs group=instructions %}

- Интерфейс {{ billing-name }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт.
  1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**.
  1. Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**.
  1. Введите данные карты и нажмите кнопку **Оплатить**.

{% endlist %}

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

Платеж происходит в режиме реального времени и зачисляется в течение 15 минут.

## Организациям и ИП {#legal-entities}


{% note info %}

Если ваша организация является представительством или филиалом иностранного юридического лица на территории РФ и вы впервые собираетесь пополнить лицевой счет, убедитесь, что вы отправили нам официальное [письмо](https://storage.yandexcloud.net/doc-files/offer-agreement.docx), подтверждающее ваше согласие с условиями [оферты](https://yandex.ru/legal/cloud_oferta/). Если это не так, пожалуйста, отправьте письмо через обращение в [техническую поддержку]({{ link-console-support }}). Это необходимо для выполнения требований законодательства РФ в области валютного регулирования.

{% endnote %}


Чтобы пополнить лицевой счет:

1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
1. Выберите платежный аккаунт.
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**.
1. Выберите способ оплаты:

  {% list tabs group=payments %}

   - Банковский перевод {#transfer}

     Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.popup-refill_button_company-action }}**.

     Система сформирует счет для оплаты. Распечатайте счет и используйте его для оплаты в отделении банка или через систему клиент-банк.

     Перед проведением оплаты убедитесь, что в платежном поручении корректно указаны:
     * сумма платежа;
     * банковские реквизиты ООО «Яндекс.Облако» для Российской Федерации (РФ), ТОО «Яндекс.Облако Казахстан» для Республики Казахстан (РК), Iron Hive doo Beograd (Serbia) для нерезидентов РФ и РК;
     * ИНН вашей организации или ИП;
     * [номер лицевого счета](../concepts/personal-account.md#id) в назначении платежа;
     * [номер договора](../concepts/contract.md) в назначении платежа.

     Сроки зачисления средств зависят от банка, проводящего платеж.

     {% include [payment-bill-note](../_includes/payment-bill-note.md) %}

  - Банковская карта {#card}

    Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**. Затем введите данные карты и нажмите кнопку **Оплатить**.

    {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

    Платеж происходит в режиме реального времени и зачисляется в течение 15 минут.

   {% endlist %}
