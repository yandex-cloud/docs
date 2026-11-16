* `--cloud-storage-data-cache`: Enables caching data accessed from the object storage in the cluster storage. As a result, the cold data accessed from the object storage is moved to high-speed drives for faster processing. The default value is `true` (allowed).

* `--cloud-storage-data-cache-max-size`: Sets the maximum cache size, in bytes, allocated in the cluster storage for data accessed from the object storage. If no value is set, the maximum cache size defaults to half the size of the cluster storage.

* `--cloud-storage-move-factor`: Sets the minimum percentage of free space in the cluster storage. If your free space percentage is below this value, the data will be moved to {{ objstorage-full-name }}. The minimum value is `0`, the maximum value is `1`, and the default value is `0.01`.

    Data parts are queued up in descending order by size. The number of data parts that will be moved is determined by the condition regarding the specified minimum share of free space in cluster storage.

* `--cloud-storage-prefer-not-to-merge`: Disables [merging of data parts]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) in cluster and object storages. To disable merges, set the parameter to `true` or provide it with no value. To keep merges enabled, set the parameter to `false` or do not provide it in the CLI command when creating a cluster.

    Once inserted into the table, the data is saved as a data part and sorted by its primary key. Then, {{ CH }} runs a background merge of data parts belonging to the same partition into a larger data part within 10 to 15 minutes after the insertion. You can use the [system.parts]({{ ch.docs }}{{ lang }}/operations/system-tables/parts#system_tables-parts) system table to view the merged data parts and partitions.
