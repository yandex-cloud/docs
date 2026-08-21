Compaction is performed during the [maintenance window](../../../storedoc/concepts/maintenance.md#maintenance-window) not more than once per week. Single-host clusters are not subject to compaction.

To be eligible for compaction, a collection must have a bloat percentage at least as high as **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-bloat-percent_gCgoZ }}**. Compaction is performed only if, according to a preliminary estimate, it will help generate at least **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-target-free-space_tB2yk }}** of free space.

Configure compaction settings:

* **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-target-free-space_tB2yk }}**: Minimum total disk space in MB to free through compaction of collections. The default value is `10` MB.
* **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-bloat-percent_gCgoZ }}**: Minimum collection bloat percentage for a collection to be selected for compaction. The default value is `10%`.

To perform compaction on the master host, enable **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-compaction-type_jdXAN }}**. Before the master host is compacted, the master role is delegated to another host. If this option is disabled, no master host compaction is performed.
