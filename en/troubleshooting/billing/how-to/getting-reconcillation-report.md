# How to get a reconciliation report


## Scenario description {#case-description}

You need to obtain a reconciliation report for one or more closed reporting periods.

## Solution {#case-resolution}

Select your billing account type on the tab below:

{% list tabs %}

- Businesses and individual entrepreneurs

   You can generate and download a reconciliation report for one or more closed reporting periods by going to the **{{ ui-key.yacloud_billing.billing.account.switch_acts }}** section on the [billing account properties page]({{ link-console-billing }})

   You can request a reconciliation report for the current month seven business days after the month ends.

   To request a reconciliation report:
   1. In the top-left corner of the management console, click ![image](../../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
   2. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, select a billing account.
   3. Go to **{{ ui-key.yacloud_billing.billing.account.switch_acts }}**.
   4. Open the **{{ ui-key.yacloud_billing.billing.account.tab_reconciliation-reports-title }}** tab:
   5. Click **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}**. In the window that opens, select the period to generate the reconciliation report for and click **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report-short }}**.
   6. Once the request status changes to **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.value_completed }}**, the download button will appear in the **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.field_actions }}** column. Select **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-with-facsimile }}** or **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-without-facsimile }}**.

   {% note info %}

   If the **{{ ui-key.yacloud_billing.billing.account.switch_acts }}** section or **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}** button is missing on the billing account management page, it means that your cloud account is missing relevant roles.
   Request the `billing.accounts.viewer` role from the billing account owner.

   {% endnote %}

   You can also generate and download available reconciliation reports in [Yandex Balance](https://balance.yandex.ru/reconciliations.xml)

   If you need a signed original document from , please send the reconciliation report in two copies to the following address:



   Your copy will be signed and sent back to you.

   {% note alert %}

   According to our company's internal document workflow, reconciliation reports must be kept and signed only after they are signed by the counterparty. This decision is dictated by the high level of non-return of documents from counterparties and, considering the volume of the company's document workflow, it is the only way for us to mitigate risks associated with the absence of signed originals.

   {% endnote %}

- Individuals

   For individuals, downloading reporting documents is currently not available.
   Use the [usage details of your billing account](../../../billing/operations/check-charges.md) to get information about services consumed over one or several reporting periods.

{% endlist %}

## If nothing helped {#if-issue-still-persists}

If the above recommendations did not help to solve the task, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
Provide the following information in the request:

1. Contract number with  (in the `XXXXXX/XX` format) or the ID of the billing account. You can find this ID on the [page with billing account details]({{ link-console-support }}).
2. Your organization's Taxpayer Identification Number (TIN)/Tax Registration Reason Code (KPP).
