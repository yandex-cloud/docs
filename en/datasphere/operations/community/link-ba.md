---
title: Linking a billing account to work with {{ ml-platform-name }}
description: A billing account is used to identify the user who pays for computing resources, nodes, and resource storage for all community projects.
---

# Linking a billing account

A [billing account](../../../billing/concepts/billing-account.md) is used to identify the user who pays for computing resources, [nodes](../../concepts/deploy/index.md#node), and resource storage for all community projects.

You can [create a {{ yandex-cloud }} billing account](../../../billing/operations/create-new-account.md) in advance and link it when [creating a community](./create.md). In the {{ ml-platform-name }} interface, you can also create a new billing account when selecting a billing account for the community.

{% note warning %}

If the selected billing account has an outstanding balance or suspended status, you will not be able to link it to a {{ ml-platform-name }} community. If this is the case, go to [{{ billing-name }}]({{ link-console-billing }}), select your account, and follow the prompts in the interface. Once the billing account is active, try to link it to {{ ml-platform-name }} again. Learn more about billing account statuses [here](../../../billing/concepts/billing-account-statuses.md).

{% endnote %}

Only a community user with the `datasphere.communities.editor` role or higher can link a billing account to a community. To manage billing accounts, you also [need the `billing.accounts.editor` role](../../../billing/security/) or higher. If you are a community admin but have no access to billing accounts in your organization, contact your organization's admin in {{ yandex-cloud }}.

{% note tip %}

To manage a billing account, you must have a [Yandex account](../../../iam/concepts/users/accounts.md#passport). If using {{ yandex-cloud }} through an [identity federation](../../../organization/concepts/add-federation.md), [contact]({{ link-console-support }}) support.

{% endnote %}

## Changing a community billing account {#change-ba}

Users with the `Editor` or `Admin` role in the community can change the billing account used to pay for community projects and resources.

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Select the community and open the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.common.billing }}**, click **![pencil](../../../_assets/console-icons/pencil.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Select an existing billing account or create a new one by following the prompts in the interface.
1. Click **{{ ui-key.yc-ui-datasphere.common.link }}**.

### Who pays for shared resources {#who-pays}

{% include [pay-for-resources](../../../_includes/datasphere/pay-for-resources.md) %}

#### See also {#see-also}

* [{#T}](../../pricing.md)
* [{#T}](../../concepts/community.md)
* [{#T}](../../../billing/concepts/billing-account.md)
* [{#T}](../../../billing/concepts/billing-account-statuses.md)
