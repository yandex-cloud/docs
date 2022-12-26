---
title: "Access management in {{ speechkit-full-name }}"
description: "Access management in {{ speechkit-full-name }}: a speech technology, speech recognition, and synthesis service. Permissions are granted when assigning a role. A role can be assigned for a folder or a cloud: all cloud permissions are inherited. To use the service, you need one of the following roles: editor, admin, or resource-manager.cloud.owner."
---

# Access management in {{ speechkit-name }}

In this section, you'll learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control-without-service-account.md) %}

## What roles exist in the service {#roles-list}

### Service roles {#service-roles}

#### {{ roles-speechkit-stt }} {#ai-speechkit-stt-user}

{% include notitle [roles-speechkit-stt-user](../../_includes/roles-speechkit-stt-user.md) %}

#### {{ roles-speechkit-tts }} {#ai-speechkit-tts-user}

{% include notitle [roles-speechkit-tts-user](../../_includes/roles-speechkit-tts-user.md) %}

For more information about service roles, see [{#T}](../../iam/concepts/access-control/roles.md) in the {{ iam-full-name }} service documentation.


### Roles of other services {#integration-roles}

When working with {{ speechkit-name }}, you may need roles of other services, for example, to upload results and source materials to an {{ objstorage-name }} bucket.

{% include [roles-integration](../../_includes/roles-integration-roles-speechkit.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md)
* [How to revoke a role](../../iam/operations/roles/revoke.md)
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md)
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance)
