# {{ MG }} settings

For {{ mmg-name }} clusters, you can configure settings that relate to {{ MG }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, or Terraform. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented in different ways. For example, **Max incoming connections** in the management console matches:

- `max_incoming_connections` in gRPC, CLI, or Terraform.
- `maxIncomingConnections` in the REST API.

## Cluster-level DBMS settings {#dbms-cluster-settings}

{% include [mmg-dbms-settings](../../_includes/mdb/mmg-dbms-settings.md) %}

