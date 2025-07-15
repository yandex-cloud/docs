---
title: How to accept a {{ billing-name }} commercial offer
description: Follow this guide to view and accept commercial offers.
---

# Accepting offers

In {{ billing-name }}, {{ yandex-cloud }} can send special commercial offers to its customers to distribute discounts, grants, details on committed volumes of services, subscriptions, and revisions.

Commercial offer statuses:
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_available-title }}`: Active offers.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_accepted-title }}`: Accepted offers.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_activating-title }}`: Offers being accepted. It usually takes up to 5 minutes, then the status changes to `{{ ui-key.yacloud_org.billing.account.proposals.tariff_accepted-title }}`. If the status did not change to `{{ ui-key.yacloud_org.billing.account.proposals_page.type_Error }}`, contact [support]({{ link-console-support }}) or your account manager.
* `{{ ui-key.yacloud_org.billing.account.proposals.tariff_blocked-title }}`: To accept an offer, contact [support]({{ link-console-support }}) or your account manager.
* `Completed`: All completed and expired offers. These are displayed on the **{{ ui-key.yacloud_org.billing.account.proposals.label_from-archive }}** tab.

{% note info %}

The user needs the `billing.accounts.viewer` [role](../security/index.md#billing-accounts-viewer) to view offers.
The user needs the `billing.accounts.owner` or `billing.accounts.editor` [role](../security/index.md#billing-accounts-owner) to accept offers.

{% endnote %}

To view and apply offers:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Go to [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select an account on the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page. If there are any available offers for the selected billing account, they will be listed in the top information section.
  1. To view all offers, select ![image](../../_assets/console-icons/tag-dollar.svg) **{{ ui-key.yacloud_org.billing.account.switch_proposals }}** in the left-hand panel.
  1. You can view active offers in the **{{ ui-key.yacloud_org.billing.account.proposals.label_from-current }}** tab on the **{{ ui-key.yacloud_org.billing.account.proposals.label_title }}** page. The page displays offers in the `{{ ui-key.yacloud_org.billing.account.proposals.tariff_available-title }}` status. You can filter the list by type of conditions and services or sort the offers by validity period for convenience.
  1. If you want to accept an offer, select one from the list, review its details, agree to the terms of use, and click **{{ ui-key.yacloud_org.billing.account.proposals.button_confirm }}**.

{% endlist %}