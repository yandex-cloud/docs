The `managed-elasticsearch.editor` role allows you to manage Elasticsearch clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* View information on Elasticsearch [clusters](../../managed-elasticsearch/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View Elasticsearch cluster logs.
* View information on [quotas](../../managed-elasticsearch/concepts/limits.md#mes-quotas) of Managed Service for Elasticsearch.
* View information on resource operations for Managed Service for Elasticsearch.

This role includes the permissions of the `managed-elasticsearch.viewer` role.

To create Elasticsearch clusters, you also need the `vpc.user` role.