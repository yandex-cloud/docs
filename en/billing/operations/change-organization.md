---
title: How to change the billing account organization
description: Follow this guide to change your billing account organization.
---

# Changing the billing account organization


{% include [cloud-to-pin.md](../_includes/clouds-to-pin.md) %}

To change the billing account [organization](../concepts/organization.md), the user must have the [`billing.accounts.owner`](../security/index.md#billing-accounts-owner) role for the [billing account](../security/index.md#set-role) and the [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin) role for the [organization](../../organization/security/index.md#add-role). To change the organization:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Go to [**{{ billing-name }}**]({{ link-console-billing }}).
  1. Select the billing account from the list.
  1. In the top-right corner of the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page, click ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. In the window that opens, select the organization from the list (you will see only those organizations in which you are a [user](../../organization/operations/add-account)), confirm the organization change, and click **Change**.

{% endlist %}
