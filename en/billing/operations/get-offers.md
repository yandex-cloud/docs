---
title: How to accept a {{ billing-name }} commercial offer
description: Follow this guide to view and accept commercial offers.
---

# Accepting offers

In {{ billing-name }}, {{ yandex-cloud }} can send special commercial offers to its customers to distribute discounts, grants, details on committed volumes of services, subscriptions, and revisions. Offers can only be accepted by the billing account owner (`billing.accounts.owner` [role](../security/index.md#billing-accounts-owner) required). To view and apply offers:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Go to [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select an account on the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page. If there are any available offers for the selected billing account, they will be listed in the top information section.   
  1. To view all offers, select ![image](../../_assets/console-icons/tag-dollar.svg) **Offers** in the left-hand panel.
  1. You can view the active offers in the **Active** tab on the **Offers** page. It displays offers in the `Available` status. You can filter the list by type of conditions and services or sort the offers by validity period for convenience. 
  1. If you want to accept an offer, select one from the list, review its details, agree to the terms of use, and click **Accept offer**.

{% endlist %}

The **Archived** tab displays all accepted offers, including those that expired, i.e., their status is `Expired`. If the offer status changes to `Application error` after you accept it, contact [support]({{ link-console-support }}) or your account manager.
