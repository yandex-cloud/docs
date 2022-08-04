# Setting up a billing account

You need a {{ yandex-cloud }} billing account to pay your invoices for using {{ tracker-name }} if [full access](access.md) to the platform is granted to six or more users. Payments for the service are automatically debited from the billing account linked to {{ tracker-name }} on the first day of every month. To learn more about service plans and take a look at some examples of how to calculate monthly costs, see [Pricing policy](pricing.md).

You can find the FAQ for payments in [{#T}](payment.md).

## Linking a billing account to {{ tracker-name }} {#bind}

If you want to use paid features in {{ tracker-name }}, you first need to link a billing account. To do this, [follow the link]({{ link-bind-ba }}).

A window that prompts you to link your billing account to {{ tracker-name }} appears when you [grant full access](access.md#set) to a new user (if five of your employees already have full access) or when enabling [automatic full access](access.md#access-new-users) for all new users.

* If you already have a {{ yandex-cloud }} billing account, select it from the list and click **Link**.

* If you don't have a billing account yet, select **Create** and [add a new account](#create).

{% note warning %}

If the selected billing account has overdue payments or has been suspended, you won't be able to link it to {{ tracker-name }}. If this is the case, please go to the [{{ link-billing }}]({{ link-billing }}) page, select your account, and follow the prompts in the interface. After your billing account is re-activated, try linking it to {{ tracker-name }} again. You can read more about account statuses in the [{{ yandex-cloud }} billing](../billing/concepts/billing-account-statuses.md) documentation.

{% endnote %}

If you linked a billing account with an active trial period or created a new account, the paid version will be automatically activated for your account. This means that money can be debited from your account to pay for services {{ yandex-cloud }}. If you haven't used the starting grant yet, you will be able to use it after switching to the paid version. Read more about the starting grant in [Getting started in {{ yandex-cloud }}](../getting-started/index.yaml).

## Creating a billing account {#create}

1. Open [{{ tracker-name }} main page]({{ link-tracker }}) and [log in as an administrator](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Go to the **Account list** and click **Create an account**.

1. Select the payer's country of residency.

1. {% include [choose-name-step](../_includes/billing/choose-name-step.md) %}

1. If you have existing billing accounts, you can choose one of the available payers in the **Payers** section . To add a new payer, select **New payer**.

1. If you add a new payer:

   1. {% include [choose-type-step](../_includes/billing/choose-type-step.md) %}

   1. Enter your details or your organization's details.

   {% include [contacts-note](../_includes/billing/contacts-note.md) %}

1. For a legal entity or individual entrepreneur, choose a payment method (bank card or bank transfer).

1. If you are planning to pay for the service as an individual or selected payment by bank card for a legal entity or individual entrepreneur, link your bank card:

   {% include [pin-card-data](../_includes/billing/pin-card-data.md) %}

   {% include [payment-card-types](../_includes/billing/payment-card-types.md) %}

   {% note info %}

   Your funds will only be debited from the bank card after [you activate the paid version](#activate) and use the services {{ yandex-cloud }}.

   {% endnote %}

   {% include [payment-card-validation](../_includes/billing/payment-card-validation.md) %}

1. Click **Create**.

   {% note info %}

   By clicking **Create**, you accept [{{yandex-cloud}} offer]({{ link-cloud-oferta }}).

   {% endnote %}

   The created billing account will be assigned one of the follwoing [statuses](../billing/concepts/billing-account-statuses.md):

   * `NEW` — used for individuals residing in Russia or Kazakhstan (any payment method) or legal entities residing in Russia or Kazakhstan that pay using a  **Bank card**.

   * `PAYMENT_NOT_CONFIRMED` — used for individual entrepreneurs and companies residing in Russia or Kazakhstan that pay via **Bank transfer**, as well as companies residing outside of Russia and Kazakhstan (any payment method). You will receive an email outlining further steps you need to take to an address specified in your Yandex account. Billing account activation may take up to three business days.

   {% if audience == "draft" %}

   {% include [account-roles](../_includes/billing/account-roles.md) %}

   {% endif %}

After creating a billing account, [link it to {{ tracker-name }}](#bind). You can also use the starting grant to explore {{ yandex-cloud }} services if you haven't activated the trial period or purchased paid services before. Read more about the starting grant in [Getting started in {{ yandex-cloud }}](../getting-started/index.yaml).

{% if audience == "draft" %}
!!UPDATED LOGIC: now the account automatically tries to launch the paid version when linked!

## Activating the paid version of {#activate}

After creating a billing account, you can use the trial period and the grant to try out the {{ yandex-cloud }} services provided you haven't activated the trial period or purchased paid services before. You can read more about the trial period in [Getting started with {{ yandex-cloud }}](../getting-started/index.yaml).

You must activate the paid version in your account within 30 days after the trial period ends. Moreover, you have to activate the paid version if the trial version is unavailable for your account. Otherwise, the {{ tracker-name }} paid features will be unavailable to you.

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the**Account list** page.

1. Go to the **Overview** page and click **Upgrade to paid version**.

1. Enable the **I'm switching to the paid version** option and click **Upgrade to paid version** again to confirm your choice.

1. After activating the paid version, [top up your account balance](pay-the-bill.md). Now you can use your account to pay for {{ yandex-cloud }} services.

{% endif %}

## Editing your billing account {#edit}

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select the billing account you wish to edit on the**Account list** page.

   * To rename an account, click the ![image](../_assets/horizontal-ellipsis.svg)  icon and choose **Rename** in the section with the account name.

   * To link another bank card to pay with, find the **Bank card** section and click **Change bank card**.

   * To change the payment method for a legal entity or individual entrepreneur, contact [technical support]({{ link-tracker-support}}).

   * To change payer details, click **Edit in Yandex Balance** at the bottom of the page, then select the **Payers** section on the Yandex Balance page.

   {% note info %}

   To change the name of a legal entity or the TIN, [create a new billing account](#create).

   {% endnote %}

