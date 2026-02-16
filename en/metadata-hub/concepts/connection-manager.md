---
title: Connecting {{ connection-manager-name }} to a database
description: With {{ connection-manager-name }}, you can manage database connection parameters.
---

# Connection


{% include [connection](../../_includes/metadata-hub/connection-definition.md) %}


![backups](../../_assets/metadata-hub/conn-man-diagramm.svg)

You can also [create new connections](../../metadata-hub/operations/create-connection.md#on-premise-connection) with secure storage of custom database installation passwords and use them in {{ yandex-cloud }} services available to you.

{% note tip %}

When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

{% endnote %}

You can [configure access to connections](../security/index.md) using {{ connection-manager-full-name }} roles. You can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or separate [connection](../operations/connection-access.md). They will also apply to nested resources.

In terms of management, there are two types of connections:

* _Managed_: Created automatically by a managed database cluster.
* _Manual_: Created by a user or a third-party service.

## Dependencies {#dependencies}

Connections can have _dependencies_, which indicate services that use or manage connections. Dependencies are [listed](../operations/view-connection.md#dependencies) in a separate section for each connection. There are two types of dependencies: use dependencies and connection management dependencies (for managed connections).

You cannot delete a connection you [created manually](../quickstart/connection-manager.md#database-connections) as long as it has at least one dependency.
You cannot edit or delete [managed connections](../quickstart/connection-manager.md#mdb-integration) manually, as they contain current data for connection to the cluster that created them.

Examples of dependencies:

#|
|| Dependency | Type ||
|| Managed database clusters that got connections automatically when created | Management dependency ||
|| Backups of managed database clusters that are using the connection. After you delete the cluster that created the connection, its backups are stored for another week; therefore, the connection does not get deleted right away together with the cluster. | Use dependency ||
|#
