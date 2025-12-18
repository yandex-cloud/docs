# Resolving `psql: error: could not translate host name to address: nodename nor servname provided, or not known`



## Issue description {#issue-description}

You have no public access to a {{ PG }} cluster and get this error:
```
psql: error: could not translate host name to address: nodename nor servname provided, or not known
```

## Solution {#issue-resolution}

To fix this error, check whether public access to the {{ PG }} cluster hosts is enabled. A cluster host can be reached from outside {{ yandex-cloud }} [if you enabled public access while creating or reconfiguring that host](../../../managed-postgresql/concepts/network.md#public-access-to-a-host). If public access is disabled, [enable](../../../managed-postgresql/operations/hosts.md#update) it.

To learn how to connect to a database in a {{ PG }} cluster, see [this {{ mpg-name }} guide](../../../managed-postgresql/operations/connect.md).