---
title: Resources for which you can assign roles in {{ iam-full-name }}
description: In this tutorial, you will learn which {{ yandex-cloud }} resources you can assign roles for.
---

# Resources that roles can be assigned for


{{ yandex-cloud }} uses [roles](./roles.md) to manage access permissions.

{% include [operate-via-roles-paragraph](../../../_includes/iam/operate-via-roles-paragraph.md) %}

## Inheriting access permissions {#permission-inheritance}

Roles are [assigned](../../operations/roles/grant.md) for {{ yandex-cloud }} [resources](../../../resource-manager/concepts/resources-hierarchy.md). The standard permission [inheritance](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) model applies to resources of most {{ yandex-cloud }} [services](../../../overview/concepts/services.md):

{% include [basic-role-inheritance-chain](../../../_includes/basic-role-inheritance-chain.md) %}

### Exceptions to permission inheritance rules {#inheritance-exceptions}

Some {{ yandex-cloud }} services do not support the standard role inheritance model. Here are the services in which you need to specifically assign roles to users:

* [{{ billing-name }}](../../../billing/security/index.md)
* [{{ tracker-full-name }}]({{ link-tracker-cloudless }}access)
* [{{ datalens-full-name }}](../../../datalens/security/index.md)
* [{{ wiki-full-name }}]({{ link-wiki-cloudless }}/page-management/access-setup)
* [{{ forms-full-name }}]({{ link-forms-cloudless }}/access)
* [{{ ml-platform-full-name }}](../../../datasphere/security/index.md)
* [{{ speechsense-full-name }}](../../../speechsense/security/index.md)

## Granular role assignment {#granular-assignment}

Some {{ yandex-cloud }} services allow you to assign roles in a more granular way, i.e., for individual resources within a service. For example, in [{{ compute-full-name }}](../../../compute/index.yaml), you can assign roles for the following resources:

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

Note that some [interfaces](../../../overview/concepts/interfaces.md) do not support granular assignment of roles for resources. For example, you can assign a role for a {{ compute-name }} [instance group](../../../compute/concepts/instance-groups/index.md) using the [management console]({{ link-console-main }}), [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or [API](../../../api-design-guide/index.yaml), but not with [{{ TF }}](../../../terraform/index.yaml).

For more information about resources you can assign roles for, available roles, and specifics of their assignment, see the **Access management** page for the relevant service, e.g., [{#T}](../../../compute/security/index.md).