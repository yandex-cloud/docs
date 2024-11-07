---
title: Creating or switching to a different organization in {{ org-full-name }}
description: In this tutorial, you will learn how to create an additional organization or switch to a different organization in {{ org-name }}.
---

# Managing multiple organizations

In {{ org-full-name }}, any Yandex user authorized with a Yandex ID can create and manage an unlimited number of organizations.

Follow [this guide](./enable-org.md) to create your first organization.

{% note info %}

Only users with Yandex accounts can create organizations. [Federated users](../../iam/concepts/users/accounts.md#saml-federation) cannot create an organization.

{% endnote %}

## Creating an additional organization {#create-additional-org}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) with the user account you are going to use to create a new organization.

  1. In the top-left corner, next to the name of the current organization, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) and select ![circle-plus](../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.form.organization.create.action.create }}**.

  1. In the window that opens, enter a name and description for your organization.

  1. Click **{{ ui-key.yacloud_org.form.organization.select.action.create }}**.

{% endlist %}

Once the organization is created, you become its owner and can manage it.

## Switching to another organization or federation {#switch-to-another-org}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}) and click your account picture in the left-hand panel.
  1. Select an organization or federation from the list of those available in your account. Available organizations and federations are marked with ![case](../../_assets/console-icons/briefcase.svg).

      Alternatively, you can select an organization or federation belonging to a different Yandex account you previously logged in to. To do this, click the account name in **Login history**.

      If the account you need is not on the list, log in to it by clicking ![image](../../_assets/console-icons/plus.svg) **Logging in to your account**.

  The name of the selected organization is displayed in the top-left corner of the {{ cloud-center }} window and in the section with the list of clouds and folders.

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}).

  1. Edit the current organization using one of the following methods:

      * In the top-left corner, click ![chevron-down](../../_assets/console-icons/chevron-down.svg) next to the name of the current organization and select another one.

      * Click your account picture in the left-hand panel and select an organization from the list of those available in your account. Available organizations are marked with the ![case](../../_assets/console-icons/briefcase.svg) icon.

          You can also use this method to select an organization from a different Yandex account you previously logged in to. To do this, click the account name in **Login history**.

          If the account you need is not on the list, log in to it by clicking ![image](../../_assets/console-icons/plus.svg) **Logging in to your account**.
  
  This will switch you to a different organization.

{% endlist %}

If there are multiple organizations registered in your account, you can [move](../../resource-manager/operations/cloud/change-organization.md) clouds between them. To move a cloud to a different organization, you need the `{{ roles-cloud-owner }}` [role](../security/index.md#organization-manager-organizations-owner) for the cloud you are transferring and the `{{ roles-organization-owner }}` [role](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the destination organization.
