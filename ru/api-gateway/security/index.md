---
title: "Управление доступом в {{ api-gw-full-name }}"
description: "Управление доступом в сервисе API-шлюзов, поддерживающим спецификацию OpenAPI 3.0 — {{ api-gw-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ api-gw-name }} (API-шлюзам), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако)."
---

# Управление доступом в {{ api-gw-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями.
Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ api-gw-name }} (API-шлюзам), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако).

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Роли {#roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ api-gw-name }}.

{% include [api-gateway-viewer](../../_includes/roles-api-gateway-viewer.md) %}

{% include [api-gateway-editor](../../_includes/roles-api-gateway-editor.md) %}

{% include [api-gateway-websocket-writer](../../_includes/roles-api-gateway-websocket-writer.md) %}

{% include [api-gateway-admin](../../_includes/roles-api-gateway-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

Пользователь с ролью `{{ roles-viewer }}` может просматривать информацию о ресурсах, например посмотреть список API-шлюзов.

### {{ roles-editor }} {#editor}

Пользователь с ролью `{{ roles-editor }}` может управлять API-шлюзами, например создать или удалить API-шлюз.

Роль `{{ roles-editor }}` включает в себя все разрешения роли `{{ roles-viewer }}`.

### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например разрешить другим пользователям редактировать API-шлюзы.

Роль `{{ roles-admin }}` включает в себя все разрешения роли `{{ roles-editor }}`.
