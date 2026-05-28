1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user_3spf1 }}** field, specify the name of the user who submitted the query or a Java regular expression. The rule applies if the user name matches the regular expression. If you skip this setting, the rule applies to queries from all users.
1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user-group_qRK1P }}** field, specify the name of the user group that submitted the query or a Java regular expression. The rule applies if the user group name matches the regular expression. If not specified, the rule applies to queries from users of any groups.
1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_query-type_69gwq }}** field, select the query type. The possible values are:
   * `SELECT`: `SELECT` queries.
   * `EXPLAIN`: `EXPLAIN` queries, except `EXPLAIN ANALYZE`.
   * `DESCRIBE`: `DESCRIBE`, `DESCRIBE INPUT`, and `DESCRIBE OUTPUT` queries, as well as `SHOW` queries, e.g., `SHOW CATALOGS` or `SHOW SCHEMAS`.
   * `INSERT`: `INSERT`, `CREATE TABLE AS`, and `REFRESH MATERIALIZED VIEW` queries.
   * `MERGE`: `MERGE` queries.
   * `DELETE`: `DELETE` queries.
   * `ANALYZE`: `ANALYZE` queries.
   * `DATA_DEFINITION`: `CREATE`, `ALTER`, and `DROP` queries for schemas, tables, views, and materialized views, as well as queries that manage prepared statements, access permissions, sessions, and transactions.
   * `ALTER_TABLE_EXECUTE`: `ALTER TABLE ... EXECUTE` queries.

1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_source_5knZL }}** field, specify the name of the query source or a Java regular expression. The rule applies if the query source name matches the regular expression. If not specified, the rule applies to queries from all sources.
1. In the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_resource-group_qjdHa }}** field, select the resource group to run the query in. A target group cannot have sub-groups.
1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label-client-tags_eyQNn }}** field, specify tags separated by commas. The rule applies only if the query contains all the specified tags. If not specified, the rule applies to queries with any tags.

{% note warning %}

A query that does not satisfy any of the specified rules is rejected with an error. To avoid this, add to the end of the description a rule without any restrictive conditions, containing only the **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_resource-group_qjdHa }}** property.

{% endnote %}

Learn more about selector rules in [{#T}](../../managed-trino/concepts/resource-groups.md).
