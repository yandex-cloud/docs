---
title: SQL queries in {{ mmg-full-name }}
description: '{{ mmg-name }} allows you to connect to the {{ SD }} cluster databases and run SQL queries via the {{ yandex-cloud }} management console. To do this, log in to the management console, open the relevant cluster page, and select the WebSQL tab.'
---

# SQL queries in {{ websql-full-name }}

You can use [{{ websql-full-name }}](../../websql) to run SQL queries on your {{ mmg-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters and work with their databases, tables, schemas, and queries. This service runs in the browser, requires no extra login, and simplifies work by providing hints for SQL commands.

To connect to a cluster from {{ websql-name }}, you must enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable this option when [creating](cluster-create.md) or [updating](update.md#change-additional-settings) your cluster.

The {{ mmg-name }} cluster automatically creates a [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) connection for each database user, enabling database access from {{ websql-name }}. You can also [create a new connection](../../websql/operations/create-connection.md#connect-cluster) if needed.

To connect to a database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the required connection.
  
      The connection will open in {{ websql-name }}. To open the query editor, select the required database.
    
{% endlist %}

For more details on working with {{ websql-name }}, see [these guides](../../websql/operations/index.md).
