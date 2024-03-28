---
title: "How to change the billing account organization"
description: "Follow this guide to change your billing account organization."
---

# Changing the billing account organization

To change the billing account [organization](../concepts/organization.md), a user must have the `billing.accounts.owner` and `organizations.billingAccountSetter` roles. To change the organization:

{% list tabs group=instructions %}

- {{ billing-name }} interface {#billing}

   1. Go to [**{{ billing-name }}**](https://billing.yandex.cloud/accounts/).
   1. Select the billing account from the list.
   1. In the top-right corner of the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page, click ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
   1. In the window that opens, select the organization from the list (you will see only those organizations in which you are a [user](../../organization/operations/add-account)), confirm the organization change, and click **Change**.

{% endlist %}
