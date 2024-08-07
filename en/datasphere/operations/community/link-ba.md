# Linking a billing account

A [billing account](../../../billing/concepts/billing-account.md) is used to identify a user who pays for computing resources, [nodes](../../concepts/deploy/index.md#node), and storage of resources of all the community projects.

You can [create a {{ yandex-cloud }} billing account](../../../billing/operations/create-new-account.md) in advance and link it when [creating a community](./create.md). In the {{ ml-platform-name }} interface, you can also create a new billing account when selecting a billing account for the community.

{% note warning %}

If the selected billing account is suspended or has an overdue debt, you cannot link it to your {{ ml-platform-name }} community. In this case, go to [{{ billing-name }}]({{ link-console-billing }}), select your account, and follow the prompts in the interface. When the billing account is activated, try to link it to {{ ml-platform-name }} again. More about [billing account](../../../billing/concepts/billing-account-statuses.md) statuses.

{% endnote %}

Only a community user with the `datasphere.communities.editor` role or higher can link a billing account to a community. For operations with billing accounts, you also [need the `billing.accounts.editor` role](../../../billing/security/) or higher. If you are a community administrator but have no access to billing accounts in your organization, please contact your organization's administrator in {{ yandex-cloud }}.

{% note tip %}

You can only manage a billing account if you have a [Yandex account](../../../iam/concepts/users/accounts.md#passport). If you use {{ yandex-cloud }} through an [identity federation](../../../organization/concepts/add-federation.md), [contact]({{ link-console-support }}) support.

{% endnote %}

## Changing a community's billing account {#change-ba}

Users with the `Editor` or `Admin` role can change the billing account used to pay for your community's projects and resources.

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Select a community and open the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.common.billing }}**, click **![pencil](../../../_assets/console-icons/pencil.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Select an existing billing account or create a new billing account by following the prompts in the interface.
1. Click **{{ ui-key.yc-ui-datasphere.common.link }}**.

### Who pays for shared resources {#who-pays}

{% include [pay-for-resources](../../../_includes/datasphere/pay-for-resources.md) %}

#### See also {#see-also}

* [{#T}](../../pricing.md)
* [{#T}](../../concepts/community.md)
* [{#T}](../../../billing/concepts/billing-account.md)
* [{#T}](../../../billing/concepts/billing-account-statuses.md)