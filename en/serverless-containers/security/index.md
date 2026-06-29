# Access management in {{ serverless-containers-name }}

{{ serverless-containers-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access permissions.

In this section, you will learn about:

* [Resources supporting role assignment](#resources).
* [Roles this service has](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `serverless-containers.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

The ability to invoke and managing containers from specific [cloud networks](../../vpc/concepts/network.md#network) or IP addresses or associate containers with specific cloud networks may be limited by [access policies](../../iam/concepts/access-control/access-policies.md) at the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [organization](../../organization/concepts/organization.md) level. 

{% endnote %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To assign a role for a [container](../concepts/container.md), use the {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/container/add-access-binding.md), [API](../api-ref/containers/authentication.md), or [{{ TF }}]({{ tf-provider-resources-link }}/serverless_container_iam_binding).

## Roles this service has {#roles-list}

The list below shows all the roles used for access control in {{ serverless-containers-name }}.

{% include [serverless-containers](../../_mermaid/roles/serverless-containers.md) %}

### Service roles {#service-roles}

#### serverless-containers.auditor {#serverless-containers-auditor}

{% include [containers-auditor](../../_roles/serverless-containers/auditor.md) %}

#### serverless-containers.viewer {#serverless-containers-viewer}

{% include [containers-viewer](../../_roles/serverless-containers/viewer.md) %}

#### serverless-containers.editor {#serverless-containers-editor}

{% include [containers-editor](../../_roles/serverless-containers/editor.md) %}

#### serverless-containers.admin {#serverless-containers-admin}

{% include [containers-admin](../../_roles/serverless-containers/admin.md) %}

#### serverless-containers.containerInvoker {#serverless-containers-containerinvoker}

{% include [containers-containerinvoker](../../_roles/serverless-containers/containerInvoker.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}
