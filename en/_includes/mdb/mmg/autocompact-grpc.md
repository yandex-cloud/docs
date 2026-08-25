* `enabled`: Automatic compaction to free disk space, `true` or `false`.
* `bloat_percent`: Minimum collection bloat percentage for a collection to be selected for compaction. The default value is `10%`.
* `target_free_space`: Minimum total disk space in MB to free through compaction of collections. Default value: `10` MB.
* `compaction_type`: Master host compaction. The possible values are:
                
  * `COMPACTION_TYPE_IGNORE_PRIMARY`: Master host compaction will not be performed. It is used by default.
  * `COMPACTION_TYPE_SWITCH_PRIMARY`: Master host compaction will be performed.
    
    Before the master host is compacted, the master role is delegated to another host.

Compaction is performed during the [maintenance window](../../../storedoc/concepts/maintenance.md#maintenance-window) not more than once per week. Single-host clusters are not subject to compaction.

To be eligible for compaction, a collection must have a bloat percentage at least as high as `bloat_percent`. Compaction is performed only if, according to a preliminary estimate, it will help generate at least `target_free_space` of free space.