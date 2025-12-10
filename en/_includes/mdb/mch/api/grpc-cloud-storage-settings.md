* `enabled`: Enable hybrid storage in the cluster if it is disabled, `true` or `false`. The default value is `false` (disabled).

    {% include [Hybrid Storage cannot be switched off](../hybrid-storage-cannot-be-switched-off.md) %}

* `move_factor`: Minimum percentage of free space in the cluster storage. If your free space percentage is below this value, the data will be moved to {{ objstorage-full-name }}.

    The minimum value is `0`, the maximum value is `1`, and the default value is `0.01`.

* `data_cache_enabled`: Enable caching files in the cluster storage, `true` or `false`.

    The default value is `true` (enabled).

* `data_cache_max_size`: Maximum cache size, in bytes, allocated in the cluster storage.

    The default value is `1073741824` (1 GB).

* `prefer_not_to_merge`: Disable [merging of data parts]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) in the cluster and object storage, `true` or `false`.

    To disable merging, set to `true`. To leave merging enabled, set to `false`.
