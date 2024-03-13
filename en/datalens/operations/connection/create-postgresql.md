---
title: "How to create a {{ PG }} connection in {{ datalens-full-name }}"
description: "In this tutorial, you will learn how to connect to {{ PG }} in {{ datalens-full-name }}."
---

# Creating a {{ PG }} connection


{% include [connection-note](../../../_includes/datalens/datalens-connection-note-ip.md) %}

To create a {{ PG }} connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select a **{{ PG }}** connection.


1. Select the connection type:

   {% list tabs group=connection %}

   - Select in organization {#organization}

      {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select.md) %}

      - **Cluster**: Specify a cluster from the list of available {{ PG }} clusters. Cluster settings must have the **{{ datalens-short-name }} access** option enabled. If you do not have an available cluster, click **Create new**.

         {% include [datalens-cluster-list](../../../_includes/datalens/datalens-cluster-list.md) %}

      * **Hostname**: Select the host name from the list of hosts available in the {{ PG }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the {{ PG }} connection port. In {{ yandex-cloud }}, the default port is 6432.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the {{ PG }} connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually {#manual}

      {% include [datalens-db-specify-mannualy](../../../_includes/datalens/datalens-db-specify-mannualy.md) %}

      {% include [datalens-db-connection-parameters-postgresql](../../../_includes/datalens/datalens-db-connection-parameters-postgresql.md) %}

   {% endlist %}


1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}



## Additional settings {#postgresql-additional-settings}

You can specify additional connection settings in the **Advanced connection settings** section:

* **Setting collate in a query**: To explicitly define a collation for DB queries, select a mode:

   * **Auto**: The default setting is used, {{ datalens-short-name }} decides whether to enable the `en_US` locale.
   * **On**: The {{ datalens-short-name }} setting is used, the `en_US` locale is specified for individual expressions in a query. This makes the server use the appropriate sorting logic, regardless of the server settings and specific tables. Use the {{ datalens-short-name }} setting if the DB locale is incompatible with {{ datalens-short-name }} performance. For more information about the locale and `LC_COLLATE`, see [{#T}](../../../managed-postgresql/operations/cluster-create.md#create-cluster).
   * **Off**: The default setting is used, {{ datalens-short-name }} only uses the existing parameters of the DB locale.

* **TLS**: Indicates that TLS should be used. If the option is enabled, the `sslmode` parameter value is `required`; if disabled, the parameter value is `prefer`.
* **CA Certificate**: To upload a certificate , click **Attach file** and specify the certificate file. When the certificate is uploaded, the field shows the file name.
* {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}
