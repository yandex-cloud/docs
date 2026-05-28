* `root_groups`: Resource group tree description. The `name`, `hard_concurrency_limit`, and `max_queued` settings are required.
  * `name`: Group name.

    A group name can be a template that uses variable placeholders in `${<variable_name>}` format. A template name may contain the following types of variables:
    * Built-in variables. `USER` for username, `SOURCE` for query source.
    * User-defined variables. These are declared in selector rule properties: `user`, `user_group`, and `source`.

    When routing queries, {{ mtr-name }} will create group instances with dynamically generated names.

  * `soft_memory_limit`: Maximum amount of memory available to the group. Once this limit is reached, new queries will be queued. You can set `soft_memory_limit` in one of the following ways:
    * As a percentage of the total available memory, e.g., `10%`.
    * As an absolute memory value, e.g., `1GB`. You can use one of these suffixes: `B`, `kB`, `MB`, `GB`, `TB`, or `PB`.
  * `soft_concurrency_limit`: Soft limit on the number of running queries. Once the limit is reached, the group will run new queries only if sibling groups are unable to accept queries or are above their soft limits. Otherwise, new queries will be queued.
  * `hard_concurrency_limit`: Hard limit on the number of running queries. Once this limit is reached, new queries will be queued.
  * `soft_cpu_limit`: Soft limit on CPU time. Once this limit is reached, `hard_concurrency_limit` will be reduced until the end of the current CPU quota calculation period. `soft_cpu_limit` cannot be greater than `hard_cpu_limit`.
  * `hard_cpu_limit`: Hard limit on CPU time. Once this limit is reached, new queries will be queued.

  {% note info %}

  If at least one of the two (`soft_cpu_limit` or `hard_cpu_limit`) is specified, make sure to specify `cpu_quota_period` as well.

  {% endnote %}

  * `max_queued`: Maximum number of queries per queue. Once this limit is reached, new queries will be rejected with an error.
  * `scheduling_policy`: [Queue scheduling policy](../../managed-trino/concepts/resource-groups.md#policy). The possible values are:
    * `FAIR`
    * `WEIGHTED`
    * `WEIGHTED_FAIR`
    * `QUERY_PRIORITY`

    If not specified, the `FAIR` policy will apply.

  * `scheduling_weight`: Group weight used in the `WEIGHTED` and `WEIGHTED_FAIR` scheduling policies.

    If not specified, the group weight is `1`.

  * `sub_groups`: Descriptions of sub-groups.

* `selectors`: Selector rule description. The `group` property is required.
  * `user`: Name of the user who submitted the query or a Java regular expression. The rule applies if the user name matches the regular expression. If not specified, the rule applies to queries from all users.
  * `user_group`: Name of the user group that submitted the query or a Java regular expression for user groups. The rule applies if the user group name matches the regular expression. If not specified, the rule applies to queries from users of any groups.
  * `query_type`: Type of the request. The possible values are:
    * `SELECT`: `SELECT` queries.
    * `EXPLAIN`: `EXPLAIN` queries, except `EXPLAIN ANALYZE`.
    * `DESCRIBE`: `DESCRIBE`, `DESCRIBE INPUT`, and `DESCRIBE OUTPUT` queries, as well as `SHOW` queries, e.g., `SHOW CATALOGS` or `SHOW SCHEMAS`.
    * `INSERT`: `INSERT`, `CREATE TABLE AS`, and `REFRESH MATERIALIZED VIEW` queries.
    * `MERGE`: `MERGE` queries.
    * `DELETE`: `DELETE` queries.
    * `ANALYZE`: `ANALYZE` queries.
    * `DATA_DEFINITION`: `CREATE`, `ALTER`, and `DROP` queries for schemas, tables, views, and materialized views, as well as queries that manage prepared statements, access permissions, sessions, and transactions.
    * `ALTER_TABLE_EXECUTE`: `ALTER TABLE ... EXECUTE` queries.

  * `source`: Query source name or a Java regular expression. The rule applies if the query source name matches the regular expression. If not specified, the rule applies to queries from all sources.
  * `client_tags`: Tag list. The rule applies only if the query contains all the specified tags. If not specified, the rule applies to queries with any tags.
  * `group`: Full name of the target resource group. It includes the names of all its parent groups, separated by dots, starting from the root group. A group name can use variable placeholders in `${<variable_name>}` format. A target group cannot have sub-groups.

  {% note warning %}

  A query that does not satisfy any of the specified rules is rejected with an error. To avoid this, add to the end of the description a rule without any restrictive conditions, containing only the `group` property.

  {% endnote %}

* `cpu_quota_period`: CPU quota calculation period for resource groups. It takes an integer value in seconds, minutes, or hours, e.g., `140s`, `30m`, or `1h`.

For more information about the group tree and selector rules, see [{#T}](../../managed-trino/concepts/resource-groups.md).
