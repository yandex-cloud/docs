#### Transaction does not apply to all shards {#cross-shard-transaction-failure}

**Cause:** Two-phase fixation not enabled for cross-shard operations.
**Solution:** Enable two-phase fixation:

```sql
BEGIN;
SET __spqr__commit_strategy TO '2pc';
INSERT INTO orders ...; /* affects several shards */
COMMIT;
```

{% note warning %}

`max_prepared_transactions` must be greater than zero on all shards.

{% endnote %}

#### Queries are not routed to new shard {#queries-routing-fails-for-new-shard}

When adding a new shard, you may hit a situation where queries are not routed to it. To track query routing, you can:

* Enable `show_notice_message`.
* Use the `/* __spqr__reply_notice: true */` virtual parameter.

  You can set virtual parameters with comments in SQL or via `SET`.

In either case, the router will message to your app the shard the query was routed to.

**Solution:**

* Check whether the new shard is displayed in {{ SPQR }} (`SHOW shards`).
* If you are using a sharded table, make sure the data needs to be on this particular shard (`SHOW key_ranges`).
* If you are using a reference table, make sure the table was created on this particular shard (`SHOW reference_relations`).

#### _failed to get connection to any shard host within_ error when connecting to cluster hosts {#failed-to-get-connection}

Error example:

```bash
failed to get connection to any shard host within: host {rc1d-cofs7cre********.mdb.yandexcloud.net:6432 rc1d}: dial tcp 10.151.25.35:6432: i/o timeout, host {rc1b-49796b52********.mdb.yandexcloud.net:6432 rc1b}: dial tcp 10.149.25.23:6432: i/o timeout, host {rc1a-kdm7v4qm********.mdb.yandexcloud.net:6432 rc1a}: dial tcp 10.148.25.15:6432: i/o timeout
```

This error occurs if the [router](../../managed-spqr/concepts/index.md#router) cannot connect to the [shard](../../managed-spqr/concepts/index.md#shard) hosts.

**Solution:**

1. Make sure that the {{ mspqr-name }} cluster and shards are in the same network and [security group](../../vpc/concepts/security-groups.md).
1. [Add](../../vpc/operations/security-group-add-rule.md) to the security group the inbound and outbound traffic rules allowing TCP connection to port `6432`:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Specify the cluster CIDR, e.g., `10.96.0.0/16`.

#### _error processing query ... : syntax error_ when running a query {#error-processing-query}

This error occurs due to internal {{ SPQR }} problem, not because of syntax errors in your SQL query. {{ SPQR }} uses a proprietary SQL parser which may not support some of the nuances:

* {{ PG }}-specific operators.
* Rare syntax variants.
* Non-standard functions.

**Solution**: Report the problem to the {{ SPQR }} vendor by creating an issue in the [project’s Github repository](https://github.com/pg-sharding/spqr/issues) and attaching the full text of your query.

#### _permission denied for schema_ error {#permission-denied-for-schema}

This error occurs if the user does not have enough permissions to use a schema.

**Solution:** Use the `GRANT ALL ON SCHEMA <schema_name> TO <username>;` command to grant the user permissions for the schema on the relevant shard or all shards.

#### _failed to find primary within host_ error {#failed-to-find-primary}

This error means that your router fails to connect to the shard master within the specified time.

**Possible causes**:

* Network issues between the router and the shard.
* Shard overload (e.g., high _CPU wait_).
* Incorrect `target-session-attrs` settings (e.g., `read-only` in case of a write query).

**Solution:**

* Make sure the networking between the router and the shard is undisturbed.
* Increase computing resources in the {{ PG }} cluster which is the overloaded shard.
* Make sure the `target-session-attrs` settings match your query.

{% note info %}

This problem was supposed to be fixed in [release 2.9.0](https://github.com/pg-sharding/spqr/releases/tag/2.9.0). If you see this error in logs, create an issue in the [project’s Github repository](https://github.com/pg-sharding/spqr/issues).

{% endnote %}

#### _failed to match any datashard_ error or blocked query {#failed-to-match-any-datashard}

This error occurs when your router cannot match the query with a specific sharding key range. For example, if `default_route_behaviour` in the router configuration is set to `BLOCK`, queries without a sharding key are blocked.

**Solution:**

* Change the router's request matching behavior:

  * Permanently: Set `default_route_behaviour` to `ALLOW` in the router configuration.
  * Temporarily: Use the `/* __spqr__default_route_behaviour: allow */` virtual parameter.
* Check that:
  * Sharding key is correct in the query: its name in the query must match the key name in {{ SPQR }} metadata.
  * Sharding rules are in place (`SHOW distributions`).
  * Tables are in place (`SHOW relations`).
  * Ranges are in place (`SHOW key_ranges`).
* For multi-shard queries, activate engine_v2 via the `/* __spqr__engine_v2: true */` virtual parameter.

You can set virtual parameters with comments in SQL or via `SET`.
