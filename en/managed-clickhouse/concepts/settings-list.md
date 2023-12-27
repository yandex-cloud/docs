# {{ CH }} settings

For {{ mch-name }} clusters, you can configure {{ CH }} settings. Some settings are configured [at the cluster level](#dbms-cluster-settings), while others, [at the user level](#user-level-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, SQL, or {{ TF }}. The {{ tag-all }} label means that all of the above interfaces are supported.

Depending on the selected interface, the same setting may be represented in a different way, e.g.:

- **Geobase uri** in the management console is the same as:
   - `geobase_uri` in the gRPC API and {{ TF }}.
   - `geobaseUri` in the REST API.
- **Allow DDL** in the management console is the same as:
   - `allow_ddl` in the CLI, gRPC API, and SQL.
   - `allowDdl` in the REST API.


## Cluster-level settings {#dbms-cluster-settings}

You can use the following settings:

{% include [mch-dbms-settings](../../_includes/mdb/mch-dbms-settings.md) %}

## User-level settings {#user-level-settings}

### Quota settings {#quota-settings}

Quotas allow you to limit the consumption of {{ CH }} resources for a specified time interval. Quota settings are set for an individual user.

If the user exceeds one of the quota limits, they will not be able to execute new queries until the interval expires.
{{ CH }} will display a message about exceeding the quota and inform the user when the next interval starts. At the beginning of the new interval, the user will be able to run queries again and the limit counters will be reset.

{{ CH }} also uses quotas to account for resource consumption.
For each user, there is a default quota that considers the consumption of all resources per hour but does not impose any restrictions.
The information about the resource consumption level is written to the {{ CH }} server log.

To learn more, see the [{{ CH }} documentation]({{ ch.docs }}/operations/quotas/).

You can use the following quota settings:

{% include [mch-quota-user-settings](../../_includes/mdb/mch-quota-user-settings.md) %}

### DBMS settings {#dbms-user-settings}

These settings apply at the individual user level.

You can use the following settings:

{% include [mch-dbms-user-settings](../../_includes/mdb/mch-dbms-user-settings.md) %}

## Custom settings {#custom-settings}

{{ tag-sql }}

You can redefine [custom settings]({{ ch.docs }}/operations/settings/#custom_settings) as variables in the [settings profile]({{ ch.docs }}/operations/access-rights/#settings-profiles-management), session, or request. Working with settings profiles is available if the [user management via SQL](../operations/cluster-users.md#sql-user-management) is enabled for the cluster.

The name of the user setting in {{ mch-name }} must start with the `custom_` predefined prefix. The prefix is fixed and the users cannot change it.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
