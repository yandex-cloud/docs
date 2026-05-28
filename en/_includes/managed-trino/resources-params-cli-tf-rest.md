* `rootGroups`: Resource group tree description. The `name`, `hardConcurrencyLimit`, and `maxQueued` settings are required.
  * `name`: Group name.

    A group name can be a template that uses variable placeholders in `${<variable_name>}` format. A template name may contain the following types of variables:
    * Built-in variables. `USER` for username, `SOURCE` for query source.
    * User-defined variables. These are declared in selector rule properties: `user`, `userGroup`, and `source`.

    When routing queries, {{ mtr-name }} will create group instances with dynamically generated names.

  * `softMemoryLimit`: Maximum amount of memory available to the group. Once this limit is reached, new queries will be queued. You can set `softMemoryLimit` in one of the following ways:
    * As a percentage of the total available memory, e.g., `10%`.
    * As an absolute memory value, e.g., `1GB`. You can use one of these suffixes: `B`, `kB`, `MB`, `GB`, `TB`, or `PB`.
  * `softConcurrencyLimit`: Soft limit on the number of running queries. Once the limit is reached, the group will run new queries only if sibling groups are unable to accept queries or are above their soft limits. Otherwise, new queries will be queued.
  * `hardConcurrencyLimit`: Hard limit on the number of running queries. Once this limit is reached, new queries will be queued.
  * `softCpuLimit`: Soft limit on CPU time. Once this limit is reached, `hardConcurrencyLimit` will be reduced until the end of the current CPU quota calculation period. `softCpuLimit` cannot be greater than `hardCpuLimit`.
  * `hardCpuLimit`: Hard limit on CPU time. Once this limit is reached, new queries will be queued.

  {% note info %}

  If at least one of the two (`softCpuLimit` or `hardCpuLimit`) is specified, make sure to specify `cpuQuotaPeriod` as well.

  {% endnote %}

  * `maxQueued`: Maximum number of queries per queue. Once this limit is reached, new queries will be rejected with an error.
  * `schedulingPolicy`: [Queue scheduling policy](../../managed-trino/concepts/resource-groups.md#policy). The possible values are:
    * `FAIR`
    * `WEIGHTED`
    * `WEIGHTED_FAIR`
    * `QUERY_PRIORITY`

    If not specified, the `FAIR` policy will apply.

  * `schedulingWeight`: Group weight used in the `WEIGHTED` and `WEIGHTED_FAIR` scheduling policies.

    If not specified, the group weight is `1`.

  * `subGroups`: Descriptions of sub-groups.

* `selectors`: Selector rule description. The `group` property is required.
  * `user`: Name of the user who submitted the query or a Java regular expression. The rule applies if the user name matches the regular expression. If not specified, the rule applies to queries from all users.
  * `userGroup`: Name of the user group that submitted the query or a Java regular expression for user groups. The rule applies if the user group name matches the regular expression. If not specified, the rule applies to queries from users of any groups.
  * `queryType`: Type of the request. The possible values are:
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
  * `clientTags`: Tag list. The rule applies only if the query contains all the specified tags. If not specified, the rule applies to queries with any tags.
  * `group`: Full name of the target resource group. It includes the names of all its parent groups, separated by dots, starting from the root group. A group name can use variable placeholders in `${<variable_name>}` format. A target group cannot have sub-groups.

  {% note warning %}

  A query that does not satisfy any of the specified rules is rejected with an error. To avoid this, add to the end of the description a rule without any restrictive conditions, containing only the `group` property.

  {% endnote %}

* `cpuQuotaPeriod`: CPU quota calculation period for resource groups. It takes an integer value in seconds, minutes, or hours, e.g., `140s`, `30m`, or `1h`.

For more information about the group tree and selector rules, see [{#T}](../../managed-trino/concepts/resource-groups.md).
