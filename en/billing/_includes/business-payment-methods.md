Select a payment method:

  {% list tabs group=payments %}

  - Wire transfer {#transfer}

      Enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.popup-refill_button_company-action }}**.

      The system will generate a payment invoice. Print the invoice and use it to make a payment in a bank or using a banking client system.

      Before paying, please make sure the following is correct in your payment order:
      * Payment amount.
      * Banking details of Yandex.Cloud LLC (for Russia), Cloud Services Kazakhstan LLP (for Kazakhstan), Iron Hive doo Beograd (Serbia), or Direct Cursus Technology L.L.C. (Dubai) (for non-resients of Russia and Kazakhstan).

        {% include [legal-entity-nonresidents](../../_includes/billing/legal-entity-nonresidents.md) %}

      * Your company or individual entrepreneur TIN.
      * [Account number](../concepts/personal-account.md#id) in the payment purpose.
      * [Agreement number](../concepts/contract.md) in the payment purpose.

      [How fast the funds will be credited to your personal account](../payment/payment-methods-business.md#limits) depends on the bank performing the transaction.

      {% include [payment-bill-note](../../billing/_includes/payment-bill-note.md) %}

  - Credit or debit card {#card}

    Enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Then enter your card details and click **Pay**.

    {% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

    Your payment will be processed in real time and completed within 15 minutes.

  - SBP (Faster Payment System) {#sbp}

    {% include [payment-sbp-info](../../_includes/billing/payment-sbp-info.md) %}

    Enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**. Select the SBP top-up method and click **Pay via FPS**.
      
    Scan the QR code using your bank’s app and confirm the payment.
      
  {% endlist %}