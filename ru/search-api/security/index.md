---
title: Управление доступом в {{ search-api-full-name }}
description: Управление доступом в сервисе для поиска — {{ search-api-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ search-api-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### search-api.webSearch.user {#search-api-webSearch-user}

{% include [search-api-webSearch-user](../../_roles/search-api/webSearch/user.md) %}

#### search-api.executor {#search-api-executor}

{% include [searchapi-executor](../../_roles/search-api/executor.md) %}

#### search-api.auditor {#search-api-auditor}

{% include [searchapi-auditor](../../_roles/search-api/auditor.md) %}

#### search-api.viewer {#search-api-viewer}

{% include [searchapi-viewer](../../_roles/search-api/viewer.md) %}

#### search-api.editor {#search-api-editor}

{% include [searchapi-editor](../../_roles/search-api/editor.md) %}

#### search-api.admin {#search-api-admin}

{% include [searchapi-admin](../../_roles/search-api/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}