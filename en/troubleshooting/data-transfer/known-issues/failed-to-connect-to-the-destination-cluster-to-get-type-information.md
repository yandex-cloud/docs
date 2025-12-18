# Fixing the `failed to connect to the destination cluster to get type information` error


## Issue description {#issue-description}

When running a transfer, you see the following error message: 
```
Cannot retrieve table information from the source database: failed to resolve storage: failed to connect to the destination cluster to get type information: unable to get master host: unable to create service_name service client: All hosts are unavailable
hostname resolving error (lookup host_name.mdb.yandexcloud.net on 127.0.0.1:53) failed to connect to `host=host_name.mdb.yandexcloud.net user= database=`: hostname resolving error
```

## Solution {#issue-resolution}

Most likely, the settings of the cloud subnet of the target cluster or source cluster in this transfer include addresses of third-party DNS servers. In this case, when running a transfer, you will get the `hostname resolving error` message.

For more information, see [**Networking in {{ data-transfer-full-name}}**](../../../data-transfer/concepts/network.md).

To fix this issue, you can either set up the third-party DNS servers to resolve the clusters host names or add the cluster endpoint by its IP address (as an external installation).
