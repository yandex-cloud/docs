* `logger`: Synchronization [logging](../../../organization/concepts/ad-sync/sync-agent.md#logging) settings:

    * `level`: Logging level. The possible values are:

        {% include [ad-sync-log-levels](../ad-sync-log-levels.md) %}

    * `format`: Event info output format into a standard stream or file. This is an optional setting. The possible values are:

        * `plain`: Output the info as plain text. This is a default value.
        * `json`: Output the info in [JSON](https://en.wikipedia.org/wiki/JSON) format.
    * `file`: Settings for saving logs to files:

        * `filename`: Path to the file for logging synchronization events.

            In the `filename` setting, you can provide only the file name instead of the full path. In this case, the system will save that file in the working directory specified in `working_directory` or, if none is specified, in the directory the agent's executable is in.

            This is an optional setting. The default file name is `identity_hub.log`.
        * `maxsize`: Maximum size of a single log file, in MB.
        * `maxbackups`: Maximum number of log files the agent will retain. When this limit is exceeded, the oldest file will be deleted.

        This is an optional setting. If no settings are specified in the `file` section, events will not be saved to files.
    * `cloud_logger`: Settings for saving logs to a {{ cloud-logging-full-name }} [log group](../../../logging/concepts/log-group.md):

        * `log_group_id`: ID of the log group to export the synchronization agent logs to.
        
        This is an optional setting. If no settings are specified in the `cloud_logger` section, events will export to a log group.

        To export synchronization agent logs to a log group, assign to the service account the additional `logging.writer` [role](../../../logging/security/index.md#logging-writer) for the log group or [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing it.

    {% note info %}

    If no settings are specified in the `logger.file` and `logger.cloud_logger` sections, the event and error info will be fed into a standard stream named `stdout`; otherwise, the logs will be saved to files and/or the log group.

    {% endnote %}