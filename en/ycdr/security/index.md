---
title: Access management in {{ ycdr-full-name }}
description: Access management in {{ ycdr-full-name }}, an incident monitoring and response service. This section describes the resources for which you can assign a role and the roles existing in the service.
---

# Access management in {{ ycdr-name }}

In this section, you will learn about:
* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `ycdr.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

### Service roles {#service-roles}

#### ycdr.admin {#ycdr-admin}

{% include [ycdr.admin](../../_roles/ycdr/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
