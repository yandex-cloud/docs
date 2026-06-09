---
title: Управление доступом в {{ backup-full-name }}
description: Управление доступом в сервисе, предоставляющим решение для резервного копирования данных в {{ yandex-cloud }} — {{ backup-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Управление доступом в {{ backup-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие политики авторизации действуют в сервисе](#access-policies).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `backup.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

В дополнение к ролям в {{ iam-full-name }} предусмотрен еще один механизм контроля доступа — [политики авторизации](#access-policies), которые позволяют запрещать определенные действия с ресурсами {{ yandex-cloud }} даже тогда, когда такие действия явно разрешены имеющимися у пользователей ролями.

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} или с помощью CLI вы можете назначить роль на [облако](*clouds) или [каталог](*folders). Назначенные роли будут действовать и на вложенные ресурсы.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-backup](../../_mermaid/roles/backup.md) %}

### Сервисные роли {#service-roles}

#### backup.auditor {#backup-auditor}

{% include [backup.auditor](../../_roles/backup/auditor.md) %}

#### backup.viewer {#backup-viewer}

{% include [backup.viewer](../../_roles/backup/viewer.md) %}

#### backup.user {#backup-user}

{% include [backup.user](../../_roles/backup/user.md) %}

#### backup.editor {#backup-editor}

{% include [backup.editor](../../_roles/backup/editor.md) %}

#### backup.admin {#backup-admin}

{% include [backup.admin](../../_roles/backup/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Политики авторизации {#access-policies}

[Политики авторизации](*access_policies) дополняют систему ролей и позволяют сделать управление доступом в {{ yandex-cloud }} более гибким.

Сервис {{ backup-name }} позволяет назначать следующие политики авторизации:

{% include [backup-access-policies](../../_includes/backup/backup-access-policies.md) %}

Политики авторизации могут быть назначены на уровне [каталога](*folders), [облака](*clouds) или [организации](*organizations) и позволяют запрещать соответствующие действия в этом каталоге, облаке или организации. Такой запрет действует даже в том случае, если пользователю явным образом назначены [роли](#roles-list), разрешающие выполнение указанных операций.

Подробнее о том, как создать для ресурса политику авторизации, читайте в разделе [{#T}](../../iam/operations/access-policies/assign.md).

[*access_policies]: _Политики авторизации_ — это механизм контроля доступа {{ iam-full-name }}, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами {{ yandex-cloud }}](../../overview/roles-and-resources.md). Политики дополняют систему [ролей](../../iam/concepts/access-control/roles.md) и позволяют сделать [управление доступом](../../iam/concepts/access-control/index.md) более гибким. [Подробнее](../../iam/concepts/access-control/access-policies.md) о политиках авторизации в {{ yandex-cloud }}.

[*folders]: [Подробнее](../../resource-manager/concepts/resources-hierarchy.md#folder) о каталогах.

[*clouds]: [Подробнее](../../resource-manager/concepts/resources-hierarchy.md#cloud) об облаках.

[*organizations]: [Подробнее](../../organization/concepts/organization.md) об организациях.