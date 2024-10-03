---
title: "Managing partner access in {{ marketplace-full-name }}"
description: "Managing partner access in {{ marketplace-short-name }}. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Managing partner access in {{ marketplace-short-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in a partner profile](#roles-list).
* [How to add a new user to a partner profile](#add-user).
* [How to assign a role in a partner profile](#assign-role).

## Which resources you can assign a role for {#resources}

 In the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}), you can [assign a role](#assign-role) to [Marketplace products](../concepts/product.md) and to a [partner profile](../quickstart.md#registration).

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### marketplace.meteringAgent {#marketplace-meteringagent}

{% include [marketplace.meteringAgent](../../_roles/marketplace/meteringAgent.md) %}

#### license-manager.saasSubscriptionSupervisor {#license-manager-saasSubscriptionSupervisor}

{% include [license-manager.saasSubscriptionSupervisor](../../_roles/license-manager/saasSubscriptionSupervisor.md) %}

#### marketplace.product.creator {#marketplace-product-creator}

{% include [marketplace.product.creator](../../_roles/marketplace/product/creator.md) %}

#### marketplace.product.admin {#marketplace-product-admin}

{% include [marketplace.product.admin](../../_roles/marketplace/product/admin.md) %}

#### marketplace.publishers.reportViewer {#marketplace-publishers-reportViewer}

{% include [marketplace.publishers.reportViewer](../../_roles/marketplace/publishers/reportViewer.md) %}

#### marketplace.publishers.viewer {#marketplace-publishers-viewer}

{% include [marketplace.publishers.viewer](../../_roles/marketplace/publishers/viewer.md) %}

#### marketplace.publishers.editor {#marketplace-publishers-editor}

{% include [marketplace.publishers.editor](../../_roles/marketplace/publishers/editor.md) %}

#### marketplace.publishers.admin {#marketplace-publishers-admin}

{% include [marketplace.publishers.admin](../../_roles/marketplace/publishers/admin.md) %}

#### marketplace.publishers.owner {#marketplace-publishers-owner}

{% include [marketplace.publishers.owner](../../_roles/marketplace/publishers/owner.md) %}

#### marketplace.publishers.member {#marketplace-publishers-member}

{% include [marketplace.publishers.member](../../_roles/marketplace/publishers/member.md) %}

## Adding a user to the {{ marketplace-short-name }} partner profile {#add-user}

To add a new user to the {{ marketplace-short-name }} partner profile, you need the `marketplace.publishers.admin` role or higher.

You can only add a [user with a Yandex account](../../iam/concepts/users/accounts.md#passport) or a [federated user](../../iam/concepts/users/accounts.md#saml-federation). To add a new user:

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  1. Open the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. At the top of the screen, click **{{ ui-key.yacloud_portal.acl.common.action_via-email }}** and in the window that opens:

      1. Specify the email address of the Yandex account belonging to the user you want to add to your partner dashboard.
      1. Click **{{ ui-key.yacloud_portal.common.action_add }}**.

- Federated account {#federated-account}

  1. Open the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. At the top of the screen, click **{{ ui-key.yacloud_portal.acl.common.action_via-federation }}** and in the window that opens:

      1. Specify the name ID of the federated user you want to add to your partner dashboard.

          You should specify the name ID returned by the Identity Provider (IdP) on successful authentication. This may be a UPN or user email address.

          You can add multiple users at once by separating their name IDs with a line break.

      1. Click **{{ ui-key.yacloud_portal.common.action_add }}**.

{% endlist %}

As a result, you will see the new user in the list of users on the **{{ ui-key.yacloud_portal.marketplace_v2.common.page_title_roles }}** page. The users you add are assigned the [`marketplace.publishers.member`](#marketplace-publishers-member) and [`marketplace.publishers.viewer`](#marketplace-publishers-viewer) roles by default.

## Assigning and revoking a role {#assign-role}

In the {{ marketplace-short-name }} partner dashboard, you can assign roles for specific products or for a partner profile. To assign a role to a user or revoke it:

{% list tabs %}

- For a product

  1. Open the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![shopping-cart](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud_portal.portal.products }}**.
  1. Click on the row with the product you want to assign or revoke a role for. In the window that opens:

      1. In the left-hand menu, select **{{ ui-key.yacloud_portal.marketplace_v2.common.page_title_roles }}**.
      1. In the row with the appropriate user, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_portal.common.action_change }}**. In the window that opens:

          {% include [assign-role](../../_includes/marketplace/assign-role.md) %}

- For a partner profile

  1. Open the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
  1. In the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
  1. In the row with the appropriate user, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_portal.common.action_change }}**. In the window that opens:

      {% include [assign-role](../../_includes/marketplace/assign-role.md) %}

{% endlist %}