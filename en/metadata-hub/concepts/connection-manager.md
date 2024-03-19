# Connection

{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [connection](../../_includes/metadata-hub/connection-definition.md) %}

![backups](../../_assets/metadata-hub/conn-man-diagramm.svg)

You can also [create new connections](../../metadata-hub/operations/create-connection.md) with secure storage of passwords for on-premise database installations and use them in available services of {{ yandex-cloud }}.
You can [configure access to connections](../security/index.md) using the {{ connection-manager-full-name }} roles. Roles can be assigned to [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) or to [connections](../operations/connection-access.md). They will also apply for nested resources.