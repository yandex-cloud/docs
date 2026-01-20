# {{ SPQR }} settings

For {{ mpg-name }} clusters, you can specify {{ SPQR }} settings using the management console. These settings are configured at the cluster level.

Router settings (**Router** → **Config**):

* **Show Notice Messages**

    It determines whether to include additional information, e.g., the shard name, host address, username, transaction status, etc., in the query response.

    This setting is disabled by default, i.e., the response includes no additional information.

    For more information, see the `show_notice_messages` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#debug-settings).

* **Time Quantiles**

    A list of time quantiles for displaying query execution time statistics. Time quantile values are floating-point numbers. If the list is empty, statistics are not collected.

    The default set is [`0.5`, `0.75`, `0.9`, `0.95`, `0.99`, `0.999`, `0.9999`].

    For more information, see the `time_quantiles` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#statistics-settings).

* **Default Route Behavior**

    It determines whether multishard queries are allowed:

    * `block`: Rejects multishard queries to safeguard data consistency. This is the default option.
    * `allow`: Allows multishard queries. This is useful for DDL and administrative queries.

    For more information, see the `query_routing.default_route_behaviour` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#query-routing-settings).

* **Prefer Same Availability Zone**

    If this setting is enabled, read-only queries will go to replica hosts in the router’s availability zone, whenever possible.

    This setting is enabled by default.

* **Enhanced Multishard Processing**

    It determines whether to enable enhanced processing for multishard queries.

    For more information, see the `query_routing.enhanced_multishard_processing` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#query-routing-settings).

    This setting is disabled by default, i.e., enhanced processing is not perfromed.

* **Default Target Session Attrs**

    It defines the default value for the [`target_session_attrs` {{ PG }} parameter]({{ pg.docs.org }}/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS) indicating the preferred session state when connecting to the database.

    The possible values are:

    * `any`: Connect to any available host regardless of its state.
    * `prefer standby`: Prefer replica hosts for connection. If none of them is available, connect to the master host.
    * `read only`: Connect only to replica hosts. If none of them is available, the connection fails.
    * `read write` (default): Connect only to the master host. If it is not available, the connection fails.
    * `smart read write`: Connect to the master host. If it is not available, the connection fails. If the configuration file specifies `true` for the `query_routing.auto_route_ro_on_standby` setting, read-only queries are automatically redirected to replica hosts (with the `prefer standby` semantics).

    For more information, see the `query_routing.default_target_session_attrs` and `query_routing.auto_route_ro_on_standby` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#query-routing-settings).

* **Default Commit Strategy**

    It defines the commit strategy for distributed transactions:

    * `best effort`: One-stage commit without coordination between shards.
    * `one pc` (default): Alias for `best-effort`.
    * `two pc`: Two-stage commit with guaranteed automicity between shards.

    For more information, see the `default_commit_strategy` setting description in [this {{ SPQR }} guide]({{ spqr.docs }}/configuration/router#transaction-settings).
