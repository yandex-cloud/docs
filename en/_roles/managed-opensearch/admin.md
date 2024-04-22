The `managed-opensearch.admin` role allows you to manage OpenSearch clusters and view their logs, as well as get information on quotas and resource operations.

Users with this role can:
* Manage access to OpenSearch clusters.
* View information on OpenSearch [clusters](../../managed-opensearch/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View OpenSearch cluster logs.
* View information on [quotas](../../managed-opensearch/concepts/limits.md#quotas) of Managed Service for OpenSearch.
* View information on resource operations for Managed Service for OpenSearch.

This role also includes the `managed-opensearch.editor` permissions.

To create OpenSearch clusters, you also need the `vpc.user` role.