# View your payment history

You can view the full history of payments to your [personal account](../concepts/personal-account.md#balance) on the **{{ ui-key.yacloud.billing.account.switch_history }}** page or in [Yandex Balance](https://yandex.com/support/balance/operations/find-bill.html). The tracking method depends on your legal status ([billing account type](../concepts/billing-account.md#ba-types)).


{% list tabs group=customers %}

- Businesses and individual entrepreneurs {#businesses}

  Businesses and individual entrepreneurs can track their full payment history in Yandex Balance on the [Invoices](https://balance.yandex.com/invoices.xml) page.

- Individuals {#individuals}

   Individuals can view the full history of payments on the **{{ ui-key.yacloud.billing.account.switch_history }}** page.

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select a billing account.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **{{ ui-key.yacloud.billing.account.switch_history }}**.

   <br/>All payments are arranged chronologically, the earliest payment being displayed at the very bottom.
   <br/>To filter the payments, set the date range. The results will be shown in a table.



   <br/>The payment history contains aggregate data on all services. Detailed information about the services rendered is available on the [Usage details](../operations/check-charges.md) page.

{% endlist %}


