---
title: Switching to a different organization in {{ org-full-name }}
description: In this tutorial, you will learn how to switch to a different organization in {{ org-name }}.
---

# Managing multiple organizations


In {{ org-full-name }}, any Yandex user authorized with a Yandex ID can create and manage an unlimited number of organizations.

Follow [this guide](enable-org.md) to create your first organization.

{% note info %}

Only users with Yandex accounts can create organizations. [Federated users](../../iam/concepts/users/accounts.md#saml-federation) cannot create an organization.

{% endnote %}

## Creating an additional organization {#create-additional-org}

1. [Log in to the user account]({{ link-passport-login }}) you are going to use to create a new organization.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left-hand panel, click ![plus](../../_assets/console-icons/plus.svg) or ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.pages.create }}**.
1. In the window that opens, enter a name and description for the organization.
1. Click **{{ ui-key.yacloud_org.page.context.action.create }}**.

Once the organization is created, you become its owner and can manage it.

## Switching to another organization or federation {#switch-to-another-org}

1. In the [management console]({{ link-console-main }}), click your account picture in the left-hand panel.
1. Select an organization or federation from the list of those available in your account. Available organizations and federations are marked with ![case](../../_assets/console-icons/briefcase.svg).

    Alternatively, you can select an organization or federation belonging to a different Yandex account you previously logged in to. To do this, click the account name in **Login history**.

    If the account you need is not on the list, log in to it by clicking ![image](../../_assets/console-icons/plus.svg).

The name of the selected organization is displayed in the top-left corner of the service window.

If there are multiple organizations registered in your account, you can [move](../../resource-manager/operations/cloud/change-organization.md) clouds between them. To move a cloud to a different organization, you need the `{{ roles-cloud-owner }}` [role](../security/index.md#organization-manager-organizations-owner) for the cloud you are transferring and the `{{ roles-organization-owner }}` [role](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the destination organization.
