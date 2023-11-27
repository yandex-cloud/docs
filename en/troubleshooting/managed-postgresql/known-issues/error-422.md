# Resolving the "422 UNPROCESSABLE ENTITY The specified extension <'ext_name'> is not present in shared_preload_libraries" error



## Issue description {#issue-description}

When trying to install a database extension following the [guide](../../../managed-postgresql/operations/extensions/cluster-extensions), you see this error:
```
422 UNPROCESSABLE ENTITY The specified extension 'EXT_NAME'
is not present in shared_preload_libraries.
```

## Solution {#issue-resolution}

This error states that the `EXT_NAME` flag is not set in the cluster.

Please set it as follows: **Cluster overview** -> **Edit cluster** -> **DBMS settings** -> **Shared preload libraries**, then choose `EXT_NAME`. After that, you can install the extension.

{% note alert %}

When you make changes to cluster settings, the PostgreSQL server reboots.

{% endnote %}

We provide more details on managing extensions in our [documentation](../../../managed-postgresql/operations/extensions/cluster-extensions).