# Link a cloud to a billing account

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Requirements for linking a cloud

Before linking a cloud, make sure that the billing account has been activated (the `ACTIVE` or `TRIAL_ACTIVE` status) and that the user has the following roles:
* [resource-manager.clouds.owner](../../iam/concepts/access-control/roles.md#owner) in the cloud.
* `billing.accounts.owner` or `editor` in the billing account. Read more about roles in [Access control](../security/index.md#role-list).

{% note info %}

If the billing account status is `SUSPENDED`, then the cloud status automatically switches to `SUSPENDED` when linked.

{% endnote %}

## Linking a cloud

To link a cloud or transfer an existing one:
1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/main-menu.svg) **All services**.

1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).

1. Select an account from the list.

1. Go to the **Overview** page.

1. Under **Clouds**, click **Link cloud**.

1. Select a cloud from the list.

1. Click **Link** and the added cloud will appear on the list.

1. If you migrated a cloud, pay any outstanding charges on the previous account.

{% include [account_scope.md](../_includes/account-scope.md) %}

If you are migrating a cloud because you want to stop using the old billing account, make sure the free Basic service plan is activated in it. Otherwise, even though it has no linked clouds remaining, you will continue to be charged for the paid service plan.





