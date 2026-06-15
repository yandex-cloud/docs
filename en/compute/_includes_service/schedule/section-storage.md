Under **{{ ui-key.yacloud.compute.components.SnapshotScheduleFormContent.section_storage-settings_wG5uP }}**, select the snapshot storage policy:
* **{{ ui-key.yacloud.compute.components.SnapshotScheduleFormContent.label_empty-retention-policy_voaWW }}**: Enable to retain all snapshots created by this schedule.
* **{{ ui-key.yacloud.compute.snapshot-schedule-form-next.active-retention-policy-field.message_store-last-begin_few }}**: Specify the number of the latest snapshots to retain or the number of days for which to retain the snapshots. Any other snapshots created by this schedule will be deleted automatically.

{% note info %}

There are [quotas](../../concepts/limits.md#compute-quotas) on the number and total size of snapshots in the cloud.

{% endnote %}
