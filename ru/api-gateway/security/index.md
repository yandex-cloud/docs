---
title: Управление доступом в {{ api-gw-full-name }}
description: Управление доступом в сервисе API-шлюзов, поддерживающим спецификацию OpenAPI 3.0 — {{ api-gw-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ api-gw-name }} (API-шлюзам), назначьте пользователю нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако).
---

# Управление доступом в {{ api-gw-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `api-gateway.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль на облако:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

Подробнее о назначении ролей см. в документации сервиса [{{ iam-full-name }}](../../iam/operations/roles/grant.md).

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [API-шлюз](../concepts/index.md) роль можно назначить через {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/add-access-binding.md) или [API](../api-ref/apigateway/authentication.md).

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ api-gw-name }}.

### Сервисные роли {#service-roles}

{% include [api-gateway](../../_mermaid/roles/api-gateway.md) %}

#### api-gateway.auditor {#api-gateway-auditor}

{% include [api-gateway.auditor](../../_roles/api-gateway/auditor.md) %}

#### api-gateway.viewer {#api-gateway-viewer}

{% include [api-gateway.viewer](../../_roles/api-gateway/viewer.md) %}

#### api-gateway.editor {#api-gateway-editor}

{% include [api-gateway.editor](../../_roles/api-gateway/editor.md) %}

#### api-gateway.websocketWriter {#api-gateway-websocketwriter}

{% include [api-gateway.websocketWriter](../../_roles/api-gateway/websocketWriter.md) %}

#### api-gateway.websocketBroadcaster {#api-gateway-websocketBroadcaster}

{% include [api-gateway.websocketBroadcaster](../../_roles/api-gateway/websocketBroadcaster.md) %}

#### api-gateway.admin {#api-gateway-admin}

{% include [api-gateway.admin](../../_roles/api-gateway/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}