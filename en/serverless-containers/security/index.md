# Access management in {{ serverless-containers-name }}

{{ serverless-containers-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [container](../concepts/container.md) via the YC CLI or {{ yandex-cloud }} API.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ serverless-containers-name }} service.

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
