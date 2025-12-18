# How to get a reconciliation report



## Case description {#case-description}

You need to get a reconciliation report for one or multiple closed reporting periods.

## Solution {#case-resolution}

Select your billing account type on the tab below:

{% list tabs %}

- Businesses and individual entrepreneurs

    You can generate and download a reconciliation report for one or multiple closed reporting periods under **{{ ui-key.yacloud_billing.billing.account.switch_acts }}** on the [billing account properties page]({{ link-console-billing }}).

    You can request a reconciliation report for the current month seven business days after the month ends.

    To request a reconciliation report:
    1. In the top-left corner of the management console, click ![image](../../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
    1. On the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page, select your billing account.
    1. Navigate to **{{ ui-key.yacloud_billing.billing.account.switch_acts }}**.
    1. Open the **{{ ui-key.yacloud_billing.billing.account.tab_reconciliation-reports-title }}** tab.
    1. Click **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}**. In the window that opens, select the period to generate the reconciliation report for and click **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report-short }}**.
    1. As soon as the request status changes to **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.value_completed }}**, the download button will appear in the **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.field_actions }}** column. Select **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-with-facsimile }}** or **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_download-without-facsimile }}**.

    {% note info %}

    If the **{{ ui-key.yacloud_billing.billing.account.switch_acts }}** section or **{{ ui-key.yacloud_billing.billing.account.reconciliation-reports.action_request-report }}** button is missing on the billing account management page, it means that your cloud account does not have the required roles. Request the `billing.accounts.viewer` role from the billing account owner.

    {% endnote %}

    You can also generate and download available reconciliation reports in [Yandex Balance](https://balance.yandex.com/reconciliations.xml).


    If you need a signed original document from Yandex Cloud, send the reconciliation report in two copies to the following address:

    * By post: Ul. Sadovnicheskaya, 82, bldg. 2, Moscow, Russia, 115035. You do not need to specify the recipient's full name.
    * By courier: Ul. Sadovnicheskaya, 82, bldg. 2, Moscow, Russia, 115035. Enter the building from ul. Sadovnicheskaya, between entrances 5 and 6 of the Aurora Business Center. The delivery reception desk is open from 9 am to 6 pm, GMT+3, Monday to Friday. Phone: +7 495 739-70-00 (press 1, then enter 7704 after the voice menu starts).

    Your copy will be signed and sent back to you.

    {% note alert %}

    According to our in-house procedures, all reconciliation reports shall be retained and shall only be signed after being signed by the counterparty. This measure is driven by the significant number of documents not returned by our counterparties and, given the scale of the company's document flow, it is the only way for us to mitigate risks associated with missing signed originals.

    {% endnote %}

- Individuals

    For individuals, downloading reporting documents is currently not available.
    
    Use the [usage details of your billing account](../../../billing/operations/check-charges.md) to get information about services consumed over one or several reporting periods.

{% endlist %}

## If nothing helped {#if-nothing-worked}

If the above tips did not help you solve the issue, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Number of the agreement you signed with Yandex Cloud (in `******/**` format) or your billing account ID. You can find it on the [page with the billing account details]({{ link-console-billing }}).
1. Your business taxpayer identification number or tax registration reason code.
