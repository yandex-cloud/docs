The `managed-trino.admin` role enables managing Trino clusters and performing operations on them, as well as viewing the quotas for Managed Service for Trino.

Users with this role can:
* View info on Trino clusters, as well as create, modify, run, stop, and delete them.
* Use the Trino web UI.
* Send requests to the Trino API.
* View info on the quotas for Managed Service for Trino.

This role also includes the `managed-trino.editor` permissions.

To create Trino clusters, you also need the `vpc.user` role.