# Setting up a billing account

You need a {{ yandex-cloud }} billing account to pay your invoices for using {{ tracker-name }} if [full access](access.md) to the platform is granted to six or more users. Your billing account linked to {{ tracker-name }} will be [debited monthly](pay-the-bill.md#charge) for using the service. To learn more about service plans and take a look at some examples of how to calculate monthly costs, see [Pricing policy](pricing.md).

You can find the FAQ for payments in [{#T}](payment.md).

Billing accounts are managed by an administrator. You can use your existing billing account from {{ yandex-cloud }} or create a new, dedicated, billing account for {{ tracker-name }}.

## Link a billing account {{ yandex-cloud }} {#bind}

If you use {{ yandex-cloud }} services and want to use the same billing account to pay for {{ tracker-name }} services, link this account to {{ tracker-name }}.

You cannot link billing accounts that have debts or are in the `Suspended` [status](../billing/concepts/billing-account-statuses.md).

If you link a billing account with a valid [trial period](../getting-started/free-trial/concepts/quickstart.md), the paid version will be automatically activated for it. The account will start getting debited after the initial grant is used up or the trial period expires.

To link a billing account:
1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).
1. Go to **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}**. The page shows all your billing accounts from {{ yandex-cloud }}.
1. Click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountList.bind }}** next to the relevant billing account.

## Create a billing account {#create}

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. Go to **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}** and click **+ {{ ui-key.startrek.ui_components_page-admin_BillingAccountList.create-account }}**.

1. Select the country that the payer is a resident of.

1. {% include [choose-name-step](../_includes/billing/choose-name-step.md) %}

1. If you already have billing accounts, you can select a payer under **{{ ui-key.yacloud_billing_account.cloud-billing-account.section_persons }}**. To add a new payer, select **{{ ui-key.yacloud_billing_account.cloud-billing-account.account_label_new }}**.

1. If you are adding a new payer:

   1. {% include [choose-type-step](../_includes/billing/choose-type-step.md) %}

   1. Enter your personal details or the details of your company.

   {% include [contacts-note](../_includes/billing/contacts-note.md) %}

1. For a legal entity or individual entrepreneur, select a payment method (a bank card or wire transfer). When selecting wire transfer, be ready to provide supporting documents. You will receive an email describing further actions.

1. If you are going to pay as an individual or selected paying by bank card as a legal entity or individual entrepreneur, link a bank card:

   {% include [pin-card-data](../_includes/billing/pin-card-data.md) %}

   {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

   {% note info %}

   Funds from the linked card can only be debited after you [activate the paid version](#activate) and start using the {{ yandex-cloud }} services.

   {% endnote %}

   {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

1. Click **{{ ui-key.startrek.ui_components_page-admin_BillingScreen.create-account }}**.

   {% note info %}

   By clicking **{{ ui-key.startrek.ui_components_page-admin_BillingScreen.create-account }}**, you accept the [{{ yandex-cloud }} offer]({{ link-cloud-oferta }}).

   {% endnote %}

   The billing account will be created with a [status](../billing/concepts/billing-account-statuses.md):

   * `NEW`: For individuals who are residents of Russia or Kazakhstan with any payment method and businesses that are residents of Russia or Kazakhstan with the **{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_card }}** payment method.

   * `PAYMENT_NOT_CONFIRMED`: For individual entrepreneurs and businesses that are residents of Russia or Kazakhstan with the **{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_invoice }}** payment method and for businesses that are non-residents of Russia and Kazakhstan with any payment method. An email with further instructions is sent to the email address specified in your Yandex account. It may take up to three business days to activate your billing account.


Once the billing account is created, [link it to {{ tracker-name }}](#bind). You can also use the initial grant to get familiar with the {{ yandex-cloud }} services, unless you activated the trial period or purchased paid services before. For more information about the initial grant, see [Getting started with {{ yandex-cloud }}](../getting-started/).


## Edit a billing account {#edit}

1. To open the billing account editing section, follow the [link](http://billing.cloud.yandex.ru/) to the {{ yandex-cloud }} **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}** section. All your billing accounts are listed on the page.

1. Select the billing account that you want to edit.

   * To rename the account, in the section with the account name, click ![image](../_assets/horizontal-ellipsis.svg) and select **Rename**.

   * To link a different bank card, click **{{ ui-key.yacloud.billing.account.overview.card_label_edit }}** under **{{ ui-key.yacloud.billing.account.overview.section_card }}**.

   * To change payment method for a legal entity or individual entrepreneur, contact [support]({{ link-tracker-support}}).

   * To change the payer data, at the bottom of the page, click **Edit in Yandex&#160;Balance**, then, on the balance page, select **{{ ui-key.yacloud.billing.account.create-new.section_persons }}**.

   {% note info %}

   To change the name or INN (TIN) of the legal entity, [create a new billing account](#create).

   {% endnote %}

## Changing a billing account {#change}

You can only change an organization's billing account once a month. To change a billing account:
1. Go to **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → **{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-billing }}**. The page displays the billing account linked to {{ tracker-name }}.
2. Click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.rebind-account }}** in the top-right corner. Select the billing account you want to use instead of the current one or click **+ {{ ui-key.startrek.ui_components_page-admin_BillingAccountList.create-account }}**.
   If you want to create a new account, follow [this guide](#create).

![](../_assets/tracker/changelogs/change-ba.png =690x)

You will switch over to the selected or created billing account at the beginning of next month.

{% note tip %}

Make sure you do not have any debts on your previous account after you switch to the new one.

{% endnote %}

