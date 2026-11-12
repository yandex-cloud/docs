### userpool_id {#config-userpool-id}

ID of the [user pool](../../organization/concepts/user-pools.md) in {{ org-full-name }}.

### working_directory {#config-working-directory}

Path to the directory that stores the files the agent needs to operate. This is an optional setting.

If this parameter is not set, the system will use the directory containing the agent's executable as the working directory. By default, the agent's executable resides in the following directories:

* `/etc/yc-identityhub-sync-agent/` (for Linux)
* `C:\\ProgramData\\YcIdentityHubSyncAgent\\` (for Windows)

### check_config_permissions {#config-check-config-permissions}

Controls whether to [check access permissions](../../organization/concepts/ad-sync/sync-agent.md#auth-data-security) for files with authentication credentials at agent startup. This is an optional setting. Its possible values are:

* `true`: Enables checking access permissions to the agent configuration files containing sensitive data.
* `false`: Disables checking access permissions to the agent configuration files. This is a default value.

### cloud_credentials_file_path {#config-cloud-credentials-file-path}

Path to the file containing the [authorized key](../../iam/concepts/authorization/key.md) of the service account in {{ yandex-cloud }}. This is an optional setting used only for agent authentication in the {{ yandex-cloud }} API with an authorized key.

Examples of values:

* `/etc/yc-identityhub-sync-agent/authorized_key.json` (for Linux)
* `C:\\ProgramData\\YcIdentityHubSyncAgent\\authorized_key.json` (for Windows)

In the `cloud_credentials_file_path` parameter, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

{% note info %}

If `cloud_credentials_file_path` and/or `logger.file.filename` specify paths different from the one specified in `working_directory`, the system will use the paths specified in `cloud_credentials_file_path` and/or `logger.file.filename` for the selected entities.

{% endnote %}

### use_metadata_service {#config-use-metadata-service}

Controls agent authentication in the {{ yandex-cloud }} API using an [IAM token](../../iam/concepts/authorization/iam-token.md) and enables the agent to obtain IAM tokens via the VM [metadata service](../../compute/concepts/vm-metadata.md).

Its possible values are:

* `true`: Synchronization agent will use the VM metadata service to obtain the service account IAM tokens for authentication in the {{ yandex-cloud }} API The `cloud_credentials_file_path` value will be ignored.

    To obtain IAM tokens, the agent must run on a {{ compute-full-name }} VM instance to which a service account with the [relevant access permissions](../../organization/concepts/ad-sync/index.md#yc-setup) is attached.
* `false`: The synchronization agent will not obtain IAM tokens; to authenticate in the {{ yandex-cloud }} API, it will use the authorized key specified in `cloud_credentials_file_path`.

### enable_password_writeback {#config-enable-password-writeback}

Manages user [password writeback](../../organization/concepts/ad-sync/index.md#password-writeback) in {{ microsoft-idp.ad-short }}.

{% include [pw-writeback-preview-notice](pw-writeback-preview-notice.md) %}

Its possible values are:

* `true`: When attempting to change the password of a synchronized user in {{ org-full-name }} ([password change](../../organization/operations/manage-account.md#edit-password) by the user or [password reset](../../organization/operations/user-pools/reset-user-password.md#reset) by the administrator), the agent first attempts to change the password of the corresponding user in {{ microsoft-idp.ad-short }}; only if this operation is successful will the password be changed in {{ org-full-name }}.
* `false`: When changing the password of a synchronized user in {{ org-full-name }}, the user's password remains unchanged in {{ microsoft-idp.ad-short }}. If you perform a [full sync](../../organization/concepts/ad-sync/sync-agent.md#full-sync) after changing the password, the agent replaces the updated password in {{ org-full-name }} with the one from {{ microsoft-idp.ad-short }}. This is also the default behavior where writeback is not enabled.

### dry_run {#config-dry-run}

[Dry run](../../organization/concepts/ad-sync/sync-agent.md#dry-run) settings for the agent:

* `enabled: true`: Dry run mode on. The agent does not make any changes to {{ org-full-name }} user or group data. Instead, it tests all operations from the agent’s configuration, and [logs](../../organization/concepts/ad-sync/sync-agent.md#logging) the results of these tests.
* `enabled: false`: The agent runs normally, making the required changes to {{ org-full-name }} user and group data.

### drsr {#config-drsr}

Select settings for the authentication method in place.

#### With username and password {#config-drsr-password}

[DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [user](../../organization/concepts/ad-sync/index.md#dc-setup) with permissions to replicate folder data:

* `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller.
* `username`: `sAMAccountName` of the {{ microsoft-idp.ad-short }} domain user with data replication permissions [assigned](../../organization/concepts/ad-sync/index.md#dc-setup).
* `password`: {{ microsoft-idp.ad-short }} domain user password.

#### As a gMSA account {#config-drsr-gmsa}

[DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication of a [gMSA account](*gmsa_account) with [permissions](../../organization/concepts/ad-sync/index.md#dc-setup) to replicate folder data:

* `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller.
* `use_windows_identity: true`: Enforces authentication in {{ microsoft-idp.ad-short }} using a gMSA account for the synchronization agent.

    {% include [runas-gmsa-account-notice](runas-gmsa-account-notice.md) %}

#### Via Kerberos {#config-drsr-kerberos}

[DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/) protocol settings for {{ microsoft-idp.ad-short }} authentication using Kerberos.

### ldap {#config-ldap}

[LDAPS](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/enable-ldap-over-ssl-3rd-certification-authority)/[LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) protocol settings for {{ microsoft-idp.ad-short }} authentication:

{% note warning %}

You can connect to a domain controller over `LDAPS` or `LDAP`. `LDAPS` is the recommended and safe option. Use `LDAP` only for setup and testing.

{% endnote %}

* `host`: Domain or IP address of the {{ microsoft-idp.ad-short }} domain controller. Specify the schema and port number depending on the protocol you use:

    * For `LDAPS`: `ldaps://` is the schema and `636` is the port number.
    * For `LDAP`: `ldap://` is the schema and `389` is the port number.
* `certificate_path`: Path to the file with the CA root certificate used to sign the domain controller's certificate. This is an optional setting.

    Specify this option if you are using the `LDAPS` protocol, and the root certificate is not in the system trusted certificate store.

    If the `working_directory` parameter specifies the path to the working directory, you can simply specify the certificate file name instead of its full path.
* `insecure_skip_verify`: Controls whether to ignore public key certificate validation errors when connecting to a domain controller. This is an optional setting. Its possible values are:

    * `false`: Certificate validation errors will not be ignored. This is a default value.
    * `true`: The synchronization agent will ignore certificate validation errors. This may prove effective for synchronization setup and testing. Not recommended for general use.

#### With username and password {#config-ldap-password}

* `username`: [DN](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names) of the {{ microsoft-idp.ad-short }} domain user with data replication permissions [assigned](../../organization/concepts/ad-sync/index.md#dc-setup).
* `password`: {{ microsoft-idp.ad-short }} domain user password.

#### As a gMSA account {#config-ldap-gmsa}

* `use_windows_identity: true` is a parameter that requires the synchronization agent to authenticate on the {{ microsoft-idp.ad-short }} side on behalf of the [gMSA account](*gmsa_account).

    {% include [runas-gmsa-account-notice](runas-gmsa-account-notice.md) %}

#### Via Kerberos {#config-ldap-kerberos}

* `use_kerberos`: This parameter indicates the need to use the Kerberos protocol for user authentication on the {{ microsoft-idp.ad-short }} side.

### kerberos {#config-kerberos}

Settings of the Kerberos protocol for authentication on the {{ microsoft-idp.ad-short }} side:

* `keytab_path`: Path to the `keytab` file containing the encryption keys.
* `principal`: [SPN](https://learn.microsoft.com/en-us/windows/win32/ad/service-principal-names) of the user account to connect to {{ microsoft-idp.ad-short }}.
* `krb5_config_path`: Path to the Kerberos configuration file. This is an optional setting. The default value is the `/etc/krb5.conf` path or the value set in the `KRB5_CONFIG` environment variable.
* `disable_pa_fx_fast: true`: Parameter that manages the [FAST] mode (https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831747(v=ws.11)#kerberos-armoring-flexible-authentication-secure-tunneling-fast).

### logger {#config-logger}

Synchronization [logging](../../organization/concepts/ad-sync/sync-agent.md#logging) settings:

* `level`: Logging level. Its possible values are:

    {% include [ad-sync-log-levels](ad-sync-log-levels.md) %}

* `format`: Event info output format into a standard stream or file. This is an optional setting. Its possible values are:

    * `plain`: Output the info as plain text. This is a default value.
    * `json`: Output the info in [JSON](https://en.wikipedia.org/wiki/JSON) format.
* `file`: Settings for saving logs to files:

    * `filename`: Path to the file for logging synchronization events.

        In the `filename` parameter, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

        This is an optional setting. The default file name is `identity_hub.log`.
    * `maxsize`: Maximum size of a single log file, in MB.
    * `maxbackups`: Maximum number of log files the agent will retain. When this limit is exceeded, the oldest file will be deleted.

    This is an optional setting. If no settings are specified in the `file` section, events will not be saved to files.
* `cloud_logger`: Settings for saving logs to a {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md):

    * `log_group_id`: ID of the log group to export the synchronization agent logs to.

    This is an optional setting. If no settings are specified in the `cloud_logger` section, events will export to a log group.

    To export synchronization agent logs to a log group, assign to the service account the additional `logging.writer` [role](../../logging/security/index.md#logging-writer) for the log group or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing it.

{% note info %}

If no settings are specified in the `logger.file` and `logger.cloud_logger` sections, the event and error info will be fed into a standard stream named `stdout`; otherwise, the logs will be saved to files and/or the log group.

{% endnote %}

### sync_settings {#config-sync-settings}

Synchronization settings:

* `interval`: [Incremental synchronization](../../organization/concepts/ad-sync/sync-agent.md#incremental-sync) frequency. This is an optional setting. The default value is 240 seconds.

    {% note info %}

    Password and user status synchronization in {{ microsoft-idp.ad-short }} takes place every few seconds at a fixed interval which does not depend on the `interval` value.

    {% endnote %}

* `allow_to_capture_users`: Enables updating an existing user in the {{ org-full-name }} user pool if their login matches that of a {{ microsoft-idp.ad-short }} user being synchronized. Its possible values are:

    * `true`: Synchronization agent will update existing {{ org-full-name }} users to match their corresponding {{ microsoft-idp.ad-short }} accounts.
    * `false`: Synchronization agent will not update existing {{ org-full-name }} users. If it detects matching logins in the user pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
* `allow_to_capture_groups`: Enables updating an existing {{ org-full-name }} user group if its name matches that of a {{ microsoft-idp.ad-short }} group being synchronized. Its possible values are:

    * `true`: Synchronization agent will update existing {{ org-full-name }} user groups to match their corresponding {{ microsoft-idp.ad-short }} groups.
    * `false`: Synchronization agent will not update existing {{ org-full-name }} groups. If it detects matching group names in the pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
* `replacement_domain`: [Domain](../../organization/concepts/domains.md) associated with the {{ org-full-name }} user pool to which synchronized users and groups belong. Here is an example: `newdomain.idp.{{ dns-ns-host-sld }}`.

    This is an optional setting. Specify the `replacement_domain` value only if the domain name associated with the user pool does not match the domain name on the {{ microsoft-idp.ad-short }} domain controller.
* `user_attribute_mapping`: User attribute mapping settings:

    * `source`: User attribute name obtained from {{ microsoft-idp.ad-short }} and different from the [default](../../organization/concepts/ad-sync/index.md#sync-objects) one.

        To disable attribute synchronization, leave empty: `source: ""`.
    * `target`: Name of the attribute in {{ yandex-cloud }} you want to configure mapping with (or disable synchronization for). For the list of available values, see **User attributes** in [{#T}](../../organization/concepts/ad-sync/index.md#sync-objects).
    * `type`: Selecting an action to take with the specified attribute. Its possible values are:

        * `direct`: Configure attribute mapping.
        * `empty`: Disable attribute synchronization.

    This is an optional setting. You should specify the `user_attribute_mapping` value only if you need to map user attribute names different from the {{ microsoft-idp.ad-short }} default ones or to disable synchronization of individual attributes.
* `group_attribute_mapping`: User group attribute mapping settings:

    * `source`: User group attribute name obtained from {{ microsoft-idp.ad-short }} and different from the [default](../../organization/concepts/ad-sync/index.md#sync-objects) one.

        To disable attribute synchronization, leave empty: `source: ""`.
    * `target`: Name of the attribute in {{ yandex-cloud }} you want to configure mapping with (or disable synchronization for). For the list of available values, see **User group attributes** in [{#T}](../../organization/concepts/ad-sync/index.md#sync-objects).
    * `type`: Selecting an action to take with the specified attribute. Its possible values are:

        * `direct`: Configure attribute mapping.
        * `empty`: Disable attribute synchronization.

    This is an optional setting. You should specify the `group_attribute_mapping` value only if you need to map user group attribute names different from the {{ microsoft-idp.ad-short }} default ones or to disable synchronization of individual attributes.
* `filter`: Settings for filtering objects to synchronize on the {{ microsoft-idp.ad-short }} side:

    * `domain`: Domain name in the {{ microsoft-idp.ad-short }} domain controller where the agent will synchronize users and groups.
    * `organization_units`: List of organization units (OUs) in the {{ microsoft-idp.ad-short }} folder in which the agent will synchronize users and groups.
    * `groups`: List of user groups in the {{ microsoft-idp.ad-short }} folder in which the agent will synchronize users. You can specify one or more groups; filtering by multiple groups will use the `OR` logic.

        {% note info %}

        The `groups` parameter only affects user synchronization and not user group synchronization settings.

        {% endnote %}

    If object filtering is not configured, {{ ad-sync-agent }} will attempt to synchronize all [available objects](../../organization/concepts/ad-sync/index.md#sync-objects) in the {{ microsoft-idp.ad-short }} folder.
* `remove_user_behavior`: Controls what action should be applied to users on the {{ yandex-cloud }} side if the corresponding ones on the {{ microsoft-idp.ad-short }} side were deleted or ceased to satisfy the conditions specified in `sync_settings.filter` (e.g., if moved to another organization unit). This is an optional setting. Its possible values are:

    * `remove`: Users who were deleted ceased to satisfy the filter criteria will be deleted on the {{ org-full-name }} side. This is the default action.
    * `block`: Users who were deleted ceased to satisfy the filter criteria will be deactivated on the {{ org-full-name }} side.

{% note info %}

If synchronization reveals that a {{ microsoft-idp.ad-short }} user group was deleted or ceased to satisfy the filter criteria (e.g., if moved to another organization unit), such a group will be deleted on the {{ org-full-name }} side.

{% endnote %}
