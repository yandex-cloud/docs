---
title: User pools in {{ org-full-name }}
description: You can create user pools to use local users and group them into containers. With a pool, you can manage users centrally, link your domains to them, grant access permissions, and manage authentication via the {{ yandex-cloud }} IdP.
---

# User pools


_User pools_ group [local users](../../iam/concepts/users/accounts.md#local) together, thus allowing you to manage them centrally, link your [domains](domains.md), manage access permissions, authentication settings, and editability of [My account](../concepts/my-account.md) data.

Pools and users inside them exist only at the organization level and are subject to {{ yandex-cloud }} [security policies](../../security/standarts.md).

All pool users form a new [group](groups.md) for the purpose of [access settings](../operations/groups-access-binding.md) management.

When [creating](../operations/user-pools/create-userpool.md) a user pool, you specify a default domain which can be used if no other domains are linked to the pool.

The pool administrator can indicate which data users will be able modify on the [My Account](../concepts/my-account.md) portal. They can manage edit permissions of the following:
* Personal data
* Contact details
* Login
* Password (allowed by default)
* Organization details

#### See also {#see-also}

* [{#T}](../operations/user-pools/create-userpool.md)
* [Creating a local user](../operations/add-account.md#add-local-user)
* [{#T}](../operations/user-pools/add-domain.md)
* [{#T}](../operations/user-pools/user-get-logs.md)
