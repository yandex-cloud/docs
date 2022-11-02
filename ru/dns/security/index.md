---
title: Управление доступом в {{ dns-full-name }}
description: "Управление доступом в сервисе для управления зонами DNS и доменными именами ваших ресурсов — {{ dns-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `dns.editor` входят все разрешения `dns.viewer`. После диаграммы дано описание каждой роли.

![image](../../_assets/dns/security/service-roles-hierarchy.svg)

Роли, действующие в сервисе:

* Сервисные роли:
    * {% include [dns.viewer](../../_includes/iam/roles/dns-viewer-short.md) %}
    * {% include [dns.editor](../../_includes/iam/roles/dns-editor-short.md) %}
    * {% include [dns.admin](../../_includes/iam/roles/dns-admin-short.md) %}

* Примитивные роли:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer` или `dns.admin` вместо `dns.editor`.

| Действие                                                                                                                                            |                              Методы                               | Необходимые роли                                                                                                                                                           |
|:----------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Просмотр информации**                                                                                                                             |                                                                   |                                                                                                                                                                            |
| Просмотр информации о любом ресурсе                                                                                                                 |                           `get`, `list`                           | `viewer` или `dns.viewer` на этот ресурс                                                                                                                                   |
| **Управление DNS-зонами**                                                                                                                           |                                                                   |                                                                                                                                                                            |
| Создание зоны                                                                                                                                       |                             `create`                              | `editor` или `dns.editor` на каталог, а также `vpc.user` на этот каталог или сеть {{ vpc-short-name }}, если зона внутренняя                                                                |
| Изменение, удаление зон                                                                                                                             |                        `update`, `delete`                         | `editor` или `dns.editor` на каталог, а также `vpc.user` на этот каталог или сеть {{ vpc-short-name }}, если зона внутренняя                                                                |
| Создание подзон                                                                                                                                     |                             `create`                              | `editor` или `dns.editor` на каталог, где находится зона, частями которой будут создаваемые подзоны, а также `vpc.user` на этот каталог или сеть {{ vpc-short-name }}, если зона внутренняя |
| **Управление ресурсными записями**                                                                                                                  |                                                                   |                                                                                                                                                                            |
| Создание ресурсных записей в DNS-зоне                                                                                                               |                             `create`                              | `editor` или `dns.editor` на каталог или зону                                                                                                                              |
| Изменение, удаление ресурсных записей                                                                                                               |                        `update`, `delete`                         | `editor` или `dns.editor`                                                                                                                                                  |
| **Управление доступом к DNS-зонам**                                                                                                                 |                                                                   |                                                                                                                                                                            |
| [Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на DNS-зоны | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` или `dns.admin` на каталог или зону                                                                                                                                |

Чтобы ограничить доступ пользователям, назначайте им роли на отдельные зоны или подзоны. 

#### Что дальше {#next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
