### Why is dataset materialization not available? {#where-is-materialization}

Materialization is no longer supported. We recommend using a DB directly. If it takes the DB a long time to respond to {{ datalens-short-name }} analytical queries, build data marts, for example, based on the [{{ CH }} managed database](../../managed-clickhouse/index.yaml). You can use [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) to upload your data.
