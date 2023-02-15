# Link a billing account

[Billing account](../../../billing/concepts/billing-account.md) is used to assign the user who pays for the computing resources, operation of [nodes](../../concepts/deploy/index.md#node), and storing of resources for all the community's projects.

You can [create a {{ yandex-cloud }} payment account](../../../billing/operations/create-new-account.md) in advance and link it when [creating a community](./create.md). In the {{ ml-platform-name }} interface, you can also create a new billing account at the step of selecting a billing account for the community.

{% note warning %}

If the selected billing account is suspended or has an overdue debt, you can't link it to your {{ ml-platform-name }} community. In this case, go to the [billing page]({{ link-console-billing }}) in the {{ yandex-cloud }} management console, select your account, and follow the prompts in the interface. When the billing account is activated, try to link it to {{ ml-platform-name }} again. More about [billing account](../../../billing/concepts/billing-account-statuses.md) statuses.

{% endnote %}

Only the community's administrator can link a billing account to it. To work with billing accounts, you also [need the role](../../../billing/security/) `editor` or higher. If you are an administrator in your community, but you don't have access to billing accounts in your organization, please contact your organization's administrator in {{ yandex-cloud }}.

{% note tip %}

Billing account management can only be performed by users with a [Yandex account](../../../iam/concepts/index.md#passport). If you use {{ yandex-cloud }} via an [identity federation](../../../organization/add-federation.md), [contact]({{ link-console-support }}) support.

{% endnote %}

## Changing the community's billing account {#change-ba}

The community's administrator can change the billing account used to pay for projects and resources of the community.

1. On the community's page, click **Settings**.
1. Under **Billing**, select **![pencil](../../../_assets/pencil.svg) Edit**.
1. Select an existing billing account or create a new billing account by following the prompts in the interface.
1. Click **Link**.

### Who pays for shared resources {#who-pays}

{% include [pay-for-resources](../../../_includes/datasphere/pay-for-resources.md) %}

#### See also {#see-also}

* [{#T}](../../pricing.md)
* [{#T}](../../concepts/community.md)
* [{#T}](../../../billing/concepts/billing-account.md)
* [{#T}](../../../billing/concepts/billing-account-statuses.md)