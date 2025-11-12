Where:

* `userpool_id`: ID of the [user pool](../../organization/concepts/user-pools.md) in {{ org-name }}.
* `cloud_credentials_file_path`: Path to the file containing the [authorized key](../../iam/concepts/authorization/key.md) of the service account in {{ yandex-cloud }}. Here is an example:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (for Windows)

    In the `cloud_credentials_file_path` parameter, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.
* `replication_tokens_path`: Path to the directory storing tokens with info about the current progress of [full synchronization](../../organization/concepts/ad-sync.md#full-sync) processes. This is an optional parameter.

    If this parameter is not set, the system will be saving the tokens in the agent's working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.
* `working_directory`: Path to the directory for other files the agent needs to operate. This is an optional parameter.

    If this parameter is not set, the system will use the directory containing the agent's executable as the working directory. By default, the agent's executable resides in the following directories:

    * `/etc/yc-identityhub-sync-agent/` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (for Windows)

    {% note info %}

    If the `cloud_credentials_file_path`, `replication_tokens_path`, and/or `logger.level` parameters specify paths other than that specified in `working_directory`, the system use the paths specified in `cloud_credentials_file_path`, `replication_tokens_path`, and/or `logger.level`.

    {% endnote %}

* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](#dc-setup) with permissions to replicate folder data.
* `ldap`: [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](#dc-setup) with permissions to replicate folder data.
* `logger`: Synchronization [logging](#logging) settings:

    * `level`: Logging level. The possible values are:

        {% include [ad-synk-log-levels](./ad-synk-log-levels.md) %}

    * `format`: Event info output format. This is an optional parameter. The possible values are:

        * `plain`: Output the info as plain text. This is a default value.
        * `json`: Output the info in [JSON](https://en.wikipedia.org/wiki/JSON) format.
    * `file`: Settings for saving logs to files:

        * `filename`: Path to the file for logging synchronization events.

            In the `filename` parameter, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

            This is an optional parameter. The default file name is `identity_hub.log`.
        * `maxsize`: Maximum size of a single log file, in MB.
        * `maxbackups`: Maximum number of log files the agent will retain. When this limit is exceeded, the oldest file will be deleted.

        This is an optional parameter. If you do not provide the `file` settings, logs will be output to the `stdout` stream and not saved to files.
* `sync_settings`: Synchronization settings:

    * `interval`: [Incremental synchronization](../../organization/concepts/ad-sync.md#incremental-sync) frequency. This is an optional parameter. The default value is 240 seconds.

        {% note info %}

        Password and user status synchronization in {{ microsoft-idp.ad-short }} takes place every few seconds at a fixed interval which does not depend on the `interval` value.

        {% endnote %}

    * `allow_to_capture_users`: Enables updating an existing user in the {{ org-name }} user pool if their login matches that of a {{ microsoft-idp.ad-short }} user being synchronized. The possible values are:

        * `true`: Synchronization agent will update existing {{ org-name }} users to match their corresponding {{ microsoft-idp.ad-short }} accounts.
        * `false`: Synchronization agent will not update existing {{ org-name }} users. If it detects matching logins in the user pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
    * `allow_to_capture_groups`: Enables updating an existing {{ org-name }} user group if its name matches that of a {{ microsoft-idp.ad-short }} group being synchronized. The possible values are:

        * `true`: Synchronization agent will update existing {{ org-name }} user groups to match their corresponding {{ microsoft-idp.ad-short }} groups.
        * `false`: Synchronization agent will not update existing {{ org-name }} groups. If it detects matching group names in the pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
    * `replacement_domain`: [Domain](../../organization/concepts/domains.md) associated with the {{ org-name }} user pool to which synchronized users and groups belong, e.g., `newdomain.idp.{{ dns-ns-host-sld }}`.

        This is an optional parameter. Specify the `replacement_domain` value only if the domain name associated with the user pool does not match the domain name on the {{ microsoft-idp.ad-short }} domain controller.
    * `filter`: Settings for filtering objects to synchronize on the {{ microsoft-idp.ad-short }} side:

        * `domain`: Domain name in the {{ microsoft-idp.ad-short }} domain controller where the agent will synchronize users and groups.
        * `organization_units`: List of _organizational units_ (OUs) in the {{ microsoft-idp.ad-short }} folder in which the agent will synchronize users and groups.

        If object filtering is not configured, {{ ad-sync-agent }} will attempt to synchronize all [available objects](../../organization/concepts/ad-sync.md#sync-objects) in the {{ microsoft-idp.ad-short }} folder.

        {% note info %}

        If a user or group no longer matches the specified filters during synchronization, e.g., if moved to a different organizational unit within {{ microsoft-idp.ad-short }}, such a user or group will be removed from {{ org-name }}.

        {% endnote %}