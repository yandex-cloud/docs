# {{ VLK }} settings

For a {{ mrd-name }} cluster, you can set {{ VLK }} settings.

The label next to the setting name shows which interface can be used to configure this setting: the management console, CLI, API, or {{ TF }}. The {{ tag-all }} label means you can use any of the above interfaces.

Depending on the interface you select, the same setting may look differently. For example, **Maxmemory policy** in the management console is the same as:

- `maxmemory_policy` in the gRPC API and {{ TF }}
- `maxmemoryPolicy` in the REST API

## DBMS settings {#dbms-settings}

The following settings are available:

{% include [mrd-dbms-settings](../../_includes/mdb/mrd-dbms-settings.md) %}
