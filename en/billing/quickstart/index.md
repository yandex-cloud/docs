# Getting started with Billing

{% include [yandex-account](../_includes/yandex-account.md) %}

To start using the Billing service:

- [Create a billing account](#create_billing_account)
- [Start exploring Yandex.Cloud](#start)


### Create a billing account {#create_billing_account}

To create a [billing account](../concepts/billing-account.md):

1. Go to [Yandex.Cloud](https://cloud.yandex.com/).

1. Click **Console**.

   You will be redirected to the Yandex.Cloud [management console](https://console.cloud.yandex.ru).

1. Log in to Yandex:
    - If you are already logged in to Yandex or Yandex.Connect with your username and password, go to step 4.
    - If you are logged in to Yandex through a social network profile, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1) for your account, and then go to step 4.
    - If you are not logged in to Yandex or Yandex.Connect, click **Log in**. Then enter your username and password and click **Log in**.

1. Read and agree to the terms and conditions of the [Privacy Policy](https://yandex.ru/legal/confidential/?lang=en) and [Terms of Use](https://yandex.ru/legal/cloud_termsofuse/?lang=en).

1. In the management console, click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.

1. Click **Create account** on the **List of accounts** page.

1. If your Yandex account is linked to your account in [Yandex.Balance](https://balance.yandex.com/), the **Payers** block will display a list of available [payers](../concepts/glossary.md). Select the appropriate one or go to step 7.

1. Enter the name for the new billing account.

1. Select the account type: **Individual account** or **Business account**.

1. Fill in the questionnaire:

    {% list tabs %}

    - Individual account
  
       Enter your full name and link your bank card:
        - Click **Add card**.
        - Enter the bank card details: the 16-digit number, expiry date, and CVV (on the back of the card).
        - Click **Link**.
  
        {% include [payment-card-types](../_includes/payment-card-types.md) %}
  
        {% note info %}
  
        Funds from the linked card can only be debited after [activating the paid version](../operations/activate-commercial.md) and the use of Yandex.Cloud services.
  
        {% endnote %}
  
        {% include [payment-card-validation](../_includes/payment-card-validation.md) %}
  
    - Business account
  
      10.1. Select a payment method:
      - **Bank card**.<br/>Link your corporate bank card:
        - Click **Add card**.
        - Enter the bank card details: the 16-digit number, expiry date, and CVV (on the back of the card).
        - Click **Link**.
  
        {% include [payment-card-types](../_includes/payment-card-types.md) %}
  
        {% note info %}
  
        Linking a bank card is only necessary for creating a billing account. Funds from the associated card can only be debited after [activating the paid version](../operations/activate-commercial.md). At any time after creating a billing account, you can [change your payment method](../operations/change-payment-method.md).
  
        {% endnote %}
  
        {% include [yandex-account](../_includes/payment-card-validation.md) %}
  
      - **Bank transfer**.<br/>After you click the **Activate** button (step 11), the billing account is created with the [Not verified](../concepts/billing-account.md#conditions) status. An email with further instructions will be sent to the email address specified in your Yandex or Yandex.Connect account. It may take up to three business days to activate your billing account.
  
      10.2. Enter the legal details of your organization.
  
    {% endlist %}

    {% note info %}

    Carefully fill in your contact information and payment details. This information is required not only to contact you, but also to issue payment invoices and send financial documents.

    {% endnote %}

1. Read the agreement. If you agree to the terms and conditions, select **I have read and accept the Terms**.

1. Click **Activate**.

    {% note info %}

    Once you create a billing account, you are automatically assigned the _Owner_ role. You cannot change the owner or grant another user access to your billing account. For more information, see [Access management](../security/index.md).

    {% endnote %}


### Get started {#start}

To start working with Yandex.Cloud:

   {% include [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md) %}
