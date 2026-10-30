---
title: Personalized offers in {{ marketplace-name }}
description: Follow this guide to learn how to accept a personalized offer in {{ marketplace-name }}.
---

# Accepting a personalized offer

You have to accept the personalized offer before the expiration date  specified in the **{{ ui-key.yacloud.marketplace.privateOfferOverviewScreen.field_acceptance-deadline }}** field.

{% note warning %}

You can no longer accept an offer after it expires or you decline it.

{% endnote %}

To accept a personalized offer, you need permissions to view the billing account, e.g., the `billing.accounts.viewer` [role](../../../billing/security/index.md#billing-accounts-viewer).

To accept a personalized offer:

1. Log in to the [management console]({{ link-console-main }}).
1. [Navigate]({{ link-console-main }}/link/marketplace) to {{ marketplace-short-name }}.
1. Navigate to the **{{ ui-key.yacloud.marketplace-v2.label_private-offers }}** tab.
1. Select a personalized offer with the `{{ ui-key.yacloud.marketplace.privateOfferStatusInfo.label_status-pending }}` status.
1. Review the terms of the personalized offer and make sure you are accepting it for the correct billing account.
1. Click **{{ ui-key.yacloud.marketplace.privateOfferCardFooter.action_accept }}**.

You will gain access to purchasing a personalized subscription. You can buy it:
* On the accepted personalized offer page in the management console.
* On the product page in {{ marketplace-name }}.

Subscriptions available to you will appear on the **{{ ui-key.yacloud.marketplace.productDetailView.tab_personal-terms }}** tab.

When purchasing a personalized subscription, you need to pick another subscription which you will automatically migrate to when your personalized offer expires. Learn more about [purchasing a subscription](buy-subscription.md).
