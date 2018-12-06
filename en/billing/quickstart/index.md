# Getting started with Billing

[!INCLUDE [yandex-account](../_includes/yandex-account.md)]

To start using the Billing service:

- [Create a billing account](#create_billing_account)
- [Start exploring Yandex.Cloud](#start)

<a name="create_billing_account"></a>

### **Create a billing account** {#create_billing_account}

To create a [billing account](../concepts/billing-account.md):

1. Go to [Yandex.Cloud](https://cloud.yandex.com/).

1. Click **Console**.
<br/>You will be redirected to the Yandex.Cloud [management console](https://console.cloud.yandex.ru/billing).

1. Log in to Yandex:
    - If you are already logged in to Yandex or Yandex.Connect with your username and password, go to step 4.
    - If you are logged in to Yandex through a social network profile, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1) for your account, and then go to step 4.
    - If you are not logged in to Yandex or Yandex.Connect, click **Log in**. Then enter your username and password and click **Log in**.

1. Read and agree to the terms and conditions of the [Privacy Policy](https://yandex.ru/legal/confidential/?lang=en) and [Terms of Use](https://yandex.ru/legal/cloud_termsofuse/?lang=en).

1. Click **Create account** on the**List of accounts** page.

1. If your Yandex account is linked to your account in [Yandex.Balance](https://balance.yandex.com/), the **Payers** block will display a list of available [payers](../concepts/glossary.md). Select the appropriate one or go to step 7.

1. Enter the name for the new billing account.

1. Select the account type: **Individual account** or **Business account**.

1. Fill in the questionnaire:

   ---

    **[!TAB Individual account]**

     Link your bank card:
      - Click **Add card**.
      - Enter the bank card details: the 16-digit number, expiry date, and CVV (on the back of the card).
      - Click **Save**.

      [!INCLUDE [payment-card-types](../_includes/payment-card-types.md)]

      > [!NOTE]
      >
      > Funds from the linked card can only be debited after [activating the paid version](../operations/activate-commercial.md) and the use of Yandex.Cloud services.
      >
      
      [!INCLUDE [payment-card-validation](../_includes/payment-card-validation.md)]

    **[!TAB Business account]**

    9.1. Select a payment method:

    - **Bank card**.
<br/>Link your corporate bank card:
      - Click **Add card**.
      - Enter the bank card details: the 16-digit number, expiry date, and CVV (on the back of the card).
      - Click **Save**.

      [!INCLUDE [payment-card-types](../_includes/payment-card-types.md)]

      > [!NOTE]
      >
      > Linking a bank card is only necessary for creating a billing account. Funds from the associated card can only be debited after [activating the paid version](../operations/activate-commercial.md). At any time after creating a payment account, you can [change your payment method](../operations/change-payment-method.md).
      >

      [!INCLUDE [yandex-account](../_includes/payment-card-validation.md)]

    - **Bank transfer**.
<br/>After you click the **Create**  button (step 11), the payment account is created with the [Not verified](../concepts/billing-account.md#conditions) status. An email with further instructions will be sent to your email address specified in your Yandex or Yandex.Connect  account. It may take up to three business days to activate your payment account.

   9.2. Enter the legal details of your organization.

   ---

   > [!NOTE]
   >
   > Carefully fill in your contact information and payment details. This information is required not only to contact you, but also to issue bills and send financial documents.
   >

1. Read the agreement. If you agree to the terms and conditions, select ** I have read and accept the Terms**.

1. Click **Create**.

    > [!NOTE]
    >
    > Once you create a billing account, you are automatically assigned the _Owner_ role. You cannot change the owner or grant another user access to your billing account. For more information, see [Identity and access management](../security/index.md).
    >

<a name="start"></a>

### Get started {#start}

To start working with Yandex.Cloud, follow the instructions below:

   [!INCLUDE [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md)]

