---
title: "Tutorial on setting up a {{ GP }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ GP }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ GP }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mgp-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mgp-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mgp.viewer }}` role](../../../../managed-greenplum/security/index.md#mgp-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed Greenplum](../../../../_includes/data-transfer/necessary-settings/ui/managed-greenplum.md) %}

{% endlist %}


## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Greenplum UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-greenplum.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete tables included in the transfer (used by default).

      Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

   * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but leave the schema.

      Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

{% endlist %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}
