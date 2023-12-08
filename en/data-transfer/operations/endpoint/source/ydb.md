---
title: "How to configure a {{ ydb-full-name }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ ydb-full-name }} source endpoint when creating or updating it in {{ data-transfer-full-name }}."
---

# Configuring a {{ ydb-name }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:
* {{ ydb-full-name }} DB connection settings. These are required parameters.
* Transfer path list (for tables and directories).

## Settings {#settings}


{% note warning %}

To create or edit an endpoint of a managed database, you need the [`ydb.viewer` role](../../../../ydb/security/index.md#ydb-viewer) or the primitive [`viewer` role](../../../../iam/concepts/access-control/roles.md#viewer) issued for the folder hosting a cluster of this managed database.

{% endnote %}


{% list tabs %}

- Management console

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}


  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}


  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**: Add paths to the {{ ydb-name }} tables and directories to transfer.

    Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** field in the [transfer settings](../../transfer.md#update).

    For {{ dt-type-copy }} transfers, you may skip specifying paths. In this case, all tables will be transferred.

    For {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfers, specifying paths is required, including when you replicate all tables.

{% endlist %}
