---
title: How do I get started with Yandex Cloud Console
description: Follow this guide to set up the management console.
---

# How do I get started with Yandex Cloud Console?

To get started with the management console:

1. Create a [Yandex ID]({{ link-yandex }}/support/passport/authorization/registration.html) account.

1. Log in to the [management console]({{ link-console-main }}).

   When you log in to the management console for the first time, the `cloud-<Yandex_ID>` [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), `default` [folder](../resource-manager/concepts/resources-hierarchy.md#folder), and `default` [network](../vpc/concepts/network.md#network) are automatically created.

1. [Create a billing account](../billing/operations/create-new-account.md). The `cloud-<Yandex_ID>` cloud will be linked to it automatically.

    When you create your first billing account, you get an [initial grant](../getting-started/usage-grant.md) to get started with the platform.

1. Create your first resource, e.g., a [Linux VM](../compute/quickstart/quick-create-linux.md).

## What's next {#whats-next}

1. Check out the list of all [{{ yandex-cloud }} services](../overview/concepts/services.md).

1. If you need to set up Single Sign-On (SSO) for corporate accounts, add a federation to [{{ org-full-name }}](../organization/concepts/add-federation.md).

1. [Add](../iam/operations/users/create.md) users to your [organization](../overview/roles-and-resources.md) and [grant](../iam/operations/roles/grant.md) them access to {{ yandex-cloud }} resources.