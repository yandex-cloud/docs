# View your expense history and download reporting documents through the console

Individuals, companies, and individual entrepreneurs can view their expense history. Companies and individual entrepreneurs that are residents of Russia or Kazakhstan can download reporting documents in the {{ yandex-cloud }} management console.

{% list tabs %}

- Businesses and individual entrepreneurs

  ## For businesses in Russia {#legal-entities-russia}

    Companies and individual entrepreneurs can download [reports](../concepts/act.md) and [invoices](../concepts/invoice.md) and request reconciliation reports.

    ### Download closing documents {#download-closing-docs}

    Reports and invoices are generated on the last day of the reporting period (month). The relevant documents will become available for download seven business days after the reporting period closes. Documents for previous reporting periods are also available in the management console.

    To download closing documents:
    1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
    1. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, select a billing account.
    1. Go to **{{ ui-key.yacloud.billing.account.switch_acts }}**.
    1. Open the **{{ ui-key.yacloud.billing.account.tab_acts-title }}** tab.
    1. In the line for the relevant reporting period, click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.billing.account.button_download-action }}**. A window will open showing the reporting documents for the selected period.
    1. To the right of a document, click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.common.open }}**. The document will open in a new browser tab and will be available for saving.

    ### Request a reconciliation report {#download-acts}

    To generate a reconciliation report, submit a request in the {{ yandex-cloud }} management console. Once your request is handled, the document will become available for download.

    You can request a reconciliation report for the current month seven business days after the month ends.

    To request a reconciliation report:
    1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
    1. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, select a billing account.
    1. Go to **{{ ui-key.yacloud.billing.account.switch_acts }}**.
    1. Open the **{{ ui-key.yacloud.billing.account.tab_reconciliation-reports-title }}** tab.
    1. Click **{{ ui-key.yacloud.billing.account.reconciliation-reports.action_request-report }}**. In the window that opens, select the period to generate the reconciliation report for and click **{{ ui-key.yacloud.billing.account.reconciliation-reports.action_request-report-short }}**.
    1. Once the request status changes to **{{ ui-key.yacloud.billing.account.reconciliation-reports.value_completed }}**, the download button will appear in the **{{ ui-key.yacloud.billing.account.reconciliation-reports.field_actions }}** column. Select **{{ ui-key.yacloud.billing.account.reconciliation-reports.action_download-with-facsimile }}** or **{{ ui-key.yacloud.billing.account.reconciliation-reports.action_download-without-facsimile }}**.
   1. Click the button with the selected download type. The document will open in a new window and become available for saving.

       To exchange original documents, download an unsigned report, print and sign two copies, and send them as follows:

       * By post, to: 115035, Russia, Moscow, 82/2, Sadovnicheskaya St.
          Put on the envelope <q>For Project Deals Support Group</q> without giving any employee names.

       * By delivery service, to: 115035, Russia, Moscow, 82/2, Sadovnicheskaya St.
          Enter the building from Sadovnicheskaya Street, between entrances 5 and 6 of the <q>Aurora</q> Business Center.
          The delivery reception desk is open from 9 am to 6 pm, GMT+3, Monday to Friday.
          To call the office phone number, dial +7 495 739-70-00, then press 1; once the voice menu is on, dial 7704.

       As soon as the documents are signed, you will be sent your copy.

    1. Click the button with the selected download type. The document will open in a new window and become available for saving.

  ## For businesses in Kazakhstan {#legal-entities-kazakhstan}

    ### Acceptance certificate {#report-of-completion}

    Companies and individual entrepreneurs that are residents of Kazakhstan can download acceptance certificates.

    Documents are generated on the last day of the reporting period (month). The relevant acceptance certificate will become available for download seven business days after the reporting period closes. Acceptance certificates for previous reporting periods are also available in the management console.

    To request an acceptance certificate:
    1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
    1. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, select a billing account.
    1. Go to **{{ ui-key.yacloud.billing.account.switch_acts }}**.
    1. Open the **{{ ui-key.yacloud.billing.account.tab_acts-title }}** tab.
    1. In the line for the relevant reporting period, click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.billing.account.button_download-action }}**. This will open a window showing the acceptance certificates for the selected period.
    1. To the right of a document, click ![image](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.common.open }}**. The document will open in a new browser tab and will be available for saving.

    ### Electronic invoice {#electronic-invoice}

    Electronic invoices (e-invoices) are transmitted to the [Information system for receiving and processing e-invoices](https://esf.gov.kz:8443/esf-web/login) within 15 calendar days of the turnover date.

    

- Individuals

  ## View your expense history {#expense-history}

  Individuals who are residents of  can view their monthly spending history in the {{ yandex-cloud }} management console.

  To view your expense history:
    1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
    1. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, select a billing account.
    1. Go to **{{ ui-key.yacloud.billing.account.switch_expences }}**.

  Individuals cannot download reporting documents.

{% endlist %}
