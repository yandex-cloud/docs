# Resolving the psql error: "error: could not translate host name to address: nodename nor servname provided, or not known"



## Issue description {#issue-description}

You have no public access to the PostgreSQL cluster and see this error:
```
psql: error: could not translate host name to address: nodename nor servname provided, or not known
```

## Solution {#issue-resolution}

Check whether public access to PostgreSQL cluster hosts is enabled. A host in the cluster could be accessible from outside Yandex Cloud if [public access was enabled when creating the host or updating its settings](https://cloud.yandex.ru/docs/managed-postgresql/concepts/network#public-access-to-a-host).

If public access is disabled, [enable](https://cloud.yandex.ru/docs/managed-postgresql/operations/hosts#update) it.

In the [documentation](https://cloud.yandex.ru/docs/managed-postgresql/operations/connect), you can find a guide for connecting to a database in a PostgreSQL cluster.