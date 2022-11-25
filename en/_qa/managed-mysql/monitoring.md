# Monitoring and logs in {{ mmy-name }}

#### How do I view cluster and host charts? {#charts}

In the [management console]({{ link-console-main }}), go to the cluster page. To view [cluster charts](../../managed-mysql/operations/monitoring.md#monitoring-cluster), go to **Monitoring**. To find [individual host charts](../../managed-mysql/operations/monitoring.md#monitoring-hosts), go to **Hosts** → **Monitoring**.

To view charts in [{{ monitoring-full-name }}](https://monitoring.cloud.yandex.com/), on the home page, select the **{{ mmy-short-name }}** service dashboard. To view the individual metrics, go to the **Metric Explorer** section and set the `service` parameter to **{{ mmy-short-name }}**.


#### How do I set up alerts? {#alerts}

You can configure alerts using [{{ monitoring-full-name }}](https://monitoring.cloud.yandex.com/): To do this, follow the instructions under [{#T}](../../monitoring/operations/alert/create-alert.md).

When selecting a metric, set the `service` parameter to **{{ mmy-short-name }}**.


#### How do I view logs? {#logs}

{% list tabs %}

- Management console

   1. Go to the cluster page and click the **Logs** tab.
   1. At the top of the page, select an available log:
      * `MYSQL_ERROR`: Primary {{ MY }} log containing error messages. Always enabled.
      * `MYSQL_SLOW_QUERY`: Slow query information. Enabled if `long_query_time` is greater than `0`.
      * `MYSQL_AUDIT`: Information on database connections.
      * `MYSQL_GENERAL`: Full query list. We recommend enabling it only for cluster debugging purposes in a development environment.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view the logs:

      ```
      {{ yc-mdb-my }} cluster list-logs --help
      ```

   1. Run the command: `{{ yc-mdb-my }} cluster cluster list-logs`.

{% endlist %}

#### How do I view current queries? {#current-queries}

To view the current user's queries, run:

```sql
SHOW PROCESSLIST;
```

Fore a detailed description of the output, please see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/show-processlist.html).

#### What other troubleshooting information is available? {#trouble-info}

A user with a `PROCESS` cluster-level [privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) can run the queries below:
* `SHOW FULL PROCESSLIST;`
* `SHOW ENGINE INNODB STATUS;`
* `SELECT` from the `performance_schema` and the `sys` system schemas.

To grant a user the `PROCESS` privilege, run the [CLI](../../cli/) command below:

```bash
{{ yc-mdb-my }} user update \
    --global-permissions PROCESS <username> \
    --cluster-id <cluster ID>
```
