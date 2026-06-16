* `userpool_id`: ID of the [user pool](../../organization/concepts/user-pools.md) in {{ org-full-name }}.
* `replication_tokens_path`: Path to the directory storing tokens with info about the current progress of [full synchronization](../../organization/concepts/ad-sync.md#full-sync) processes. This is an optional setting.

    If this parameter is not set, the system will be saving the tokens in the agent's working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.
* `working_directory`: Path to the directory for other files the agent needs to operate. This is an optional setting.

    If this parameter is not set, the system will use the directory containing the agent's executable as the working directory. By default, the agent's executable resides in the following directories:

    * `/etc/yc-identityhub-sync-agent/` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (for Windows)

* `cloud_credentials_file_path`: Path to the file containing the [authorized key](../../iam/concepts/authorization/key.md) of the service account in {{ yandex-cloud }}. This is an optional setting used only for agent authentication in the {{ yandex-cloud }} API with an authorized key.

    Examples of values:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (for Windows)

    In the `cloud_credentials_file_path` parameter, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

    {% note info %}

    If the `cloud_credentials_file_path`, `replication_tokens_path`, and/or `logger.file.filename` parameters specify paths other than that specified in `working_directory`, the system will use the paths specified in the `cloud_credentials_file_path`, `replication_tokens_path`, and/or `logger.file.filename` parameters for the selected entities.

    {% endnote %}

* `use_metadata_service`: Controls agent authentication in the {{ yandex-cloud }} API using an [IAM token](../../iam/concepts/authorization/iam-token.md) and enables the agent to obtain IAM tokens via the VM [metadata service](../../compute/concepts/vm-metadata.md).

    The possible values are:

    * `true`: Synchronization agent will use the VM metadata service to obtain the service account IAM tokens for authentication in the {{ yandex-cloud }} API The `cloud_credentials_file_path` value will be ignored.

        To obtain IAM tokens, the agent must run on a {{ compute-full-name }} VM instance to which a service account with the [relevant access permissions](../../organization/concepts/ad-sync.md#yc-setup) is attached.
    * `false`: Synchronization agent will not obtain IAM tokens; to authenticate in the {{ yandex-cloud }} API, it will use the authorized key specified in `cloud_credentials_file_path`.
* `dry_run`: [Dry run](../../organization/concepts/ad-sync.md#dry-run) settings for the agent:

    * `enabled: true`: Dry run mode on. The agent does not make any changes to {{ org-full-name }} user or group data. Instead, it tests all operations from the agent’s configuration, and [logs](../../organization/concepts/ad-sync.md#logging) the results of these tests.
    * `enabled: false`: The agent runs normally, making the required changes to {{ org-full-name }} user and group data.