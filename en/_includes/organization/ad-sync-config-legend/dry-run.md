* `dry_run`: [Dry run](../../../organization/concepts/ad-sync/sync-agent.md#dry-run) settings for the agent:

    * `enabled: true`: Dry run mode on. The agent does not make any changes to {{ org-full-name }} user or group data. Instead, it tests all operations from the agent’s configuration, and [logs](../../../organization/concepts/ad-sync/sync-agent.md#logging) the results of these tests.
    * `enabled: false`: The agent runs normally, making the required changes to {{ org-full-name }} user and group data.