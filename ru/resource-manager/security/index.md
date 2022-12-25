---
title: "Управление доступом в {{ resmgr-full-name }}"
description: "Управление доступом в сервисе, позволяющим структурировать ресурсы {{ yandex-cloud }} с помощью каталогов - {{ resmgr-full-name }}. В разделе описано на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ resmgr-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

![image](../../_assets/resource-manager/security/service-roles-hierarchy.svg)

Роли, действующие в сервисе:

* Сервисные роли:
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
    * {% include [resource-manager.clouds.member](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.member.md) %}
    * {% include [resource-manager.admin](../../_includes/iam/roles/short-descriptions/resource-manager.admin.md) %}
    * {% include [resource-manager.editor](../../_includes/iam/roles/short-descriptions/resource-manager.editor.md) %}
    * {% include [resource-manager.viewer](../../_includes/iam/roles/short-descriptions/resource-manager.viewer.md) %}

* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
Просмотр информации о любом ресурсе | `get`, `list` | `viewer` на этот ресурс
Просмотр информации о каталоге или облаке | `get`, `list` | `resource-manager.viewer` на каталог или облако
**Управление ресурсами** | |
[Создание облака](../operations/cloud/create.md) | | Для создания первого облака роли не требуются, только аутентификация (так как пользователю автоматически назначается роль `resource-manager.clouds.owner` в созданной организации). В дальнейшем требуется роль `resource-manager.editor` или `editor` на организацию
[Изменение облака](../operations/cloud/update.md) | `update` | `editor` или `resource-manager.editor` на облако
[Удаление облака](../operations/cloud/delete.md) | `delete` | `resource-manager.clouds.owner` на облако
[Создание каталога в облаке](../operations/folder/create.md) | `create` | `editor` или `resource-manager.editor` на облако
[Изменение каталога](../operations/folder/update.md) | `update` | `editor` или `resource-manager.editor` на каталог
[Удаление каталога](../operations/folder/delete.md) | `delete` | `editor` или `resource-manager.editor` на каталог
**Управление доступом к ресурсам** | |
[Добавление нового пользователя в облако](../../iam/operations/users/create.md) | `setAccessBindings` | `admin` на облако, если облако без организации
[Сделать нового пользователя владельцем облака](../operations/cloud/set-access-bindings.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` на это облако
Просмотр назначенных ролей на ресурс | `listAccessBindings` | `viewer` на этот ресурс
Просмотр назначенных ролей на каталог или облако | `listAccessBindings` | `resource-manager.viewer` на каталог или облако
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) на каталог или облако | `setAccessBindings`, `updateAccessBindings` | `admin` или `resource-manager.admin` на каталог или облако

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
