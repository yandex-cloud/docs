# Questions about the billing account

#### How do I get the billing account ID? {#account-id}

To get your billing account ID:

{% include [billing-account-id](../../_includes/billing/billing-account-id.md) %}

#### How many billing accounts can I create? {#account-amount}

{% include [billing-account-amounts](../../billing/_includes/billing-account-amounts.md) %}

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### How many clouds can I link to my billing account? {#clouds-amount}

{% include [pin-cloud-note](../../billing/_includes/pin-cloud-note.md) %}

#### How do I transfer a cloud to a different billing account? {#cloud-transfer}

To transfer your cloud to a different billing account, just [link](../../billing/operations/pin-cloud.md) it to this account. This automatically unlinks the cloud from its current account. To avoid entering into arrears, top up the personal account in the billing account that the cloud was transferred from.

#### I created a new billing account, but it's blocked. Why? {#blocked-account}

It's most likely that you previously created a billing account that activated the trial period. Your billing account received the initial grant during the trial period. Since the initial grant can only be given to one billing account, you cannot use the trial period during re-registration. As a result, your new billing account is created with the `SUSPENDED` status.
To unblock your new billing account, [activate the paid version](../../billing/operations/activate-commercial.md) and [top up your personal account](../../billing/operations/pay-the-bill.md) for the minimum amount (the minimum amount is shown in the **Top up account** window).

#### How do I change my billing account type? {#account-type}

You can't change a billing account type once it's created, but you can [create a new one](../../billing/operations/create-new-account.md).

#### How do I enable the billing threshold? {#credit}

The [billing threshold](../../billing/concepts/billing-threshold.md) is enabled automatically after the [paid version is activated](../../billing/operations/activate-commercial.md) and the first reporting period ends.


{% include [change-payment-method](../../billing/_includes/change-payment-method.md) %}


#### How can I change my payment details or the delivery address? {#change-email}

{% include [change-address](../../billing/_includes/change-address.md) %}


#### I didn't receive an email with instructions on what to do after creating a billing account with the Bank transfer payment method. Why? {#account-notification}

It may take up to three business days to activate your billing account.
If you didn't receive an email within that period, send a request to: [cloud_docs@support.yandex.ru](mailto:cloud_docs@support.yandex.ru).

{% include [change-payment-docs](../../billing/_includes/change-payment-docs.md) %}


#### I can't link a bank card when creating a billing account. What should I do? {#cant-create}

The service most likely doesn't support the payment system of your bank card.

To resolve the issue, try linking a different bank card or, if you are a business owner, create a billing account with the **Business account** type and **Bank transfer** payment method.

#### Why do I get the error "The country is not available to the payer" when creating a billing account? {#account-error}

Most likely you have logged in under a Yandex account already linked to a payer with a different residence status.

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

To create a billing account with a payer being a resident of a different country, log in using a different Yandex ID or under a different Yandex 360 account.

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### How do I change the billing account owner? {#account-owner}

You cannot change the billing account owner. If you still need this, a new owner may [create a billing account](../../billing/operations/create-new-account.md) and [link](../../billing/operations/pin-cloud.md) clouds with all their resources to this billing account.
