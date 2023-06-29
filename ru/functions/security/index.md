---
title: "Управление доступом в {{ sf-name }}"
description: "Управление доступом сервиса для запуска приложений без создания и обслуживания виртуальных машин — {{ sf-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ sf-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) и [функцию](../concepts/function.md). Роли, назначенные на облако или каталог, действуют и на функции, которые находятся в них.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ sf-name }}.

### Сервисные роли {#service-roles}

{% include [functions-roles-viewer](../../_includes/roles-functions-viewer.md) %}

{% include [functions-roles-auditor](../../_includes/roles-functions-auditor.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

{% include [functions-roles-editor](../../_includes/roles-functions-editor.md) %}

{% include [functions-roles-mdbproxy](../../_includes/roles-functions-mdbproxy.md) %}

{% include [functions-roles-admin](../../_includes/roles-functions-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
