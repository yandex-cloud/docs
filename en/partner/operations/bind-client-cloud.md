# Linking or moving a customer's cloud to a partner sub-account

In this section, you'll learn how to link a cloud to a partner sub-account or move it to a customer account.

## Linking a cloud {#bind}

You can link the customer's cloud to the partner sub-account from the partner and customer's console.

{% list tabs %}

- Partner console

   1. Go to the **Billing** tab, select the customer's account, and log in to it.
      <screenshot of the **Billing** tab with a list of accounts>
   1. Click **Link cloud**.
   1. Select the cloud you need from the drop-down list. The desired cloud may not be on the list if:
      * Too little time has passed since the role was assigned to the partner in the client console.
      * You need to change the role for this cloud.


- Customer console

   To use the customer console to move a cloud from the customer's account to the partner's sub-account:
   1. Click ![image](../../_assets/options.svg) in the partner subaccount.
   1. Select **Link cloud**.
   1. Select the cloud to link.

   To prevent the partner from linking a customer's cloud on their own, revoke the roles for resources from the partner. Learn more about [roles in {{ yandex-cloud }}](../../resource-manager/security/).

{% endlist %}

## Moving a cloud {#move}

{% list tabs %}

- Customer console

   To move a cloud from the partner's sub-account to the customer's account:
   1. In the customer console, click ![image](../../_assets/options.svg) in your account.
   1. Select **Link cloud**.
   1. Select the cloud to move to your account.

{% endlist %}