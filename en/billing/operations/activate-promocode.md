---
title: How to activate a promo code in {{ billing-name }}
description: Follow this guide to activate a promo code.
---

# Activating a promo code

Yandex regularly runs marketing campaigns with [promo codes](../concepts/promo-code.md) offered to users. To use a promo code, you need to activate it in {{ billing-name }} or in the management console.

{% note info %}

{% include [edit-required-roles](../_includes/edit-required-roles.md) %}

{% include [console-access-note](../_includes/console-access-roles.md) %}

{% endnote %}

To activate:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Navigate to [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select an account on the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** and click **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.button_activate-grant }}**. The button only appears when a promo code becomes available.
  1. Enter your promo code and click **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-grant-activation_button_activate }}**.

  All information about the promo code will be available in [{{ billing-name }}]({{ link-console-billing }}) under **{{ ui-key.yacloud_billing.billing.account.dashboard-grants.section_grants }}**.

- Management console {#console}

    1. Open the [management console]({{ link-console-main }}).
    1. In the top-right corner, click ![credit-card](../../_assets/console-icons/credit-card.svg).
    1. In the widget that opens, click **{{ ui-key.yacloud_billing_account.billing-widget.activate_promocode }}**.
    1. Enter your promo code and click **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-grant-activation_button_activate }}**.

    The widget will display information about the added promo code.

    {% include [hide-private-data](../_includes/billing-widget-hide-private-data.md) %}

{% endlist %}
