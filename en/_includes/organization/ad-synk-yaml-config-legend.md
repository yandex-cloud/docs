Where:

* `userpool_id`: ID of the [user pool](../../organization/concepts/user-pools.md) in {{ org-name }}.
* `cloud_credentials_file_path`: Path to the file containing the [authorized key](../../iam/concepts/authorization/key.md) of the service account in {{ yandex-cloud }}. For example:

    * `/etc/yc-identityhub-sync-agent/authorized_key.json` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (for Windows)
* `replication_tokens_path`: Path to the directory storing tokens with info about the current progress of [full synchronization](../../organization/concepts/ad-sync.md#full-sync) processes. The default values are:

    * `/etc/yc-identityhub-sync-agent/` (for Linux)
    * `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (for Windows)
* `drsr`: [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](#dc-setup) with permissions to replicate folder data.
* `ldap`: [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](#dc-setup) with permissions to replicate folder data.
* `logger`: Synchronization [logging](#logging) settings:

    * `level`: Logging level. Possible values:

        {% include [ad-synk-log-levels](./ad-synk-log-levels.md) %}

    * `format`: Event info output format. This is an optional parameter. Possible values:

        * `plain`: Output the info as plain text. This is a default value.
        * `json`: Output the info in [JSON](https://en.wikipedia.org/wiki/JSON) format.
    * `file`: Settings for saving logs to files:

        * `filename`: Path to the file for logging synchronization events. The default values are:

            * `/etc/yc-identityhub-sync-agent/identity_hub.log` (for Linux)
            * `C:\\ProgramData\\YcIdentityHubSyncAgent\\identity_hub.log` (for Windows)
        * `maxsize`: Maximum size of a single log file, in MB.
        * `maxbackups`: Maximum number of log files the agent will retain. When this limit is exceeded, the oldest file will be deleted.

        This is an optional parameter. If you do not provide the `file` settings, logs will be output to the `stdout` stream and not saved to files.
* `sync_settings`: Synchronization settings:

    * `interval`: [Incremental synchronization](../../organization/concepts/ad-sync.md#incremental-sync) frequency. This is an optional parameter. The default value is 240 seconds.

        {% note info %}

        Password and user status synchronization in {{ microsoft-idp.ad-short }} takes place every few seconds at a fixed interval which does not depend on the `interval` value.

        {% endnote %}

    * `allow_to_capture_users`: Enables updating an existing user in the {{ org-name }} user pool if their login matches that of a {{ microsoft-idp.ad-short }} user being synchronized. Possible values:

        * `true`: Synchronization agent will update existing {{ org-name }} users to match their corresponding {{ microsoft-idp.ad-short }} accounts.
        * `false`: Synchronization agent will not update existing {{ org-name }} users. If it detects matching logins in the user pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
    * `allow_to_capture_groups`: Enables updating an existing {{ org-name }} user group if its name matches that of a {{ microsoft-idp.ad-short }} group being synchronized. Possible values:

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