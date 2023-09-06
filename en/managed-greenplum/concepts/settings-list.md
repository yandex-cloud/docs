# {{ GP }} settings

For {{ mgp-name }} clusters, you can configure {{ GP }} settings.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or Terraform. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the selected interface, the same setting may be represented in a different way. For example, **Max connections** in the management console is:

* `max_connections` in the gRPC API
* `maxConnections` in the REST API

## Cluster-level DBMS settings {#dbms-cluster-settings}

You can use the following settings:

{% include [mgp-dbms-settings](../../_includes/mdb/mgp/dbms-settings.md) %}
