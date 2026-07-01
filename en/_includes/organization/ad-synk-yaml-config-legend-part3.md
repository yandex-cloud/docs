* `logger`: Synchronization [logging](#logging) settings:

    * `level`: Logging level. The possible values are:

        {% include [ad-synk-log-levels](./ad-synk-log-levels.md) %}

    * `format`: Event info output format into a standard stream or file. This is an optional setting. The possible values are:

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
        
        This is an optional setting. If no settings are specified in the `cloud_logger` section, events will not be exported to the log group.

        To export synchronization agent logs to a log group, assign to the service account the additional `logging.writer` [role](../../logging/security/index.md#logging-writer) for the log group or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing it.

    {% note info %}

    If no settings are specified in the `logger.file` and `logger.cloud_logger` sections, the event and error info will be fed into a standard stream named `stdout`; otherwise, the logs will be saved to files and/or the log group.

    {% endnote %}

* `sync_settings`: Synchronization settings:

    * `interval`: [Incremental synchronization](../../organization/concepts/ad-sync.md#incremental-sync) frequency. This is an optional setting. The default value is 240 seconds.

        {% note info %}

        Password and user status synchronization in {{ microsoft-idp.ad-short }} takes place every few seconds at a fixed interval which does not depend on the `interval` value.

        {% endnote %}

    * `allow_to_capture_users`: Enables updating an existing user in the {{ org-full-name }} user pool if their login matches that of a {{ microsoft-idp.ad-short }} user being synchronized. The possible values are:

        * `true`: Synchronization agent will update existing {{ org-full-name }} users to match their corresponding {{ microsoft-idp.ad-short }} accounts.
        * `false`: Synchronization agent will not update existing {{ org-full-name }} users. If it detects matching logins in the user pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
    * `allow_to_capture_groups`: Enables updating an existing {{ org-full-name }} user group if its name matches that of a {{ microsoft-idp.ad-short }} group being synchronized. The possible values are:

        * `true`: Synchronization agent will update existing {{ org-full-name }} user groups to match their corresponding {{ microsoft-idp.ad-short }} groups.
        * `false`: Synchronization agent will not update existing {{ org-full-name }} groups. If it detects matching group names in the pool and {{ microsoft-idp.ad-short }}, the synchronization will throw an error.
    * `replacement_domain`: [Domain](../../organization/concepts/domains.md) associated with the {{ org-full-name }} user pool to which synchronized users and groups belong, e.g., `newdomain.idp.{{ dns-ns-host-sld }}`.

        This is an optional setting. Specify the `replacement_domain` value only if the domain name associated with the user pool does not match the domain name on the {{ microsoft-idp.ad-short }} domain controller.
    * `user_attribute_mapping`: User attribute mapping settings:

        * `source`: User attribute name obtained from {{ microsoft-idp.ad-short }} and different from the [default](../../organization/concepts/ad-sync.md#sync-objects) one.

            To disable attribute synchronization, leave empty: `source: ""`.
        * `target`: Name of the attribute in {{ yandex-cloud }} you want to configure mapping with (or disable synchronization for). For the list of available values, see **User attributes** in [{#T}](../../organization/concepts/ad-sync.md#sync-objects).
        * `type`: Selecting an action to take with the specified attribute. The possible values are:

            * `direct`: Configure attribute mapping.
            * `empty`: Disable attribute synchronization.

        This is an optional setting. You should specify the `user_attribute_mapping` value only if you need to map user attribute names different from the {{ microsoft-idp.ad-short }} default ones or to disable synchronization of individual attributes.
    * `group_attribute_mapping`: User group attribute mapping settings:

        * `source`: User group attribute name obtained from {{ microsoft-idp.ad-short }} and different from the [default](../../organization/concepts/ad-sync.md#sync-objects) one.

            To disable attribute synchronization, leave empty: `source: ""`.
        * `target`: Name of the attribute in {{ yandex-cloud }} you want to configure mapping with (or disable synchronization for). For the list of available values, see **User group attributes** in [{#T}](../../organization/concepts/ad-sync.md#sync-objects).
        * `type`: Selecting an action to take with the specified attribute. The possible values are:

            * `direct`: Configure attribute mapping.
            * `empty`: Disable attribute synchronization.

        This is an optional setting. You should specify the `group_attribute_mapping` value only if you need to map user group attribute names different from the {{ microsoft-idp.ad-short }} default ones or to disable synchronization of individual attributes.
    * `filter`: Settings for filtering objects to synchronize on the {{ microsoft-idp.ad-short }} side:

        * `domain`: Domain name in the {{ microsoft-idp.ad-short }} domain controller where the agent will synchronize users and groups.
        * `organization_units`: List of _organization units_ (OUs) in the {{ microsoft-idp.ad-short }} folder in which the agent will synchronize users and groups.
        * `groups`: List of user groups in the {{ microsoft-idp.ad-short }} folder in which the agent will synchronize users. You can specify one or more groups; filtering by multiple groups will use the `OR` logic.

            {% note info %}

            The `groups` parameter only affects user synchronization and not user group synchronization settings.

            {% endnote %}

        If object filtering is not configured, {{ ad-sync-agent }} will attempt to synchronize all [available objects](../../organization/concepts/ad-sync.md#sync-objects) in the {{ microsoft-idp.ad-short }} folder.
    * `remove_user_behavior`: Controls what action should be applied to users on the {{ yandex-cloud }} side if the corresponding ones on the {{ microsoft-idp.ad-short }} side were deleted or ceased to satisfy the conditions specified in `sync_settings.filter` (e.g., if moved to another organization unit). This is an optional setting. The possible values are:

        * `remove`: Users who were deleted ceased to satisfy the filter criteria will be deleted on the {{ org-full-name }} side. This is the default action.
        * `block`: Users who were deleted ceased to satisfy the filter criteria will be deactivated on the {{ org-full-name }} side.

    {% note info %}

    If synchronization reveals that a {{ microsoft-idp.ad-short }} user group was deleted or ceased to satisfy the filter criteria (e.g., if moved to another organization unit), such a group will be deleted on the {{ org-full-name }} side.

    {% endnote %}
