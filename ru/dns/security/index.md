---
title: Управление доступом в {{ dns-full-name }}
description: Управление доступом в сервисе для управления зонами DNS и доменными именами ваших ресурсов — {{ dns-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ dns-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `dns.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [зону DNS](../concepts/dns-zone.md) роль можно назначить через {{ yandex-cloud }} [CLI](../../cli/cli-ref/dns/cli-ref/zone/add-access-binding.md), [API](../api-ref/authentication.md) или [{{ TF }}]({{ tf-provider-resources-link }}/dns_zone_iam_binding).

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/dns/security/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### dns.auditor {#dns-auditor}

{% include [roles-dns-auditor](../../_roles/dns/auditor.md) %}

#### dns.viewer {#dns-viewer}

{% include [roles-dns-viewer](../../_roles/dns/viewer.md) %}

#### dns.editor {#dns-editor}

{% include [roles-dns-editor](../../_roles/dns/editor.md) %}

#### dns.admin {#dns-admin}

{% include [roles-dns-admin](../../_roles/dns/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#required-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer` или `dns.admin` вместо `dns.editor`.

| Действие                                                                                                                                            |                              Методы                               | Необходимые роли                                                                                                                                                                            |
|:----------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Просмотр метаинформации**                                                                                                                         |                                                                   |                                                                                                                                                                                             |
| Просмотр информации о DNS-зонах                                                                                                                     |                           `get`, `list`                           | `dns.auditor` на этот ресурс                                                                                                                                                                |
| **Просмотр информации**                                                                                                                             |                                                                   |                                                                                                                                                                                             |
| Просмотр информации о DNS-зонах и ресурсных записях в них                                                                                           |                  `get`, `list`, `listRecordSets`                  | `viewer` или `dns.viewer` на этот ресурс                                                                                                                                                    |
| **Управление DNS-зонами**                                                                                                                           |                                                                   |                                                                                                                                                                                             |
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
