---
title: Access management in {{ si-full-name }}
description: Access management in {{ si-full-name }}. This section describes the resources you can assign a role for, the roles this service has, and the roles required for specific actions.
---

# Access management in {{ si-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

In addition, roles for an {{ er-name }} [bus](../concepts/eventrouter/bus.md), [connector](../concepts/eventrouter/connector.md), or [rule](../concepts/eventrouter/rule.md) can be assigned by a user with the `serverless.eventrouter.admin` role for these resources.

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can use the {{ yandex-cloud }} [CLI](../../cli/index.yaml) or [API](../../api-design-guide/index.yaml) to assign roles for individual service resources:
* [Bus](../concepts/eventrouter/bus.md)
* [Connector](../concepts/eventrouter/connector.md)
* [Rule](../concepts/eventrouter/rule.md)

## Roles existing in {{ si-name }} {#roles-list}

You can use {{ si-name }} roles (_service roles_) and {{ yandex-cloud }} roles (_primitive roles_) to manage access permissions.

### Service roles {#service-roles}

{{ yandex-cloud }} supports a separate list of roles for each {{ si-name }} component. For more information, see:

* [Roles to work with {{ er-full-name }}](./eventrouter.md).

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What's next {what-is-next}

* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
