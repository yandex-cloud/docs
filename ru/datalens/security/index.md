---
title: "Управление доступом к {{ datalens-full-name }}"
description: "Из статьи вы узнаете, как регулируется доступ к сервису {{ datalens-short-name }}."
---

# Управление доступом к {{ datalens-short-name }}


Доступ к сервису {{ datalens-full-name }} регулируется путем назначения прав:

* для экземпляра {{ datalens-short-name }} на уровне организации — через сервис [организации](../concepts/organizations.md);
* для экземпляра {{ datalens-short-name }} на уровне каталога облака — через [консоль]({{ link-console-main }}) {{ yandex-cloud }}.

При использовании файрвола разрешите доступ к внешним ресурсам, которые необходимы для работы сервиса:

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



Об управлении доступом к {{ datalens-name }} смотрите:


* [{#T}](./add-new-user.md)
* [{#T}](./roles.md)
* Организации в {{ datalens-name }}:

  * [Обзор](../concepts/organizations.md)
  * [{#T}](../operations/organizations/change-organization.md)


* Доступ к объектам:

  * [{#T}](./manage-access.md)
  * [{#T}](../operations/permission/grant.md)
  * [{#T}](../operations/permission/revoke.md)
  * [{#T}](../operations/permission/request.md)

* [Доступ к строкам данных](../security/row-level-security.md)
