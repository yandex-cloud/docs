---
title: How to view user logs
description: Follow this guide to view logs of organization users or all pool users.
---

# Viewing user logs


{% include [roles-for-view-logs](../../../_includes/organization/roles-for-view-logs.md) %}

## Viewing organization user logs {#organization}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** and select the user from the list that opens.
  
     Optionally, use the search bar or filter at the top of the page.

  1. To view the user's authentication history, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_auth-audit-log_sajZE }}** tab.     
  1. To view events caused by the user’s actions, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_audit-log_fGywF }}** tab.
  1. Click an entry to view more details about the event.

  You can use also use filters at the top of the page to find the logs you need.

{% endlist %}

## Viewing logs of users from a specific pool {#pool}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. Select the required pool from the [user pool](../../concepts/user-pools.md) list.
  1. To view the user's authentication history, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_auth-audit-log_sajZE }}** tab.     
  1. To view events caused by the user’s actions, go to the **{{ ui-key.yacloud_org.organization.users.UserPageLayout.title_audit-log_fGywF }}** tab.
  1. Click an entry to view more details about the event.

  You can use also use filters at the top of the page to find the events you need.

{% endlist %}