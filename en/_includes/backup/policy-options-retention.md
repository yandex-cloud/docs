* Under **{{ ui-key.yacloud.backup.policy-form.title_retention-section }}**, set the [backup retention](../../backup/concepts/policy.md#retention) policy:

  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}`: All backups created under this backup policy will be retained.
  * `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-last-f }}`: Specify the number of recent backups you want to retain or the number of days, weeks, or months for which to retain the backups. All other backups will be deleted automatically.

      {% note info %}

      If you created the policy via the management console, subsequent updates of backup retention settings will take effect only after a next backup is created. If the changes have not taken effect, [disassociate](../../backup/operations/policy-vm/detach-vm.md) the policy from the VM or {{ baremetal-name }} server and then [reassociate](../../backup/operations/policy-vm/attach-and-detach-vm.md) it.

      {% endnote %}