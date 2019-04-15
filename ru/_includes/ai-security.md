# Управление доступом

В сервисе не создаются какие-либо ресурсы, поэтому для управления доступом используются [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder). Вы указываете идентификатор каталога при каждом запросе к сервису. Если у вас нет необходимых разрешений на этот каталог, то сервис вернет ошибку.

Чтобы пользоваться сервисом, необходима одна из комбинаций [ролей](../iam/concepts/access-control/roles.md):

* `resource-manager.cloud.member` + `editor`;
* `resource-manager.cloud.member` + `admin`;
* `resource-manager.cloud.owner`.

Для [сервисного аккаунта](../iam/concepts/users/service-accounts.md) и [системной группы](../iam/concepts/access-control/system-group.md) необязательно назначать роль `resource-manager.cloud.member`.

Для пользователя с аккаунтом на Яндексе роль `resource-manager.cloud.member` назначается автоматически при [добавлении в облако](../iam/operations/users/create.md).

> [!NOTE]
>
> Роли `editor` и `admin` можно назначить на каталог или облако — все разрешения от облака [наследуются](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

#### Что дальше

* [Как назначить роль на каталог](../resource-manager/operations/folder/set-access-bindings.md)
* [Как назначить роль на облако](../resource-manager/operations/cloud/set-access-bindings.md)
* [Подробнее о ролях в Яндекс.Облаке](../iam/concepts/access-control/roles.md)