# Connecting to Yandex Direct from DataLens

## Issue description {#case-description}

You need to set up a connection to Yandex Direct data from DataLens.

## Solution {#case-resolution}

You can use [Cloud Functions](../../../functions/quickstart/index.md) to request data from the [Yandex Direct API](https://yandex.ru/dev/direct/#start).
For this, create a function that will save Yandex Direct data to an intermediate database, for example, to a [Managed Service for ClickHouse](../../../managed-clickhouse/quickstart.md) cluster. After that, [set up a connection](../../../datalens/operations/connection/create-clickhouse.md) to this database from DataLens.
