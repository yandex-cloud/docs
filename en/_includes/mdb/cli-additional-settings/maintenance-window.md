* `--maintenance-window`: Maintenance time settings.
    * `type=anytime`: Perform maintenance at any time.
    * `type=weekly`: Perform maintenance on a schedule. Select a time when query load on a cluster is lightest and use the comma-separated `day` and `hour` parameters to specify the maintenance start day and hour, such as: `type=weekly,day=wed,hour=14`.