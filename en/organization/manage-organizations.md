---
title: "Switching to another organization in {{ org-full-name }}"
description: "In this tutorial, you will learn how to switch to a different organization in {{ org-name }}."
---

# Managing multiple organizations


In {{ org-full-name }}, any Yandex user authorized with a Yandex ID can create and manage an unlimited number of organizations.

Follow [this guide](enable-org.md) to create your first organization.

{% note info %}

Only users with Yandex accounts can create organizations. [Federated users](../iam/concepts/index.md#saml-federation) cannot create an organization.

{% endnote %}

## Creating an additional organization {#create-additional-org}

1. [Log in to the account]({{ link-passport-login }}) of the user to create a new organization under.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left-hand panel, click ![plus](../_assets/plus.svg) or ![plus](../_assets/plus.svg) **Create organization**.
1. In the window that opens, enter a name and description for the organization.
1. Click **Create new organization**.

Once the organization is created, you become its owner and can manage it.

## Switching to another organization {#switch-to-another-org}

1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left-hand panel, click on your account picture.
1. In the list that opens, select the organization you need.

The name of the selected organization is displayed in the top-left corner of the service window.

If there are multiple organizations registered in your account, you can [move](../resource-manager/operations/cloud/change-organization.md) clouds between them.