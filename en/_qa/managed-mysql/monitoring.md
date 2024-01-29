# Monitoring and logs in {{ mmy-name }}

#### How do I view cluster and host charts? {#charts}

In the [management console]({{ link-console-main }}), go to the cluster page. To view [cluster charts](../../managed-mysql/operations/monitoring.md#monitoring-cluster), go to **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}**. To find [individual host charts](../../managed-mysql/operations/monitoring.md#monitoring-hosts), go to **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.

To view charts in [{{ monitoring-full-name }}]({{ link-monitoring }}), on the home page, select the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}** service dashboard. To view individual metrics, go to the **{{ ui-key.yacloud_monitoring.header.title.mx-mode }}** section and set the `service` parameter to **{{ ui-key.yacloud_monitoring.services.label_mysql }}**.

#### How do I view logs? {#logs}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the cluster page and click the **{{ ui-key.yacloud.mysql.cluster.switch_logs }}** tab.
   1. At the top of the page, select an available log:
      * `MYSQL_ERROR`: Primary {{ MY }} log containing error messages; always enabled.
      * `MYSQL_SLOW_QUERY`: Slow query information; enabled if `long_query_time` is greater than `0`.
      * `MYSQL_AUDIT`: Information on database connections.
      * `MYSQL_GENERAL`: Full query list. We recommend enabling it only for cluster debugging purposes in the development environment.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to view the logs:

      ```
      {{ yc-mdb-my }} cluster list-logs --help
      ```

   1. Run the command: `{{ yc-mdb-my }} cluster cluster list-logs`.

{% endlist %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### How do I view current queries? {#current-queries}

To view the current user's queries, run:

```sql
SHOW PROCESSLIST;
```

For a detailed description of the output, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/show-processlist.html).

#### What other troubleshooting information is available? {#trouble-info}

A user with a `PROCESS` cluster-level [privilege](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) can run the queries below:
* `SHOW FULL PROCESSLIST;`
* `SHOW ENGINE INNODB STATUS;`
* `SELECT` from the `performance_schema` and the `sys` system schemas.

To grant a user the `PROCESS` privilege, run the [CLI](../../cli/) command below:

```bash
{{ yc-mdb-my }} user update \
    --global-permissions PROCESS <username> \
    --cluster-id <cluster_ID>
```


#### How do I set up alerts? {#alerts}

Use [{{ monitoring-full-name }}]({{ link-monitoring }}). For the setup guide, see [{#T}](../../monitoring/operations/alert/create-alert.md).

When selecting a metric, set the `service` parameter to **{{ ui-key.yacloud_monitoring.services.label_mysql }}**.


#### How do I set up an alert that is triggered once a certain disk space percentage is used up? {#disk-space-percentage}

[Create an alert](../../managed-mysql/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mmy-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of the disk space
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 80% of the disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96,636,764,160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `85,899,345,920` bytes (80%)
