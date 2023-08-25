# Purchase a committed volume of services (CVoS)

{% include [cvos-term](../_includes/cvos-term.md) %}

## To purchase a committed volume of services (CVoS) {#enable}

1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
1. Make sure your billing account consumption type is `{{ ui-key.yacloud.billing.account.overview.usage-type_label_paid }}`. For more information about activating the paid version, see [{#T}](activate-commercial.md).
1. Make sure your billing account has the `billing.accounts.owner`, `editor`, or `admin` role. For more information about roles, see [{#T}](../security/index.md).
1. Go to the **{{ ui-key.yacloud.billing.account.switch_offers }}** page.
1. Review the offers:
   1. Select a service and click the section with the new offer.
   1. Choose a platform.
   1. Use the service cost calculator: set the amount of resources and compare the cost when committing to 6 months and 1 year. Select the appropriate option.

      {% note warning %}

      You can reserve a maximum of 20 vCPUs and 40 GB RAM in a single step.

      {% endnote %}

1. Check the terms of the selected agreement.
1. Read the agreement. If you agree to the terms, check **By clicking <q>Confirm monthly payments</q>, I have read and accept the Terms**.
1. Click **{{ ui-key.yacloud.billing.cud.purchase.button_purchase }}**.

After purchasing the CVoS and starting from its start date, the discount on the use of services is applied automatically. For more information, see [{#T}](../concepts/cvos.md).
