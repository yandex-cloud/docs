---
title: Adding a user to a subaccount
description: Follow this guide to add a user to a partner's subaccount and assign roles.
---

# Adding a user to a subaccount

To grant a user access to a partner's subaccount, [add](#add-user) them to the subaccount and [assign](#add-access) roles.

## Adding a user to a subaccount {#add-user}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).
  1. Find in the list an organization created for the subaccount, e.g.: `For subaccount <subaccount_name>`.
  1. [Link](./pin-cloud.md) a cloud to the subaccount. If there is no cloud:
     1. In the panel on the left next to the organization name, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.iam.cloud.label_create_cloud }}**.
     1. Specify the cloud and partner subaccount.
  
  1. Go to [{{ cloud-center }}]({{ link-org-cloud-center }}).
  1. In the top-left corner, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) next to the name of the current organization and select the one you need, e.g., `For subaccount <subaccount_name>`.
  1. Navigate to the **{{ ui-key.yacloud_org.center-layout.Layout.organization-description_kvoUz }}** tab and click **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}**. 
  1. From the drop-down list, select **{{ ui-key.yacloud_org.page.users.action.invite-users }}** and enter the user's email address or select **{{ ui-key.yacloud_org.page.users.action.add-userpool-user }}** in the [pool](../../organization/concepts/user-pools.md).

{% endlist %}

## Assigning roles {#add-access}

After the user has accepted an invitation to an organization, it is time to assign roles:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. Go to [{{ billing-name }}]({{ link-console-billing }}).
  1. [Add](../../billing/security/index.md#set-member-role) the user to a subaccount.
  1. [Assign](../../billing/security/index.md#set-role) roles.

- Partner portal {#partner}

  1. Go to the [partner portal]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/credit-card.svg) **Subaccounts**.
  1. Pick the subaccount you need from the list.
  1. Go to the ![icon](../../_assets/console-icons/person-gear.svg) **Users** tab.
  1. In the top-right corner, click **Add user**.
  1. Select the user from the list and click **Add**.
  1. Under **Users and roles**, next to the new user, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **Edit**.
  1. In the window that opens, assign the roles as needed.

{% endlist %}