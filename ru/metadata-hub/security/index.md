---
title: "Управление доступом в {{ metadata-hub-full-name }}"
description: "Управление доступом в сервисе {{ metadata-hub-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом

{% include notitle [preview](../../_includes/note-preview.md) %}

В этом разделе вы узнаете:
* [На какие ресурсы можно назначить роль](#resources).
* [Какие роли действуют в сервисе](#roles-list).
* [Какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `connection-manager.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/quickstart.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [подключение](../concepts/connection-manager.md). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Роль на подключение можно назначить в консоли управления.

## Какие роли действуют в сервисе {{ connection-manager-name }}{#roles-list}

Для управления правами доступа к подключениям вы можете использовать роли сервиса {{ metadata-hub-full-name }} (_сервисные роли_) и роли {{ yandex-cloud }} (_примитивные роли_).

### Сервисные роли для управления подключениями с помощью {{ connection-manager-full-name }} {#service-roles}

С помощью сервисных ролей {{ connection-manager-full-name }} вы сможете просматривать несекретные данные подключений и управлять подключениями. Просматривать секретные данные подключений, такие как пароли доступа к БД, можно в сервисе [{{ lockbox-full-name }}](../../lockbox/index.yaml). Для этого дополнительно необходима [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

#### connection-manager.auditor {#connection-manager-auditor}

{% include [connection-manager.auditor](../../_roles/connection-manager/auditor.md) %}

#### connection-manager.viewer {#connection-manager-viewer}

{% include [connection-manager.viewer](../../_roles/connection-manager/viewer.md) %}


#### connection-manager.editor {#connection-manager-editor}

{% include [connection-manager.editor](../../_roles/connection-manager/editor.md) %}

#### connection-manager.admin {#connection-manager-admin}

{% include [connection-manager.admin](../../_roles/connection-manager/admin.md) %}



### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

### Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                                                      | Необходимые роли                     |
|---------------------------------------------------------------|--------------------------------------|
| Получить информацию о подключениях                            | `connection-manager.viewer`          |
| Получить список подключений                                   | `connection-manager.viewer`          | 
| Создать подключение                                           | `connection-manager.editor`          | 
| Изменить подключение                                          | `connection-manager.editor`          |
| Удалить подключение                                           | `connection-manager.editor`          |
| Установить права доступа к подключению                        | `connection-manager.admin`           |
| Изменить права доступа к подключению                          | `connection-manager.admin`           |

## Что дальше {what-is-next}

* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).