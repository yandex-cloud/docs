---
title: Migrating a {{ data-transfer-full-name }} transfer and endpoints to a different availability zone
description: Follow this tutorial to migrate your endpoints and transfers to a different availability zone.
---

# Migrating a {{ data-transfer-name }} transfer and endpoints to a different availability zone


You can migrate [transfers](../../concepts/index.md#transfer) from one [availability zone](../../../overview/concepts/geo-scope.md) to another. The migration method depends on which service is used as the transfer endpoint: a [custom DB installation](#on-premise) or a [{{ yandex-cloud }} managed DB](#managed-service). If [migrating data](../../tutorials/index.md#migration) between a custom installation and a managed DB, you should first move the endpoint based on a custom installation and then the one based on a managed DB.

## Moving an endpoint based on a custom installation {#on-premise}

1. If the [transfer type](../../concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, [deactivate](../transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.
1. [Create a subnet](../../../vpc/operations/subnet-create.md) in the availability zone you want to move your endpoint to.
1. If your custom installation is hosted on a {{ yandex-cloud }} VM, follow these steps:

   
   1. [Stop the VM](../../../compute/operations/vm-control/vm-stop-and-start.md#stop).
   1. [Move the VM to a different availability zone](../../../compute/operations/vm-control/vm-change-zone.md).
   1. [Run the VM](../../../compute/operations/vm-control/vm-stop-and-start.md#start).


1. [Specify a new subnet](index.md#update) in the settings of the endpoint with your custom installation.
1. If you deactivated the transfer earlier, [activate](../transfer.md#activate) it and wait for its status to change to {{ dt-status-repl }}.

   {% note warning %}

   If your transfer includes an endpoint based on a managed DB, [migrate](#managed-service) this endpoint to a different availability zone before activating the transfer.

   {% endnote %}

## Moving an endpoint based on a managed DB {#managed-service}

1. Move your cluster hosts to a different availability zone. For more information, see the documentation for the following services:

   * [{{ mch-full-name }}](../../../managed-clickhouse/operations/host-migration.md)
   * [{{ mmg-full-name }}](../../../storedoc/operations/host-migration.md)
   * [{{ mmy-full-name }}](../../../managed-mysql/operations/host-migration.md)
   * [{{ mos-full-name }}](../../../managed-opensearch/operations/host-migration.md)
   * [{{ mpg-full-name }}](../../../managed-postgresql/operations/host-migration.md)   * [{{ ydb-full-name }}](../../../ydb/operations/migration-to-an-availability-zone.md)

1. If the [transfer type](../../concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, restart the transfer for it to get the information about the new cluster topology. You do not need to restart {{ dt-type-copy }} transfers, as information about the new topology is provided automatically while activating them.

   {% include [reactivate-a-transfer](../../../_includes/data-transfer/reactivate-a-transfer.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
