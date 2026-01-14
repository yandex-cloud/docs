---
title: SQL queries in {{ mmg-full-name }}
description: '{{ mmg-name }} allows you to connect to the {{ SD }} cluster databases and run SQL queries via the {{ yandex-cloud }} management console. To do this, log in to the management console, open the relevant cluster page, and go to the WebSQL tab.'
---

# SQL queries in {{ websql-full-name }}

You can use [{{ websql-full-name }}](../../websql) to send SQL queries to {{ mmg-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by prompting the user.

To connect from {{ websql-name }}, you must enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable this option when [creating a cluster](cluster-create.md) or [modifying a cluster](update.md#change-additional-settings).

In the {{ mmg-name }} cluster, a [{{ connection-manager-name }} connection](../../metadata-hub/concepts/connection-manager.md) is automatically created for each database user, which you can use to connect to the database from {{ websql-name }}. You can also [create a new connection](../../websql/operations/create-connection.md#connect-cluster) if you need one.

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster of interest.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the connection.
  
      The connection will open in {{ websql-name }}. To go to the query editor, select the required database.
    
{% endlist %}

For more information on how to work with {{ websql-name }}, see [these guides](../../websql/operations/index.md).
