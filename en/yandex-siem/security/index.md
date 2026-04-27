---
title: Access management in {{ yandex-siem-full-name }}
description: Access management in {{ yandex-siem-full-name }}, a monitoring and incident response service. This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ yandex-siem-full-name }}

In this section, you will learn about the following:
* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

### Service roles {#service-roles}

#### ycem.editor {#ycem-editor}

The `ycem.editor` role grants full access to the {{ yandex-siem-full-name }} features:

* Viewing investigations and query results.
* Creating, editing, and deleting investigations.
* Creating and running queries.
* Working with templates.
* Managing access permissions.
* Configuring a {{ yandex-siem-full-name }} instance.

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md)
* [How to revoke a role](../../iam/operations/roles/revoke.md)
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
