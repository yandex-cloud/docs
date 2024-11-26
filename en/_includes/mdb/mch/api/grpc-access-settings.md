* `data_lens`: Enable access from {{ datalens-name }}, `true` or `false`. The default value is `false`. For more information about setting up a connection, see [Connecting from {{ datalens-name }}](../../../../managed-clickhouse/operations/datalens-connect.md).

* `web_sql`: Enables [SQL queries](../../../../managed-clickhouse/operations/web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}: `true` or `false`. The default value is `false`.


* `metrika`: Enables [data import from AppMetrica to your cluster](https://appmetrica.yandex.com/docs/common/cloud/about.html): `true` or `false`. The default value is `false`.

* `serverless`: Enable access to the cluster from [{{ sf-full-name }}](../../../../functions/concepts/index.md), `true` or `false`. The default value is `false`. For more information about setting up access, see the [{{ sf-name }}](../../../../functions/operations/database-connection.md) documentation.

* `data_transfer`: Enable access to the cluster from [{{ data-transfer-full-name }}](../../../../data-transfer/concepts/index.md) in Serverless mode, `true` or `false`. The default value is `false`.

    This will enable you to connect to {{ data-transfer-full-name }} running in {{ k8s }} via a special network. As a result, other operations, e.g., transfer launch and deactivation, will run faster.


* `yandex_query`: Enable access to the cluster from [{{ yq-full-name }}](../../../../query/concepts/index.md), `true` or `false`: `true` or `false`. This feature is at the [Preview](../../../../overview/concepts/launch-stages.md) stage.Default value: `false`.
