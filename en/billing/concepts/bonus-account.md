# Grant

A grant is a discount on {{ yandex-cloud }} services provided to an individual entrepreneur, business, or individual. The discount amount is equal to the grant amount. The discount is applied to the total cost of the consumed services.

{% note info %}

You cannot use grants to top up [personal accounts](personal-account.md).

{{ yandex-cloud }} can revoke the grant without explanation.

{% endnote %}

{% include [currency](../_includes/currency.md) %}


## Viewing your grants {#how-to-view}

You can view your grants in {{ billing-name }} or in the management console widget.

{% note info %}

{% include [view-required-roles](../_includes/view-required-roles.md) %}

{% include [console-access-note](../_includes/console-access-roles.md) %}

{% endnote %}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Navigate to [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select the billing account from the list.
  1. On the ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** page, under **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.section_grants }}**, click ![image](../../_assets/console-icons/chevron-right.svg) **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.action_show-all }}**.
  1. On the **{{ ui-key.yacloud_billing.billing.account.offers.label_title }}** page, the **{{ ui-key.yacloud_billing.billing.account.offers.value_grants }}** tab shows all grants you received.

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. In the top-right corner, click ![credit-card](../../_assets/console-icons/credit-card.svg).

  The widget that opens will display information about active grants. To view info on all your grants, click **{{ ui-key.yacloud_billing_account.billing-widget.grant }}** ![image](../../_assets/console-icons/arrow-up-right-from-square.svg).

  {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}

{% endlist %}


## Initial grant {#start}

{% include [grant-amount](../../getting-started/_includes/grant-amount.md) %}

For more information about the terms of use of initial grants, see [Getting started](../../getting-started/usage-grant.md).

{% note info %}

Each individual, sole proprietor, or business can be given only one initial grant.

{% endnote %}


## Additional grants {#additional}

Additional grants can be provided on {{ yandex-cloud }} manager's decision or under a content program, referral program, or [Yandex Cloud Boost program](../../../cloud-boost). You can view the amount of additional grants and their validity period in {{ billing-name }}.



## Using grants {#how-to-use}

Grants are prioritized based on their validity period: the earlier the expiration date, the sooner the grant is used.

{% include [grant-and-cvos](../../_includes/billing/grant-and-cvos.md) %}

For more information about using grants, see the [billing cycle description](../payment/billing-cycle-individual.md).

{% include [grant-support](../../_includes/billing/grant-support.md) %}
