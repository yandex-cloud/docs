---
title: Access management in {{ search-api-full-name }}
description: Access management in {{ search-api-full-name }}. This section covers the resources supporting role assignment, the roles this service has, and the required roles for specific actions.
---

# Access management in {{ search-api-name }}

In this section, you will learn:
* [What resources you can assign a role for](#resources).
* [Roles existing in this service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Resources supporting role assignment {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles existing in this service {#roles-list}

### Service roles {#service-roles}

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

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}