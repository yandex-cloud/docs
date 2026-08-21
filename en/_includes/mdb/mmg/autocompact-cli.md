* `--autocompact`: Automatic compaction to free up disk space, `true` or `false`.
  
  Compaction is performed during the [maintenance window](../../../storedoc/concepts/maintenance.md#maintenance-window) not more than once per week. Single-host clusters are not subject to compaction.

  To be eligible for compaction, a collection must have a bloat percentage at least as high as `--autocompact-bloat-percent`. Compaction is performed only if, according to a preliminary estimate, it will help generate at least `--autocompact-target-free-space` of free space.

* `--autocompact-bloat-percent`: Minimum collection bloat percentage for a collection to be selected for compaction. The default value is `10%`.
* `--autocompact-target-free-space`: Minimum total disk space in MB to free through compaction of collections. Default value: `10` MB.
  
* `--autocompact-compaction-type`: Master host compaction. The possible values are:
  
  * `compaction-type-ignore-primary`: Master host compaction will not be performed. It is used by default.
  * `compaction-type-switch-primary`: Master host compaction will be performed.
    
    Before the master host is compacted, the master role is delegated to another host.