To create a billing account:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}

1. Log in to your Yandex ID or Yandex 360 account. If you do not have an account yet, [sign up](https://yandex.ru/support/id/authorization/registration.html) and create an [organization](../../organization/quickstart.md) in [{{ org-full-name }}]({{ link-org-cloud-center }}) for you to work in. If you use a social network profile to log in to Yandex, [create a username and password](https://passport.yandex.com/passport?mode=postregistration&create_login=1).

1. On the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page, click **Create billing account**. Fill in your information:

   * {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   * {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   * {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}

     {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

1. If you see a list of available payers in the **{{ ui-key.yacloud_billing_account.create-account-wizard.field_person-id }}** section, you can select one of them or add a new one.

1. Select the **Legal entity or individual entrepreneur** payer type.

1. Select the **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** payment method.

1. Click **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.


1. Enter the legal information of your organization and your contact details.

1. Enter your current email address and phone number. Contact details are required not only to reach you but also to issue payment invoices and send financial documents. If you have already signed up for {{ yandex-cloud }}, check that your contact details are correct.


1. If this is your first {{ yandex-cloud }} billing account, you are eligible for a [trial period](../../billing/concepts/trial-period.md). After it expires, the access to your resources will be suspended. To resume operation, you will need to switch to the [paid version](../../billing/operations/activate-commercial.md).

1. Click **{{ ui-key.yacloud.common.create }}**.


   Further instructions will be emailed to you at the address specified in your Yandex or Yandex 360 account. Once your documents have been verified, you can activate your billing account and start using {{ yandex-cloud }}.


   Email the following documents to [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}):
   * Copy of the minutes or resolution on the appointment of the general director
   * [Billing account](../../billing/concepts/billing-account.md#billing-account-id) ID

