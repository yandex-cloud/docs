* `batch_settings`: Event grouping settings. This is an optional section.

    * `cutoff`: Maximum event grouping time. This is a required setting. After the specified time has passed, the trigger sends the event group, even if it is not complete.
    * `max_count`: Maximum number of events per group.
    * `max_bytes`: Maximum total size of events per group, in bytes.

    At least one of the parameters, `max_count` or `max_bytes`, must be greater than 0.
