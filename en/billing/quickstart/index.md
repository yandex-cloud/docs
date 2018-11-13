# Getting started with Billing

[!INCLUDE [yandex-account](../_includes/yandex-account.md)]

To start using the Billing service:

- [Get a promo code](#get_promocode)
- [Activate the promo code](#activate_promocode)
- [Create a billing account](#create_billing_account)
- [Start exploring Yandex.Cloud](#start)

<a name="get_promocode"></a>

### **Get a promo code** {#get_promocode}

If you already have a [promo code](../concepts/promo-code.md) to access the Yandex.Cloud management console, [activate it](#activate_promocode). If you don't have a promo code, you can submit a request to get one:

1. Go to [Yandex.Cloud](https://cloud.yandex.com/).

1. Click **Connect**.

1. Enter your first and last name.

1. Enter your email address and phone number.

1. Click **Next**.

1. Follow the steps that correspond to your legal status:

      ---

      **[!TAB Individuals]**

      Select **Individual**.

      **[!TAB Businesses]**
      - Enter your company name.
      - Specify the company's website, city, and country.
      - Select the industry.

      ---    

1. Click **Next**.

1. Select the areas in which you plan to use Yandex.Cloud services.

1. Read and agree to the terms and conditions of the [Privacy Policy](https://yandex.ru/legal/confidential/?lang=en) and [Terms of Use](https://yandex.ru/legal/cloud_termsofuse/?lang=en).

1. Click **Send**.

Your request will be reviewed within two weeks. As soon as the decision is made, a Yandex.Cloud manager will contact you. If the decision is positive, the promo code will be sent to the email address specified in the request.

<a name="activate_promocode"></a>

### **Activate the promo code** {#activate_promocode}

1. Open the Yandex.Cloud [management console](https://console.cloud.yandex.ru/billing).

2. Log in to Yandex:
    - If you are already logged in to Yandex with your username and password, go to step 3.
    - If you are logged in to Yandex through a social network profile, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1) for your account, and then go to step 3.
    - If not, click **Log in**. Then enter your username and password and click **Log in**.

3. Activate the promo code:

    3.1. Enter your promo code.

    3.2. Click **Next**.
<br/>If the button is disabled, you need to link your phone number to your Yandex account. For more information, see the [Help](https://yandex.com/support/passport/authorization/phone.html) for the Yandex.Passport service.

      > [!NOTE]
      >
      > One [promo code](../concepts/promo-code.md) can only be linked to one Yandex.Passport account. The terms of use and the validity period are specified in the message containing the promo code. Please read the terms and conditions carefully before activating your promo code.

     The **List of accounts** page opens in the management console.

<a name="create_billing_account"></a>

### **Create a billing account** {#create_billing_account}

To create a [billing account](../concepts/billing-account.md):

1. Click **Create an account**.

2. If your Yandex account is linked to your account in [Yandex.Balance](https://balance.yandex.com/), the **Payers** block will display a list of available [payers](../concepts/glossary.md). Select the appropriate one or go to step 6.3.

3. Enter the name for the new billing account.

4. Select the account type: **Individual account** or **Business account**.

5. Fill in the questionnaire:

   ---

    **[!TAB Individual account]**

     Link your bank card:
      - Click **Add a card**.
      - Enter the bank card details: the 16-digit number, expiry date, and CVV (on the back of the card).
      - Click **Save**.

      [!INCLUDE [yandex-account](../_includes/payment-card-validation.md)]

      [!INCLUDE [payment-card-validation](../_includes/payment-card-validation.md)]

    **[!TAB Business account]**

    Enter your company's details:
     - The company name and its legal form (or sole proprietor's data).
     - Phone number.
     - Email address.
     - The physical and legal addresses of the business.
     - Information about taxpayer registration (TIN).
     - BIC.
     - Bank account number.
     - KPP code.

   ---     

     > [!NOTE]
     >
     > Carefully fill in your contact information and payment details. This information is required not only to contact you, but also to issue bills and send financial documents.

6. Read the agreement. If you agree to the terms and conditions, select **I have read and accept the Terms**.

7. Click **Activate**.

    > [!NOTE]
    >
    > Once you create a billing account, you are automatically assigned the _Owner_ role.
 You cannot change the owner or grant another user access to your billing account. For more information, see [Identity and access management](../security/index.md).

<a name="start"></a>

### **Get started** {#start}

To start working with Yandex.Cloud, follow the instructions below:

   [!INCLUDE [quickstart-all-no-billing](../../_includes/quickstart-all-no-billing.md)]

