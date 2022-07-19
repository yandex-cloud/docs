# {{ MS }} settings

For {{ mms-name }} clusters, you can configure settings that relate to {{ MS }}.

The label next to the setting name lets you determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or {{ TF }}. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented in a different way, for example, **Fill factor percent** has the following counterparts in the management console:

* `fill_factor_percent` in gRPC API, CLI, {{ TF }}, and SQL.
* `fillFactorPercent` in the REST API.

You can use the following settings:

{% include [mms-dbms-settings](../../_includes/mdb/mms-dbms-settings.md) %}

