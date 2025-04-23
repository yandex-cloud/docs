
# General questions

#### I cannot log in to the partner portal. What should I do? {#login}

If you received a welcome email about being accepted into the program with a link to the [partner portal]({{ link-cloud-partners }}) but you cannot log in:

1. Make sure you are logged in with the Yandex ID that your billing account with the partner status is linked to.
1. Check that your billing account is activated and its status is `Active`.
    This status confirms that the paid version has been activated and there are no arrears for resource usage.
1. If necessary, top up your account. The minimum payment amount is shown at the time of payment in the **Top up account** window.

#### How to get the {{ yandex-cloud }} partner authorization letter? {#mail}

Send a request to [yc-partners@yandex-team.ru](mailto:yc-partners@yandex-team.ru) or your partner manager giving your company name, TIN, and the billing account of your company with the partner status.

#### How to change the login of the partner billing account owner? {#owner}

To change the account administrator:

1. Fill out the [application](https://disk.yandex.ru/i/vYSMw7adOHSHUA), sign it, and stamp it with your organization seal. Make sure the login specified in the application matches to the current account owner and the application signatory is authorized to sign it.
1. Send a scanned copy of the application and your partner billing account ID to [yc-partners@yandex-team.ru](mailto:yc-partners@yandex-team.ru) or to your partner manager.

{% note warning %}

You must [register](https://yandex.ru/support/id/authorization/registration.html) a new account on Yandex (Yandex ID) and must not use it for authorization in other Yandex services. You also need to log in and authorize with this Yandex ID in {{ yandex-cloud }} without creating new billing accounts.

{% endnote %}


#### Is {{ yandex-cloud }} listed in the Russian software registry? {#registry}

{{ yandex-cloud }} is [listed](https://reestr.digital.gov.ru/reestr/310636/?sphrase_id=583415) in the software register created pursuant to Article 12.1 of the Federal Law On Information, Information Technologies, and Information Protection under the basic class 02.05 "Software tools for cloud and distributed computing, visualization tools, and data storage systems" and additional classes 02.09 "Database management systems", 04.07 "Linguistic software", and 04.13 "Systems for collecting, storing, processing, analyzing, modeling, and visualizing datasets". The fact of the listing proves that {{ yandex-cloud }} and its individual services of the mentioned classes have been developed in Russia — potentially an advantage for organizations enforcing stricter requirements for the use of domestic software.

#### Do I need a license to sell {{ yandex-cloud }} services? {#license}

No, {{ yandex-cloud }} services fall under the definition of hosting services in the Information Act. According to the [clarification](https://rkn.gov.ru/it/control/p852/) of Roskomnadzor posted on the official website, hosting services are not communication services.


#### Why does the subaccount balance always equal zero? {#balance}

The partner is always invoiced for the [subaccount](../../partner/terms.md#sub-account) with the partner bonus deducted, so there is no need to top up your subaccount directly. The subaccount balance always equals zero, and its usage details change according to the services deployed under the subaccount.

#### Can I use any email address to create a subaccount? {#email}

No, only a Yandex account can be used to add a customer.

#### Why create a unique organization when creating a subaccount? {#org}

In {{ yandex-cloud }}, any cloud is owned by a single [organization](../../organization/quickstart.md). To avoid you and the customer adding each other to your organizations, you can link the cloud you make for your customer to a unique organization named `For subaccount 'Customer_name'` when creating it.

#### How to control customer expenses? {#expenses}

It is not possible to limit customer consumption to a certain amount. But you can [configure notifications](../../billing/operations/budgets.md) using [budgets](../../billing/concepts/budget.md) to control expenses.

#### How does my customer support work? {#support}

Each subaccount uses its own [technical support plan](../../support/pricing.md), so you can pick the one that suits you. This plan is independent of the partner account support plan and provided as a service.

#### How do I contact the {{ yandex-cloud }} partner program team? {#contacts}

You can ask your questions on grants or {{ yandex-cloud }} processes by contacting [support]({{ link-console-support }}) in the {{ yandex-cloud }} console. The support team will call in the partner program team if necessary.

You can ask your questions about the terms of the program or share your feedback at [yc-partners@yandex-team.ru](mailto:yc-partners@yandex-team.ru) or in the partner chat.
