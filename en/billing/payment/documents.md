# Reporting documents for businesses and individual entrepreneurs

If, during the reporting period, you have used your funds to pay for {{ yandex-cloud }} services, then, depending on your tax residence, the reporting documents will be sent to you within seven business days after the end of the reporting period.
Soft and hard copies of a document are identical. To prepare your financial reports on time, you can use the number, amount, and date of the report from the email received.

{% list tabs group=residents %}


- Residents of Russia {#russia}

  Russian residents can:
  * Receive documents by way of [electronic document management](../concepts/edo.md) (EDM).
  * [Download documents in {{ billing-name }}](../operations/download-reporting-docs.md). 

  If you have used your personal account funds during the reporting period, a [report](../concepts/act.md) and a [tax invoice](../concepts/invoice.md) will be delivered to you as follows:
  1. Copies of the documents will be delivered to the email address specified in the payer's card in [Yandex Balance](https://balance.yandex.ru) within seven (7) business days after the end of the [reporting period](../concepts/reporting-period.md).
  1. By Russian Post to the postal address that you specified at the account registration.
  1. If you are connected to EDM (SBIS/Kontur), the following documents will be sent to you within seven (7) business days after the end of the reporting period: a unilateral report in PDF (non-formalized electronic document, NED) and XML (formalized electronic document, FED) formats and a tax invoice in UTD (universal transfer document) format with the SChF function (FED). In this case, the documents will not be sent to you by email or in original copies.
  1. If you use the bank transfer payment method, you can [download a payment invoice](../operations/pay-the-bill.md) in {{ billing-name }}. It is also sent to your [contact email address]({{ link-console-main }}/settings). If you pay for resources with a credit or debit card, you will receive a payment receipt to your [contact email address]({{ link-console-main }}/settings).
  
  **Reconciliation reports**
  To generate a reconciliation report, submit [a request](../operations/download-reporting-docs) in {{ billing-name }}. After your request is processed, the document will become available for download.

  You can download copies of your documents or request the original documents and the reconciliation report in your [Yandex Balance](https://balance.yandex.ru) account.

  {% include [billing.accounts.account](../../_includes/billing/accountant-role.md) %}


- Residents of Kazakhstan {#kazakhstan}

  1. If you have used your personal account funds during the reporting period, a copy of the completion report will be sent to the email address specified in the payer's card in [Yandex Balance](../concepts/reporting-period.md) within seven (7) business days after the end of the [reporting period](https://balance.yandex.ru). You can [download the completion report](../operations/download-reporting-docs.md) yourself in {{ billing-name }}.
  1. By courier service within the month following the reporting period, with all signatures and stamps, to the mailing address specified at the account registration.
  1. Electronic invoices (e-invoices) are transmitted to the Information System for Collection and Processing of E-invoices within 15 calendar days of the turnover date.
  1. On the first working day of each month, we [invoice](../concepts/bill.md) the customer via the [contact email address]({{ link-console-main }}/settings). The invoice includes total arrears.

  **Reconciliation reports**
  To generate a reconciliation report, submit [a request](../operations/download-reporting-docs) in {{ billing-name }}. After your request is processed, the document will become available for download.

- Non-residents of Russia and Kazakhstan {#nonresidents}

  1. If your account is in arrears, {{ yandex-cloud }} sends _payment details_ stating total arrears and service usage details for the reporting period to your [contact email address]({{ link-console-main }}/settings) on the first working day of each month.
  1. Within seven (7) business days after the end of the reporting period, {{ yandex-cloud }} sends an invoice for the amount of monthly consumption to the email address specified in [Yandex Balance](https://balance.yandex.ru).

  **Reconciliation reports**
  Reconciliation reports are generated upon [request to support]({{ link-console-support }}).

{% endlist %}