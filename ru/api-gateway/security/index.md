---
title: "Управление доступом в {{ api-gw-full-name }}"
description: "Управление доступом в сервисе API-шлюзов, поддерживающим спецификацию OpenAPI 3.0 — {{ api-gw-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ api-gw-name }} (API-шлюзам), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако)."
---

# Управление доступом в {{ api-gw-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ api-gw-name }} (API-шлюзам), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть [назначена](../../iam/operations/roles/grant.md) на родительский ресурс (каталог или облако) и на организацию.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль на облако:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

Подробнее о назначении ролей см. в документации сервиса [{{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ api-gw-name }}.

### Сервисные роли {#service-roles}

{% include [api-gateway-viewer](../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../_includes/roles-api-gateway-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
