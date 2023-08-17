Log in using Yandex ID and go to the management console. Confirm the creation of your first cloud and go on to create your [billing account](../../billing/concepts/billing-account.md):
1. In the top-left corner of the management console, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}** and select [**{{ billing-name }}**]({{ link-console-billing }}).
1. On the **{{ ui-key.yacloud.billing.label_accounts }}** page, click **{{ ui-key.yacloud.billing.accounts.button_create }}**. Fill in your information:
   * Select the payer's country.
   * Specify the name of the billing account to be displayed in the list of billing accounts.
1. If the **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_persons }}** section shows a list of available payers, you can select one of them or add a new one.
1. To add a new payer, select **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_person-type }}**:
   * **Individual** is for residents of Russia or Kazakhstan.
   * **Legal entity or individual entrepreneur** is for residents and non-residents of Russia or Kazakhstan.

   For more information about the types of billing accounts and their limitations, see [Overview of billing accounts](../../billing/concepts/billing-account.md#ba-types).

   {% note info %}

   Under one user account, all payers must be either residents of Russia, residents of Kazakhstan, or residents of other countries.

   {% endnote %}