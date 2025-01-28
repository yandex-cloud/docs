---
title: Connecting {{ metadata-hub-name }} to a database
description: With {{ connection-manager-full-name }}, you can manage database connection parameters.
---

# Connection

{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [connection](../../_includes/metadata-hub/connection-definition.md) %}

![backups](../../_assets/metadata-hub/conn-man-diagramm.svg)

You can also [create new connections](../../metadata-hub/operations/create-connection.md) with secure storage of custom database installation passwords and use them in {{ yandex-cloud }} services available to you.

You can [configure access to connections](../security/index.md) using {{ connection-manager-full-name }} roles. You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or separate [connection](../operations/connection-access.md). They will also apply to nested resources.