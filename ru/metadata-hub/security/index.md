---
title: Управление доступом в {{ metadata-hub-full-name }}
description: Управление доступом в сервисе {{ metadata-hub-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ metadata-hub-name }}


{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть [роль](./connection-manager-roles.md#connection-manager-admin) `connection-manager.admin` (назначение роли на [подключения](../concepts/connection-manager.md)), [роль](./data-catalog-roles.md#data-catalog-admin) `data-catalog.admin` (назначение роли на [каталоги метаданных](../concepts/data-catalog.md)) или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ metadata-hub-name }}, назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

Роль на [подключение](../concepts/connection-manager.md) и [каталог метаданных](../concepts/data-catalog.md) можно назначить в [консоли управления]({{ link-console-main }}).

Роль на отдельный [кластер](../concepts/metastore.md) можно назначить в [консоли управления]({{ link-console-main }}) или через [CLI](../../cli).

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


{% include [metastore-trademark](../../_includes/metadata-hub/metastore-trademark.md) %}
