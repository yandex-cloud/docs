# Управление доступом

<!-- Поправьте список, если каких-то разделов не добавили или наоборот удалили. -->

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

<!-- Если в сервисе можно назначать роли на другие ресурсы, перечислите их тут. -->

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

<!-- Картинка с иерархией ролей. Её можно хранить рядом с разделом или в _assets, вместе с другими картинками. -->

![image](../../_assets/_templates/security/service-roles-hierarchy.svg)

Роли, действующие в сервисе:

* Сервисные роли: <!-- Добавьте короткие описания всех ролей, действующих в сервисе. -->
    * {% include [ИДЕНТИФИКАТОР_РОЛИ](../../_includes/iam/roles/short-descriptions/ИДЕНТИФИКАТОР_РОЛИ.md) %}

        <!-- Если требуется, дайте пояснение о том, как работает роль в сервисе. Лучше не больше 2 абзацев. -->
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

<!-- Напишите, список действий в сервисе и то, какая роль нужна для этих действий. По возможности группируйте действия. Если действиую соответствует какой-то метод в API, напишите этот метод. Если для действия есть пошаговая инструкция — сделайте описание действия ссылкой на эту инструкцию. -->

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
Просмотр информации о любом ресурсе | `get`, `list` | `viewer` на этот ресурс
**Управление ресурсами** | |
Создание ресурсов в каталоге | `create` | `editor` на каталог <!-- и на другие связанные ресурсы -->
Изменение, удаление ресурсов | `update`, `delete` | `editor` на ресурс <!-- и на другие связанные ресурсы -->
**Управление доступом к ресурсам** | |
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на ресурс | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на этот ресурс

#### Что дальше

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
