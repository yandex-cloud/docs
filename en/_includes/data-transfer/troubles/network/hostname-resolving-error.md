### Hostname resolving error {#hostname-resolving-error}

Error message:

```text
Cannot retrieve table information from the source database: failed to resolve storage: failed to connect to the destination cluster to get type information: unable to get master host: unable to create service_name service client: All hosts are unavailable
hostname resolving error (lookup host_name.mdb.yandexcloud.net on 127.0.0.1:53) failed to connect to `host=host_name.mdb.yandexcloud.net user= database=`: hostname resolving error
```

The error occurs if the settings of the cloud subnet of the target cluster or source cluster in the transfer include addresses of third-party DNS servers. In this case, when running a transfer, you may get the `hostname resolving error` message.

For more on network settings, see [Networking in {{ data-transfer-full-name }}](../../../../data-transfer/concepts/network.md).

**Solution**:

* Configure external DNS servers to resolve cluster host names.
* If this is not possible, add the cluster endpoint as an external installation using its IP address.
