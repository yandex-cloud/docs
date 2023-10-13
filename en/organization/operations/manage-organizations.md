---
title: "Switching to another organization in {{ org-full-name }}"
description: "In this tutorial, you will learn how to switch to a different organization in {{ org-name }}."
---

# Managing multiple organizations


In {{ org-full-name }}, any Yandex user authorized with a Yandex ID can create and manage an unlimited number of organizations.

Follow [this guide](enable-org.md) to create your first organization.

{% note info %}

Only users with Yandex accounts can create organizations. [Federated users](../../iam/concepts/index.md#saml-federation) cannot create an organization.

{% endnote %}

## Creating an additional organization {#create-additional-org}

1. [Log in to the account]({{ link-passport-login }}) of the user to create a new organization under.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left-hand panel, click ![plus](../../_assets/plus.svg) or ![plus](../../_assets/plus.svg) **{{ ui-key.yacloud_org.pages.create }}**.
1. In the window that opens, enter a name and description for the organization.
1. Click **{{ ui-key.yacloud_org.page.context.action.create }}**.

Once the organization is created, you become its owner and can manage it.

## Switching to another organization or federation {#switch-to-another-org}

1. In the [management console]({{ link-console-main }}), click your account picture in the left-hand panel.
1. Under **Login history**, select an organization or federation from the list.

   Alternatively, you can select an organization belonging to a different Yandex account you previously logged in to. To do this, click the account name.

   If the account you need is not on the list, log in to that account by clicking ![image](../../_assets/plus-sign.svg).

The name of the selected organization is displayed in the top-left corner of the service window.

If there are multiple organizations registered in your account, you can [move](../../resource-manager/operations/cloud/change-organization.md) clouds between them.
