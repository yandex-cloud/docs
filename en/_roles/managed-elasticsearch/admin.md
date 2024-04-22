The `managed-elasticsearch.admin` role allows you to manage Elasticsearch clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* Manage access to Elasticsearch [clusters](../../managed-elasticsearch/concepts/index.md).
* View information on Elasticsearch clusters, as well as create, modify, delete, run, and stop them.
* View Elasticsearch cluster logs.
* View information on [quotas](../../managed-elasticsearch/concepts/limits.md#mes-quotas) of Managed Service for Elasticsearch.
* View information on resource operations for Managed Service for Elasticsearch.

This role also includes the `managed-elasticsearch.editor` permissions.

To create Elasticsearch clusters, you also need the `vpc.user` role.