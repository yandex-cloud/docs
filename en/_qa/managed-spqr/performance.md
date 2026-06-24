#### How to improve performance? {#how-to-improve-performance}

* Increase the resources (CPU, RAM) of your existing routers.

* Add new routers.

* Disable debug logging for routers to reduce load on your computing resources.

* In the router configuration, disable `show_notice_messages` because NOTICE messages increase load on {{ SPQR }}.

* Avoid frequent reconnections: set up connection pooling in your application.

* Enable reading from replicas. Do it by providing this virtual parameter in an SQL query:

  ```sql
  SELECT * FROM orders /* target-session-attrs: read-only */;
  ```
* Limit execution time for long queries:

  ```sql
  SET session_duration_timeout = '5min';
  ```

#### How to reduce reading latency? {#how-to-decrease-read-latency}

* Enable reading from replicas:

  ```sql
  SELECT * FROM table /* target-session-attrs: read-only */;
  ```

* Increase `max_connections` for the user.

#### How to limit the load caused by data uploads? {#how-to-improve-data-upload-performance}

* Create a separate user and limit the number of connections for them (`conn_limit` setting).
* Use a dedicated router for ETL operations.
* Set `session_duration_timeout` to automatically end long sessions.

#### How to set up reading from replicas? {#how-to-read-from-replicas}

You can specify multiple servers for one shard in the configuration. The router will automatically distribute read-only queries across replicas. For a specific query, you can explicitly set the `target-session-attrs` parameter:

* `read-write` (default): Queries only to the master.
* `smart-read-write`: Queries only to the master, but with read-only queries redirected to replicas.
* `read-only`: Queries only to replicas (if available).
* `prefer-standby` or `prefer-replica`: Queries to replicas. If none are available, queries are forwarded to the master.
* `any`: Queries to any available node (preferably local). To reduce latency, we recommend to use this value in conjunction with closest host selection.

#### What resources are required for routers and coordinators? {#router-and-coordinator-resources}

We recommend selecting the computing resource configuration for the router and coordinator based on the expected load.

Recommended configurations for a load of 20,000 read requests per second:

#|
|| Level of requirements | Router configuration | Coordinator configuration | General configuration ||

|| Minimum 
| 
* Three routers. Each router's host class must include four vCPUs with a vCPU guarantee of 100% and 16 GB of RAM.
* `local-ssd` disk, 10 GB
| 
* Three coordinators. Each coordinator's host class must include two vCPUs with a guaranteed vCPU share of 100% and 4 GB of RAM.
* `local-ssd` disk, 10 GB
|
* 18 vCPUs with a vCPU guarantee of 100%.
* 60 GB RAM.
* `local-ssd` disks, 60 GB
||
|| Optimal
|
* Three routers. Each router's host class must include four vCPUs with a vCPU guarantee of 100% and 16 GB of RAM.
* `local-ssd` disk, 10 GB
|
* Three coordinators. Each coordinator's host class must include two vCPUs with a vCPU guarantee of 100% and 8 GB of RAM.
* `local-ssd` disk, 10 GB
|
* 18 vCPUs with a vCPU guarantee of 100%.
* 72 GB RAM.
* `local-ssd` disks, 60 GB
||
|| With a margin
|
* Five routers. Each router's host class must include four vCPUs with a vCPU guarantee of 100% and 16 GB of RAM.
* `local-ssd` disk, 10 GB
|
* Three coordinators. Each coordinator's host class must include two vCPUs with a vCPU guarantee of 100% and 8 GB of RAM.
* `local-ssd` disk, 10 GB
|
* 26 vCPUs with a vCPU guarantee of 100%.
* 104 GB RAM.
* `local-ssd` disks, 80 GB
||
|#

To calculate the cost of a {{ mspqr-name }} cluster, [use this calculator](https://yandex.cloud/en/services/managed-spqr#calculator).
