# Linking a cloud to a subaccount

If the customer has previously used {{ yandex-cloud }} resources and has an existing [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), you can link this cloud to your partner subaccount. Make sure to do this only after confirming partnership; otherwise, cloud resources may be suspended. You should also make sure the customer has [confirmed](./pin-client.md#confirm-partnership) their cooperation, and their status on the partner portal is `Active`.

{% note alert %}

A cloud that is not linked to the customer subaccount will not refer to the partner. The customer will pay for it directly to {{ yandex-cloud }}.

{% endnote %}

You can link a customer's cloud to a partner subaccount on the partner portal or using the management console. To create a link, you will need the following roles:

* `billing.accounts.owner`, `admin`, or `editor` for the [billing account](../../billing/security/index.md#roles-list).
* `resource-manager.clouds.owner` for the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

{% list tabs group=instructions %}

- Management console {#console}

  To link a cloud on the customer side:

  1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **All services**.
  1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select an account from the list.
  1. Go to the **Account data** page.
  1. Under **Clouds**, click **Link cloud**.
  1. Select the cloud from the list.
  1. Click **Link**. The cloud you added will appear on the list.
  1. If you migrated a cloud, pay any outstanding charges on the old account.

  To prevent the partner from linking a customer's cloud on their own, revoke the roles for resources from the partner. You can learn more about the {{ yandex-cloud }} roles [here](../../resource-manager/security/).

- Partner portal {#partner}

  On the partner side, a customer's cloud can be linked on the partner's management console home page (as described in the **Management console** tab) or through the customer's billing account.

  To link a cloud using the customer billing account:

  1. Log in to the [partner portal]({{ link-cloud-partners }}) under a Yandex ID with a linked {{ yandex-cloud }} partner account.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/credit-card.svg) **Subaccounts**.
  1. Pick the subaccount you need from the list.
  1. Go to the **Quotas & Instances** tab.
  1. Under **Instances**, click **Cloud** → **Link cloud** and select a cloud from the list.
  1. Click **Link**. The cloud will appear in the list.

{% endlist %}
