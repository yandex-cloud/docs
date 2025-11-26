---
title: SQL queries in {{ mmg-full-name }}
description: '{{ mmg-name }} allows you to connect and send SQL queries to databases in your {{ SD }} cluster from the {{ yandex-cloud }} management console. To do this, log in to the management console, open the relevant cluster page, and go to the WebSQL tab.'
---

# SQL queries in {{ websql-full-name }}

You can send SQL queries to databases in a {{ mmg-name }} cluster using [{{ websql-full-name }}](../../websql).

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with DBs, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by suggesting prompts.

To connect from {{ websql-name }} to a {{ mmg-name }} cluster, create a connection:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click the cluster name.
1. [Enable](update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the connection parameters:
    * **Connection name**.
    * **Database type**: {{ MG }}.
    * **Cluster**: Defaults to your current {{ SD }} cluster.
    * **Username** you will use to connect to the database in the cluster.
    * User **Password**.
    * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them.
1. Click **Create**.

To open the SQL editor, click the created connection on the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.

For more information about working with {{ websql-name }}, see its [documentation](../../websql/operations/index.md).
