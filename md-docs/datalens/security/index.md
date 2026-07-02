[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > Управление доступом > Обзор

# Управление доступом к Yandex DataLens



Доступ к сервису Yandex DataLens регулируется путем назначения прав через сервис [организации](../concepts/organizations.md).

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
* `datalens.ru/*`



Об управлении доступом к DataLens смотрите:


* [Роли в Yandex DataLens](roles.md)
* Организации в DataLens:

  * [Обзор](../concepts/organizations.md)
  * [Переключение между экземплярами DataLens](../operations/organizations/change-organization.md)


* Доступ к объектам:

  * [Права доступа к объектам](manage-access.md)
  * [Назначение и изменение прав доступа](../operations/permission/grant.md)
  * [Удаление прав доступа](../operations/permission/revoke.md)
  * [Запрос прав доступа](../operations/permission/request.md)

* [Доступ к строкам данных](row-level-security.md)