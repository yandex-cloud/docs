# Link a new cloud

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

To link a cloud to a billing account, the user must have the following roles:

- [resource-manager.clouds.owner](../../iam/concepts/access-control/roles.md#owner) in the cloud.
- `billing.accounts.owner` or `editor` in the billing account. Read more about roles in [Access management](../security/index.md#role-list).

To link a new cloud:

1. In [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.

1. Select an account from the list.

1. Go to the **Overview** page.

1. Under **Clouds**, click **Link cloud**.

1. Select a cloud from the list.

1. Click **Link**.

   The cloud appears in the list.

{% note info %}

If the billing account status is `SUSPENDED`, then the cloud status automatically switches to `SUSPENDED` when linked.

{% endnote %}

