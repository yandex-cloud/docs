To create a billing account:

1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
1. {% include [create-ba-step2](../../billing/_includes/create-ba-step2.md) %}
1. {% include [create-ba-step3](../../billing/_includes/create-ba-step3.md) %}

   {% include [create-additional-ba-ui-notice](../../billing/_includes/create-additional-ba-ui-notice.md) %}

   In the window that opens:

   1. {% include [choose-name-step](../../billing/_includes/choose-name-step.md) %}
   1. {% include [choose-org-step](../../billing/_includes/choose-org-step.md) %}
   1. {% include [choose-country-step](../../billing/_includes/choose-country-step.md) %}
  
      {% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

   1. In the **{{ ui-key.yacloud_billing_account.create-account-wizard.field_person-type }}** field, select `Individual` and click **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. On the **{{ ui-key.yacloud_billing_account.create-account-wizard.label_step-individual_title }}** page, enter your last name and first name and click **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.
   1. Optionally, on the **{{ ui-key.yacloud_billing_account.create-account-wizard.label_step-payment_title }}** page, link your bank card to the new billing account:
   
      {% include [pin-card-data](pin-card-data.md) %}

      If the user account already has bank cards linked to it, you can select one of them without adding a new one.
  
      {% include [payment-card-types](payment-card-types.md) %}
  
      {% include [payment-card-validation](payment-card-validation.md) %}

      Your account will be created as a paid one: after you have used up your initial grant, your card will be debited for the {{ yandex-cloud }} resources you are using. 

      Once you are done adding your bank card, click **{{ ui-key.yacloud_billing_account.cloud-billing-account.label_wizard-next }}**.

      {% include [no-card](create-ba-without-card.md) %}

   1. {% include [create-ba-contacts-step](../../billing/_includes/create-ba-contacts-step.md) %}
   1. Click **{{ ui-key.yacloud.common.create }}**.

      {% note warning %}

      Note that for individuals an established verification procedure applies, which may result in the account activation being declined.
      
      {% endnote %} 