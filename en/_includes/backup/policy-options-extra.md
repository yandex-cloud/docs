  * Optionally, under **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}**, specify the backup settings in the event of failure:
    * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}**: Maximum number of retry attempts. If reached, the operation is considered failed. Attempts will stop as soon as the operation succeeds or when the specified number of attempts is reached, whichever comes earlier.
        This setting does not apply if the backup was started manually.
    * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}**: Interval between reattempts.

  * Optionally, under **{{ ui-key.yacloud.backup.policy-overview.field_error-handling }}**, configure the {{ backup-name }} behavior if errors occur:
    *  **{{ ui-key.yacloud.backup.policy-form.field_action-on-task-failure }}**: Reattempt settings in case of backup errors:
        * **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}**: Maximum number of retry attempts.
        * **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}**: Interval between reattempts.
    * **{{ ui-key.yacloud.backup.policy-form.field_snapshot-reaatempt }}**: Reattempt settings in case of snapshot errors:
        *  **{{ ui-key.yacloud.backup.policy-form.field_attempts-qty }}**: Maximum number of retry attempts.
        *  **{{ ui-key.yacloud.backup.policy-form.field_interval-between-attempts }}**: Interval between reattempts.

  * Optionally, under **{{ ui-key.yacloud.backup.policy-overview.field_files-filters }}**, you can use filters to exclude specific files and folders from your backups or do the opposite and back up only specific file system items:
    * **{{ ui-key.yacloud.backup.policy-overview.field_exclusion-masks }}**
    * **{{ ui-key.yacloud.backup.policy-overview.field_inclusion-masks }}**

    Exclusion filters take precedence over inclusion filters.

    To include or exclude files, add some criteria, e.g., file names, paths, or masks. `*` and `?` wildcards are supported. Use a new line for each criterion. Criteria are case-insensitive.
