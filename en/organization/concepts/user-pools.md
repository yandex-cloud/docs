---
title: User pools in {{ org-full-name }}
description: You can create user pools to use local users and group them into containers. With a pool, you can manage users centrally, link your domains to them, grant access permissions, and manage authentication via the {{ yandex-cloud }} IdP.
---

# User pools


_User pools_ group [local users](../../iam/concepts/users/accounts.md#local) together, thus allowing you to manage them centrally, link your [domains](domains.md), manage access permissions and authentication settings.

Pools and users inside them exist only at the organization level and are subject to {{ yandex-cloud }} [security policies](../../security/standarts.md).

All pool users form a new [group](groups.md) for the purpose of [access settings](../operations/groups-access-binding.md) management.

#### See also {#see-also}

* [{#T}](../operations/user-pools/create-userpool.md)
* [{#T}](../operations/user-pools/add-user.md)
* [{#T}](../operations/user-pools/add-domain.md)
