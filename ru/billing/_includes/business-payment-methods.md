Выберите способ оплаты:

  {% list tabs group=payments %}

  - Банковский перевод {#transfer}

      Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.popup-refill_button_company-action }}**.

      Система сформирует счет для оплаты. Распечатайте счет и используйте его для оплаты в отделении банка или через систему клиент-банк.

      Перед проведением оплаты убедитесь, что в платежном поручении корректно указаны:
      * сумма платежа;
      * банковские реквизиты ООО «Яндекс.Облако» для Российской Федерации (РФ), ТОО «Облачные Сервисы Казахстан» для Республики Казахстан (РК), Iron Hive doo Beograd (Serbia) или Direct Cursus Technology L.L.C. (Dubai) для нерезидентов Российской Федерации и Республики Казахстан;

        {% include [legal-entity-nonresidents](../../_includes/billing/legal-entity-nonresidents.md) %}

      * ИНН вашей организации или ИП;
      * [номер лицевого счета](../concepts/personal-account.md#id) в назначении платежа;
      * [номер договора](../concepts/contract.md) в назначении платежа.

      [Сроки зачисления средств](../payment/payment-methods-business.md#limits) зависят от банка, проводящего платеж.

      {% include [payment-bill-note](../../billing/_includes/payment-bill-note.md) %}

  - Банковская карта {#card}

    Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Затем введите данные карты и нажмите кнопку **Оплатить**.

    {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

    Платеж происходит в режиме реального времени и зачисляется в течение 15 минут.

  - СБП (Система быстрых платежей) {#sbp}

    {% include [payment-sbp-info](../../_includes/billing/payment-sbp-info.md) %}

    Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Выберите способ пополнения баланса через СБП и нажмите кнопку **Оплатить СБП**.
      
    Отсканируйте QR-код с помощью приложения вашего банка и подтвердите платеж.
      
  {% endlist %}