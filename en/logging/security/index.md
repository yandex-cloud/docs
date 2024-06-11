# Access management in {{ cloud-logging-name }}

{{ cloud-logging-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `logging.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role via the YC CLI or {{ yandex-cloud }} API for individual resources of the service:

{% include notitle [logging-resources](../../_includes/iam/resources-with-access-control/logging.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ cloud-logging-name }} service.

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
