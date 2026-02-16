---
title: Access management in {{ quota-manager-full-name }}
description: 'Managing your resource quotas: {{ quota-manager-full-name }}. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.'
---

# Access management in {{ quota-manager-name }}

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Roles this service has {#roles-list}

{% include [quota-manager](../../_mermaid/roles/quota-manager.md) %}

### Service roles {#service-roles}

#### quota-manager.requestOperator {#quota-manager-requestoperator}

{% include [roles-quota-manager-requestoperator](../../_roles/quota-manager/requestOperator.md) %}

#### quota-manager.viewer {#quota-manager-viewer}

{% include [roles-quota-manager-viewer](../../_roles/quota-manager/viewer.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

#### What's next {#next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
