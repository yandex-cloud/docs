* `cloud_credentials_file_path`: Path to the file containing the [authorized key](../../../iam/concepts/authorization/key.md) of the service account in {{ yandex-cloud }}. This is an optional setting used only for agent authentication in the {{ yandex-cloud }} API with an authorized key.

    Examples of values:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (for Windows)

    In the `cloud_credentials_file_path` settings, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

    {% note info %}

    If `cloud_credentials_file_path` and/or `logger.file.filename` specify paths different from the one specified in `working_directory`, the system will use the paths specified in `cloud_credentials_file_path` and/or `logger.file.filename` for the selected entities.

    {% endnote %}