---
title: "Access management in {{ search-api-full-name }}"
description: "Access management in the {{ search-api-full-name }} search service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ search-api-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control-without-service-account.md) %}

## Which roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### search-api.executor {#search-api-executor}

{% include [searchapi-executor](../../_roles/search-api/executor.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}