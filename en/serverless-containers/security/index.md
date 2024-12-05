# Access management in {{ serverless-containers-name }}

{{ serverless-containers-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `serverless-containers.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To assign a role for a [container](../concepts/container.md), use the {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/container/add-access-binding.md), [API](../api-ref/containers/authentication.md), or [{{ TF }}]({{ tf-provider-resources-link }}/serverless_container_iam_binding).

## Which roles exist in the service {#roles-list}

The list below shows all roles considered when verifying access permissions in {{ serverless-containers-name }}.

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