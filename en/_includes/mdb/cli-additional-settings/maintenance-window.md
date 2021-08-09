* `--maintenance-window`: The maintenance window settings. You can use the settings to specify the preferred start time for cluster host maintenance (for example, you can select the time when the cluster is least loaded with requests):
    * `type=anytime`: Perform maintenance at any time.
    * `type=weekly`: Perform maintenance on schedule. In the `day` and `hour` parameters, specify the preferred day and hour of the start of the maintenance window, separated by a comma. For example: `type=weekly,day=wed,hour=14`.
By default, maintenance can be performed at any time.

