* `moveFactor`: Minimum percentage of free space in the cluster storage. If your free space percentage is below this value, the data will be moved to object storage. The minimum value is `0`, the maximum value is `1`, and the default value is `0.01`.

    Data parts are queued up in descending order by size. The number of data parts that will be moved is determined by the condition regarding the specified minimum share of free space in cluster storage.

* `dataCacheEnabled`: Allows caching data accessed from the object storage in the cluster storage, `true` or `false`. As a result, the cold data accessed from the object storage is moved to high-speed drives for faster processing. The default value is `true` (allowed).

* `dataCacheMaxSize`: Sets the maximum cache size, in bytes, allocated in the cluster storage for data accessed from the object storage. If no value is set, the maximum cache size defaults to half the size of the cluster storage.

* `preferNotToMerge`: Disable [merging of data parts]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) in the cluster and object storage, `true` or `false`. To disable merging, set to `true`. To leave merging enabled, set to `false`.

    Once inserted into the table, the data is saved as a data part and sorted by its primary key. Then, {{ CH }} runs a background merge of data parts belonging to the same partition into a larger data part within 10 to 15 minutes after the insertion. You can use the [system.parts]({{ ch.docs }}{{ lang }}/operations/system-tables/parts#system_tables-parts) system table to view the merged data parts and partitions.
