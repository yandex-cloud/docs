# Управление доступом

При выполнении запросов от имени [аккаунта на Яндексе](../iam/concepts/index.md#passport) указывайте [идентификатор каталога](../resource-manager/operations/folder/get-id.md), на который у вас есть разрешения роли `editor`. Если необходимых разрешений нет, то сервис вернет ошибку.

Для [сервисного аккаунта](../iam/concepts/users/service-accounts.md) каталог не указывайте — используется каталог, в котором был создан этот аккаунт.

Разрешения выдаются при [назначении роли](../iam/operations/roles/grant.md). Роль можно назначить на каталог или облако — все разрешения от облака [наследуются](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

Чтобы пользоваться сервисом, необходима одна из [ролей](../iam/concepts/access-control/roles.md):

* `editor`;
* `admin`;
* `resource-manager.clouds.owner` (назначается только на облако).

{% note info %}

Пользователю с аккаунтом на Яндексе или [федеративным аккаунтом](../organization/add-federation.md) вместе с ролями `editor` или `admin` нужна роль `resource-manager.clouds.member` на облако. Эта роль назначается автоматически при [добавлении в облако](../iam/operations/users/create.md).

{% endnote %}

#### Что дальше

* [Как назначить роль на каталог](../resource-manager/operations/folder/set-access-bindings.md)
* [Как назначить роль на облако](../resource-manager/operations/cloud/set-access-bindings.md)
* [Подробнее о ролях в {{ yandex-cloud }}](../iam/concepts/access-control/roles.md)