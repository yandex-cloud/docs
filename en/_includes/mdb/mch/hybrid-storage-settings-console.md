* **{{ ui-key.yacloud.clickhouse.cluster.field_cloud-storage-data-cache }}**: Enables caching data accessed from the object storage in the cluster storage. As a result, the cold data accessed from the object storage is moved to high-speed drives for faster processing.

    By default, data caching is enabled.

* **{{ ui-key.yacloud.clickhouse.cluster.field_cloud-storage-data-cache-max-size }}**: Sets the maximum cache size, in bytes, allocated in the cluster storage for data accessed from the object storage. If no value is set, the maximum cache size defaults to half the size of the cluster storage.

* **{{ ui-key.yacloud.clickhouse.cluster.field_cloud-storage-move-factor }}**: Sets the minimum percentage of free space in the cluster storage. If your free space percentage is below this value, the data will be moved to object storage. The minimum value is `0`, the maximum value is `1`, and the default value is `0.01`.

    Data parts are queued up in descending order by size. The number of data parts that will be moved is determined by the condition regarding the specified minimum share of free space in cluster storage.

