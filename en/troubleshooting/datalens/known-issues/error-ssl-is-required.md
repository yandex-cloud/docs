# Fixing the `SSL is required` error


## Issue description {#issue-description}

When trying to connect to a {{ mpg-name }} database from {{ datalens-name }}, you get the following error:

```
ERR.CHARTS.DATA_FETCHING_ERROR
ERR.DS_API.DB
db_message": "odyssey: ***********: SSL is required"
```

## Solution {#issue-resolution}

This error means that the connection requires SSL. Using SSL is [optional](../../../managed-postgresql/operations/connect.md) when connecting to a database in the same cloud or folder; however, connecting to an external database requires a trusted SSL certificate on the server.

If this issue occurs with a new {{ mpg-name }} connection, [enable **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}**](../../../managed-postgresql/operations/datalens-connect.md#allow-access) in the cluster settings, and then [set up a connection in {{ datalens-name }}](../../../datalens/operations/connection/create-postgresql.md).

If ca n reproduce this issue on an existing {{ mpg-name }} connection, disable and then enable [{{ datalens-name }} access](../../../managed-postgresql/operations/datalens-connect.md#allow-access) in the cluster [settings](../../../managed-postgresql/operations/update.md#change-additional-settings). If it does not help, create a new connection to the {{ mpg-name }} cluster database in {{ datalens-name }}. Then, [replace the connection in the dataset](../../../datalens/dataset/create-dataset.md#replace-connection) with a working one.
