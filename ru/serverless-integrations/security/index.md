---
title: Управление доступом в {{ si-full-name }}
description: Управление доступом в сервисе {{ si-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ si-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

Кроме того, роли на [шину](../concepts/eventrouter/bus.md), [коннектор](../concepts/eventrouter/connector.md) и [правило](../concepts/eventrouter/rule.md) {{ er-name }} может назначить пользователь, у которого на эти ресурсы есть роль `serverless.eventrouter.admin`.

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

С помощью {{ yandex-cloud }} [CLI](../../cli/index.yaml) и [API](../../api-design-guide/index.yaml) роль можно назначить на отдельные ресурсы сервиса:
* [шина](../concepts/eventrouter/bus.md);
* [коннектор](../concepts/eventrouter/connector.md);
* [правило](../concepts/eventrouter/rule.md).

## Какие роли действуют в сервисе {{ si-name }} {#roles-list}

Для управления правами доступа вы можете использовать роли сервиса {{ si-name }} (_сервисные роли_) и роли {{ yandex-cloud }} (_примитивные роли_).

### Сервисные роли {#service-roles}

{{ yandex-cloud }} поддерживает свой список ролей для каждой функциональности, включенной в состав {{ si-name }}. Подробнее читайте в разделах:

* [Роли для работы с {{ er-full-name }}](./eventrouter.md).
* [Роли для работы с {{ sw-full-name }}](./workflows.md).
* [Роли для работы с {{ api-gw-full-name }}](../../api-gateway/security/index.md#service-roles).

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Что дальше {what-is-next}

* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)