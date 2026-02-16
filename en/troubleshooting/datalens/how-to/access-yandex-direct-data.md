# How to access {{ yandex-direct }} from {{ datalens-name }}


## Case description {#case-description}

You need to set up access to {{ yandex-direct }} data in {{ datalens-name }}.

## Solution {#case-resolution}

You can use [{{ sf-name }}](../../../functions/quickstart/index.md) to request data from the [{{ yandex-direct }} API](https://yandex.com/dev/direct/#start).

To do this, create a function that saves {{ yandex-direct }} data to an intermediate database, such as a [{{ mch-full-name }}](../../../managed-clickhouse/quickstart.md) cluster. After that, [set up a connection](../../../datalens/operations/connection/create-clickhouse.md) to this database from {{ datalens-name }}.