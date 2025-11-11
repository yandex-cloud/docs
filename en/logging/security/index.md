# Access management in {{ cloud-logging-name }}

{{ cloud-logging-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access permissions.

In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles exist in this service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `logging.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles for individual resources within the service:

{% list tabs group=instructions %}

- CLI {#cli}

  You can use the [{{ yandex-cloud }} CLI](../../cli/cli-ref/logging/cli-ref/index.md) to assign roles for the following resources:

  * [Log group](../concepts/log-group.md)
  * [Log target](../operations/create-sink.md)

- API {#api}

  You can use the [{{ yandex-cloud }} API](../api-ref/authentication.md) to assign roles for the following resources:

  {% include notitle [logging-resources](../../_includes/iam/resources-with-access-control/logging.md) %}

{% endlist %}

## Roles this service has {#roles-list}

The list below shows all roles used for access control in {{ cloud-logging-name }}.

{% include [logging](../../_mermaid/roles/logging.md) %}

### Service roles {#service-roles}

#### logging.viewer {#logging-viewer}

{% include [logging.viewer](../../_roles/logging/viewer.md) %}

#### logging.editor {#logging-editor}

{% include [logging.editor](../../_roles/logging/editor.md) %}

#### logging.reader {#logging-reader}

{% include [logging.reader](../../_roles/logging/reader.md) %}

#### logging.writer {#logging-writer}

{% include [logging.writer](../../_roles/logging/writer.md) %}

#### logging.admin {#logging-admin}

{% include [logging.admin](../../_roles/logging/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}