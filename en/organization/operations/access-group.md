---
title: How to configure access for a {{ org-full-name }} user group to {{ yandex-cloud }}
description: In this article, you will learn how to configure access for a {{ org-name }} user group to {{ yandex-cloud }}.
---

## Configuring group access to {{ yandex-cloud }} {#access}

To enable group members to work with {{ yandex-cloud }} services, assign the appropriate [roles](../../iam/concepts/access-control/roles.md) to the group.

### Assigning a role for a separate resource {#access-services}

In the management console, you can assign a role for a cloud, folder, and other resources from the [list](../../iam/concepts/access-control/resources-with-access-control.md).

To grant a group access to a resource:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Assigning a role for an entire organization {#access-organization}

A role granted for the entire organization allows group members to manage any {{ yandex-cloud }} resources activated for the organization as per the role's permissions.

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}