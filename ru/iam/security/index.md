# Управление доступом

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

![image](service-roles-hierarchy.svg)

Роли, действующие в сервисе:

* Сервисные роли:
    * {% include [iam.serviceAccounts.user](../../_includes/iam/roles/short-descriptions/iam.serviceAccounts.user.md) %}

        В некоторых сервисах для выполнения операций необходим сервисный аккаунт, например в [{{ ig-name }}]({{ link-cloud-services }}/instance-groups) или [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes). Если вы указали сервисный аккаунт в запросе, то {{ iam-short-name }} проверит, что у вас есть права на использование этого аккаунта.
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
[Получение IAM-токена](../operations/iam-token/create.md) | `create` | роли не требуются, только аутентификация
[Просмотр информации о пользователе](../operations/users/get.md) | `get`, `getByLogin` | роли не требуются, только аутентификация
[Просмотр информации о сервисном аккаунте](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` или `viewer` на сервисный аккаунт
Просмотр информации о любом ресурсе | `get`, `list` | `viewer` на этот ресурс
**Управление ресурсами** | |
[Создание](../operations/sa/create.md) сервисных аккаунтов в каталоге | `create` | `editor` на каталог
[Изменение](../operations/sa/update.md), [удаление](../operations/sa/delete.md) сервисных аккаунтов | `update`, `delete` | `editor` на сервисный аккаунт
Создание и удаление ключей для сервисного аккаунта | `create`, `delete` | `editor` на сервисный аккаунт
**Управление доступом к ресурсам** | |
[Добавление нового пользователя в облако](../operations/users/create.md) | `setAccessBindings` | `admin` на облако
[Сделать нового пользователя владельцем облака](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` на это облако
[Назначение роли](../operations/roles/grant.md), [отзыв роли](../operations/roles/revoke.md) и просмотр назначенных ролей на ресурс | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на этот ресурс

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в Яндекс.Облаке](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
