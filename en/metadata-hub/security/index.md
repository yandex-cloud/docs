---
title: Access management in {{ metadata-hub-full-name }}
description: Access management in {{ metadata-hub-full-name }}. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ metadata-hub-name }}


{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `connection-manager.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for an [organization](../../organization/quickstart.md), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or [connection](../concepts/connection-manager.md). The roles assigned for organizations, clouds, or folders also apply to nested resources.

You can assign a role for a connection in the [management console]({{ link-console-main }}).

## Which roles exist in {{ metadata-hub-name }} {#roles-list}

You can use {{ metadata-hub-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage access permissions.

### Service roles {#service-roles}

{{ yandex-cloud }} supports a separate list of roles for each service in {{ metadata-hub-name }}. For more information, see:

* [Roles to manage connections using {{ connection-manager-name }}](connection-manager-roles.md).
* [Roles to work with with metadata in a {{ metastore-full-name }} cluster](metastore-roles.md).
* [Roles to work with {{ schema-registry-name }}](schema-registry-roles.md).

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What's next {what-is-next}

* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

