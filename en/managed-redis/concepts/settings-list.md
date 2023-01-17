# {{ RD }} settings

For {{ mrd-name }} clusters, you can configure settings that relate to {{ RD }}.

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented differently. For example, **Maxmemory policy** has the following counterparts in the management console:

- `maxmemory_policy` in the gRPC API and {{ TF }}.
- `maxmemoryPolicy` in the REST API.

## DBMS settings {#dbms-settings}

You can use the following settings:

{% include [mrd-dbms-settings](../../_includes/mdb/mrd-dbms-settings.md) %}
