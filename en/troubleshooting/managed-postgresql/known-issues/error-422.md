# Fixing the `422 UNPROCESSABLE ENTITY The specified extension <'ext_name'> is not present in shared_preload_libraries` error



## Issue description {#issue-description}

When trying to install the required database extension following [this guide](../../../managed-postgresql/operations/extensions/cluster-extensions.md), you get this error:

```
«422 UNPROCESSABLE ENTITY The specified extension 'EXT_NAME'
is not present in shared_preload_libraries.»
```

## Solution {#issue-resolution}

This error states that the `EXT_NAME` flag is not set in the cluster.

To set it, navigate to **Cluster overview** → **Edit cluster** → **DBMS settings** → **Shared preload libraries** and select `EXT_NAME`. After that, you will be able to install your extension.

{% note alert %}

Applying changes to the cluster settings will cause the {{ PG }} server to reboot.

{% endnote %}

For more details on managing extensions, see [this guide](../../../managed-postgresql/operations/extensions/cluster-extensions.md).