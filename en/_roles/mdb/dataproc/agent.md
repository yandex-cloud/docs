
The `mdb.dataproc.agent` role allows the service account linked to the {{ dataproc-name }} cluster to notify Data Processing of the cluster host state.

Service accounts with this role can:
* Notify {{ dataproc-name }} of the cluster host state.
* Get info on jobs and their progress statuses.
* Get info on log groups and add entries to them.

You can assign this role to a service account linked to the {{ dataproc-name }} cluster.

This role is no longer available. Please use `dataproc.agent` instead.