---
title: How to manage billing in {{ org-full-name }}
description: In this guide, you will learn how to manage billing for {{ org-name }} user connections to external applications through the {{ org-full-name }} interface.
---

# Billing management in {{ org-full-name }}

Connecting {{ org-name }} users to external applications is [billable](../pricing.md#rules). You can [manage](../pricing.md#pricing-management) {{ org-name }} billing through the [{{ cloud-center }} interface]({{ link-org-cloud-center }}).

## Linking a billing account to {{ org-name }} {#add-billing-account}

By default, an {{ org-name }} [organization](../concepts/organization.md) has a non-billable connection limit of 15 users who can authenticate to external applications within the calendar month. To use {{ org-name }}'s billable features and [change](#modify-limit) this connection limit, link a [billing account](../../billing/concepts/billing-account.md) to {{ org-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-org-to-ba-linking-role](../../_includes/organization/idp-org-to-ba-linking-role.md) %}

  1. In the left-hand panel, select ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. To link a billing account for the first time:
  
      1. In the top-right corner, click **{{ ui-key.yacloud_org.organization.billing.layout.bind_account_action }}** and do the following in the window that opens:

          1. Select the billing account you need from the list.

              If you do not have a billing account or would like to create a new one, click **{{ ui-key.yacloud_org.billing.accounts.dialog_button_create }}** and follow [this guide](../../billing/operations/create-new-account.md) to create a new billing account.
          1. Click **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

  1. To change a billing account linked to {{ org-name }}:

      1. In the top-right corner, click **{{ ui-key.yacloud_org.organization.billing.layout.change_account_action }}** and do the following in the window that opens:

          1. Select the billing account you need from the list.

              If you want to create a new billing account, click **{{ ui-key.yacloud_org.billing.accounts.dialog_button_create }}** and follow [this guide](../../billing/operations/create-new-account.md) to create a new billing account.
          1. Click **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

{% endlist %}

This will link your billing account to {{ org-name }}, and you will be able to use and manage {{ org-name }}'s billable features.

## Viewing limit usage statistics {#view-stats}

To view organization users' connection [limit](../pricing.md#monthly-limit) usage statistics:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-connection-limit-viewing-role](../../_includes/organization/idp-connection-limit-viewing-role.md) %}

  1. In the left-hand panel, select ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. Under **{{ ui-key.yacloud_org.organization.billing.LoggedUsersBlock.title }}**, you can see the current limit in place and how much of it has been used.

      Expand the **{{ ui-key.yacloud_org.organization.billing.LoggedUsersBlock.title }}** section for a list of users who have used the connection limit this current month. This list contains user names and IDs, as gives the date and time the user first authenticated to an external application during the current month.

      {% note tip %}

      To quickly find info on a specific user, use the search bar to enter the login or ID.

      {% endnote %}

{% endlist %}

## Editing the connection limit {#modify-limit}

To edit the connection limit:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

      {% include [idp-connection-limit-modifying-role](../../_includes/organization/idp-connection-limit-modifying-role.md) %}

  1. In the left-hand panel, select ![credit-card](../../_assets/console-icons/credit-card.svg) **{{ ui-key.yacloud_org.pages.organization-billing }}**.
  1. If your [billing account](../../billing/concepts/billing-account.md) is not linked to {{ org-name }} yet, [link](#add-billing-account) it to be able to use {{ org-name }}'s billable features.
  1. Click **{{ ui-key.yacloud_org.organization.billing.ChangeLimitsBlock.change_limit_action }}**, and in the window that opens:

      1. To increase the connection limit:
      
          1. In the **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.new_limit }}** field, increase the connection limit and click **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.action }}**.

              Extra users above the non-billable limit will be [billed](../pricing.md#rules).
          1. In the window that opens, check the payment amount and click **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.confirm_action }}** to confirm your payment.

              The amount will be debited from your billing account, and the connection limit will be updated directly after the payment.
      1. To reduce the connection limit:

          1. In the **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.new_limit }}** field, reduce the connection limit and click **{{ ui-key.yacloud_org.organization.billing.UpdateLimitDialog.downgrade_action }}**.

              The already paid connections will remain valid until the end of the current month, and the changes you make will take effect starting from the first day of the next month.

              {% note info %}

              You can only reduce the limit to the non-billable level of 15 connections.

              {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../pricing.md)