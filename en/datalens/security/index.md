---
title: Managing access to {{ datalens-full-name }}
description: In this tutorial, you will learn about {{ datalens-short-name }} access management.
---

# Managing access to {{ datalens-short-name }}



Access to {{ datalens-full-name }} is managed by assigning permissions via the [organization's](../concepts/organizations.md) service.

When using a firewall, allow access to external resources required to run {{ datalens-short-name }}:

* `yastatic.net/*`
* `yandex.ru/*`
* `storage.yandexcloud.net/*`
* `*.storage.yandexcloud.net/*`
* `datalens.yandex.ru`
* `datalens.yandex.com`
* `*.yandex.cloud/*`
* `push.yandex.ru/*`
* `avatars.mds.yandex.net/*`
* `mc.yandex.ru/*`
* `*.yandex.ru/*`



To learn about {{ datalens-name }} access management, see:


* [{#T}](./add-new-user.md)
* [{#T}](./roles.md)
* Organizations in {{ datalens-name }}:

  * [Overview](../concepts/organizations.md)
  * [{#T}](../operations/organizations/change-organization.md)


* Object access:

  * [{#T}](./manage-access.md)
  * [{#T}](../operations/permission/grant.md)
  * [{#T}](../operations/permission/revoke.md)
  * [{#T}](../operations/permission/request.md)

* [Access to data rows](../security/row-level-security.md)


