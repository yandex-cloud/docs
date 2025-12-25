---
title: Access management in {{ metadata-hub-full-name }}
description: Access management in {{ metadata-hub-full-name }}. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Access management in {{ metadata-hub-name }}


{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `connection-manager.admin` [role](./connection-manager-roles.md#connection-manager-admin) (to assign roles for [connections](../concepts/connection-manager.md)), the `data-catalog.admin` [role](./data-catalog-roles.md#data-catalog-admin) (to assign roles for [metadata catalogs](../concepts/data-catalog.md)), or one of the following roles:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [connection](../concepts/connection-manager.md) or [metadata catalog](../concepts/data-catalog.md) in the [management console]({{ link-console-main }}).

## Roles existing in {{ metadata-hub-name }} {#roles-list}

You can use {{ metadata-hub-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage access permissions.

### Service roles {#service-roles}

{{ yandex-cloud }} supports a separate list of roles for each service in {{ metadata-hub-name }}. For more information, see:

* [Roles to manage connections using {{ connection-manager-name }}](connection-manager-roles.md).
* [Roles to work with metadata in a {{ metastore-full-name }} cluster](metastore-roles.md).
* [Roles to work with {{ schema-registry-name }}](schema-registry-roles.md).
* [Roles to work with {{ data-catalog-full-name }}](data-catalog-roles.md).

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What's next {what-is-next}

* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


{% include [metastore-trademark](../../_includes/metadata-hub/metastore-trademark.md) %}
