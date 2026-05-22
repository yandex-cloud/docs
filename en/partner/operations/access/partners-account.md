---
title: How to grant access to a partner account
description: In this guide, you will learn how to grant access to a partner account
---

# Granting access to a partner account

To grant access to a partner account:

{% list tabs group=instructions %}

- Management console {#console}

  For details, see [{#T}](../../../billing/security/index.md#set-member-role).

- Partner portal {#partner}

  1. Log in to the [partner portal]({{ link-cloud-partners }}) under a Yandex ID with a linked {{ yandex-cloud }} partner account. If you have no access, it means the account you are using to log in has no partner status assigned.
  1. In the left-hand panel, select ![icon](../../../_assets/console-icons/persons-lock.svg) **Access management**.
  1. Add a user.
    * If you have a configured identity federation, click **Add federated user** in the top-right corner and list the user IDs.
    * To invite a user by their email, click **Add user** in the top-right corner. In the window that opens, enter the user's email address and click **Add**.
  1. In the **Configure access bindings** window, specify the user [roles](../../../billing/security/index.md#roles-list).

  The user will get access to the partner portal and an option to add customers.

{% endlist %}
