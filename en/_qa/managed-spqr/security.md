#### How is data security ensured? {#data-security}

{{ SPQR }} stores only data location metadata. Data security is ensured by [{{ mpg-name}}](../../managed-postgresql/) by providing:

* TLS 1.3 traffic encryption for all connections (client ↔ router ↔ shard).
* Audit, with [access logs](../../managed-spqr/at-ref.md) stored in [{{ at-full-name }}](../../audit-trails/) for 30 days. [Learn more about viewing logs in a {{ mspqr-name }} cluster](../../managed-spqr/operations/cluster-logs.md).

#### Can my credentials leak through the router? {#router-security}

No, your credentials are secure. The risks are comparable to using a connection pooler, e.g., [Odyssey](https://yandex.ru/dev/odyssey/). Your data does go through {{ SPQR }}, but the security practices are as per [{{ yandex-cloud }} standards](../../security/standarts.md).

#### How do I set up backups? {#how-to-set-up-backups}

Backups are run automatically for all deployed clusters. Optionally, you can specify the start time and select the retention period for your backups. [Learn more about setting up backups in {{ mspqr-name }}](../../managed-spqr/operations/cluster-backups.md).

#### How do I ensure high availability? {#high-availability}

To ensure high availability of your {{ mspqr-name }} cluster:

* Create shards so that each shard, i.e., {{ mpg-name }} cluster, includes at least three hosts (master and replicas) located in different availability zones.
* For {{ mspqr-name }} clusters with standard sharding, create at least three `INFRA` hosts in different availability zones.
* For {{ mspqr-name }} clusters with advanced sharding, create at least three `COORDINATOR` hosts and three `ROUTER` hosts in different availability zones.

#### What happens in case of overloads? {#overload-behaviour}

An overloaded replica becomes unavailable, and the cluster stops sending requests to it until it recovers. 

Let's assume your cluster receives 95% of write requests and 5% of read requests. If your router configuration is `default_target_session_attrs = read-only`, read requests are evenly distributed among replicas. If a replica becomes unavailable, e.g., `SELECT pg_is_in_recovery();` times out, the service stops sending requests to that replica and proceeds to check its health. As soon as the replica responds, requests to it are resumed.

#### What happens if a query is canceled? {#cancel-query-processing}

The application terminates the current router connection, establishes a new one, and sends a cancel message with the query ID to the router. The router receives the cancel message and forwards it to the shard the query is addressed to.

{% note tip %}

Canceling a query results in reconnections and increases TLS handshake overhead, so we do not recommend using timeouts under 100 ms.

{% endnote %}

#### Are there risks of query duplication is using a load balancer upstream of the routers?

Yes. If a client terminates the connection and the load balancer retries the request, {{ SPQR }} will treat it as a new request, which may result in duplication, e.g., for `INSERT`. We recommend using idempotent operations or implementing deduplication logic at the application layer.

#### How do I restrict access to the administrative console? {#restrict-access-to-admin-console}

Access to the administrative console is restricted by default. You can [connect](../../managed-spqr/operations/connect.md) to the console only via TLS using a password.

You set a password for access to the administrative console when [creating a cluster](../../managed-spqr/operations/cluster-create.md). If you need to, you can [change the password](../../managed-spqr/operations/cluster-update.md) on an active cluster.
