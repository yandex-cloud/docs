---
title: Управление доступом в {{ metadata-hub-full-name }}
description: Управление доступом в сервисе {{ metadata-hub-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ metadata-hub-name }}


{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `connection-manager.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/quickstart.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или [подключение](../concepts/connection-manager.md). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Роль на подключение можно назначить в [консоли управления]({{ link-console-main }}).

## Какие роли действуют в сервисе {{ metadata-hub-name }} {#roles-list}

Для управления правами доступа вы можете использовать роли сервиса {{ metadata-hub-name }} (_сервисные роли_) и роли {{ yandex-cloud }} (_примитивные роли_).

### Сервисные роли {#service-roles}

{{ yandex-cloud }} поддерживает свой список ролей для каждого сервиса, включенного в состав {{ metadata-hub-name }}. Подробнее читайте в соответствующих разделах:

* [Роли для управления подключениями с помощью {{ connection-manager-name }}](connection-manager-roles.md).
* [Роли для работы с метаданными в кластере {{ metastore-name }}](metastore-roles.md).
* [Роли для работы со {{ schema-registry-name }}](schema-registry-roles.md).
* [Роли для работы с {{ data-catalog-full-name }}](data-catalog-roles.md).

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Что дальше {what-is-next}

* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

