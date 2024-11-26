* `enabled`: Enable hybrid storage in the cluster if it is disabled, `true` or `false`. Default value: `false` (disabled).

    {% include [Hybrid Storage cannot be switched off](../hybrid-storage-cannot-be-switched-off.md) %}

* `moveFactor`: Minimum share of free space in cluster storage. If the minimum share is below this value, the data will be moved to {{ objstorage-full-name }}.

    Minimum value: `0`; maximum value: `1`; default: `0.01`.

* `dataCacheEnabled`: Allow temporary storage of files in cluster storage, `true` or `false`.

    Default value: `true` (enabled).

* `dataCacheMaxSize`: Maximum cache size (in bytes) allocated in cluster storage for temporary file storage.

    Default value: `1073741824` (1 GB).

* `preferNotToMerge`: Disable [merging of data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) in cluster and object storage, `true` or `false`.

    To disable merging, set to `true`. To leave merging enabled, set to `false`.
