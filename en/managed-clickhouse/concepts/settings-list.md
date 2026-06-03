# {{ CH }} settings

For {{ mch-name }} clusters, you can specify these {{ CH }} settings:

   * [Server-level settings](#server-level-settings): Configured at the shard or cluster level. In a custom {{ CH }} installation, you can change these settings only via configuration files, while in {{ mch-name }} clusters, only via the {{ yandex-cloud }} interfaces.
   * [Query-level settings](#user-level-settings): Configured at the user, session, or query level.
   * [Quota settings](#quota-settings): Configured at the user level.

{% note info %}

{{ CH }} supports more settings than the {{ yandex-cloud }} interfaces. You can use SQL queries to change {{ CH }} settings, e.g., [specify {{ CH }} settings at the query level](../operations/change-query-level-settings.md) or [change the settings for MergeTree tables](../operations/change-server-level-settings.md#sql-queries).

{% endnote %}

The label next to the setting name identifies the interface used to specify this setting: the management console, CLI, API, SQL, or {{ TF }}. The {{ tag-all }} label means you can use any of the above interfaces.

The name for a setting depends on the interface you use, e.g.:

- **Geobase uri** in the management console is the same as:
   - `geobase_uri` in the gRPC API and {{ TF }}.
   - `geobaseUri` in the REST API.
- **Allow DDL** in the management console is the same as:
   - `allow_ddl` in the CLI, gRPC API, and SQL.
   - `allowDdl` in the REST API.

## Server-level settings {#server-level-settings}

{% note info %}

To reset to default values using {{ TF }}, specify these values explicitly for the settings in the manifest. Deleting settings from the manifest will not reset them to their defaults.

{% endnote %}

The following settings are available:

{% include [mch-dbms-settings](../../_includes/mdb/mch-dbms-settings.md) %}

## Query-level settings {#user-level-settings}

### DBMS settings {#dbms-user-settings}

These settings apply at the individual user level.

{% note info %}

To reset to default values using {{ TF }}, specify these values explicitly for the settings in the manifest. Deleting settings from the manifest will not reset them to their defaults.

{% endnote %}

The following settings are available:

{% include [mch-dbms-user-settings](../../_includes/mdb/mch-dbms-user-settings.md) %}

### Custom settings {#custom-settings}

You can override [custom settings]({{ ch.docs }}{{ lang }}/operations/settings#custom_settings) as variables in the [settings profile]({{ ch.docs }}{{ lang }}/operations/access-rights#settings-profiles-management), session, or query. You can use settings profiles if the [user management via SQL](../operations/cluster-users.md#sql-user-management) is enabled for the cluster.

In {{ mch-name }}, the name of the custom setting must be prefixed by `custom_`. This prefix is non-editable, i.e., you cannot change it.

## Quota settings {#quota-settings}

Quotas allow you to limit the consumption of {{ CH }} resources for a specified time period. Quota settings apply to an individual user.

If one of the quota limits is exceeded, the user will not be able to run new queries until the set time period ends.
{{ CH }} will display a message about the quota being exceeded and when the next time period starts, and the query ban will be lifted with the limit counters reset.

{{ CH }} also uses quotas to calculate resource consumption.
For each user, there is a default quota that covers the consumption of all resources per hour but does not impose any limits.
The resource consumption level information is logged on the {{ CH }} server.

For more information, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/operations/quotas).

You can use the following quota settings:

{% include [mch-quota-user-settings](../../_includes/mdb/mch-quota-user-settings.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
