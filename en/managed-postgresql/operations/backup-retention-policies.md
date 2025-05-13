# Managing backup policies in {{ mpg-name }}

[Backup](../concepts/backup.md) policies allow you to flexibly manage the creation and storage of cluster backups. You can configure a schedule to create full backups and specify their retention period.

## Creating a backup policy {#create-policy}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to create a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create --help
      ```

  1. Create a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create \
         --cluster-id <cluster_ID> \
         --policy-name <policy_name> \
         --day-of-month <day_of_month> \
         --month <month> \
         --day-of-week <day_of_week> \
         --retain-for-days <backup_retention_period_in_days> \
         --description <policy_description>
      ```

      Where:

      * `day-of-month`: Day of month. The possible value is `1–31`.
      * `month`: Month. The possible values are `1–12` or `JAN–DEC`.
      * `day-of-week`: Day of week. The possible values are `0–6` or `SUN–SAT`.
      * `retain-for-days`: Backup retention period in days. The minimum value is `7`.

        The `day-of-month`, `month`, and `day-of-week` parameters are used to schedule backups. The schedule is set as a cron expression, but hours and minutes are not specified.
        
        The cron expression also supports special characters:

        * `*`: Selecting all possible values. A backup will be taken on every possible opportunity (every day or month) provided there is no conflict with other parameters. This option is used by default if the parameter value is not specified.
        * `,`: Listing multiple values.
        * `–`: Specifying a range of values.
        * `/`: Specifying a range interval. For example, `*/3` for the `day-of-month` parameter means that a backup will be created every three days.

        If none of the schedule parameters is set, backups are taken based on the `* * *` cron expression, i.e., every day.

        Examples of cron expressions:

        * `1 */6 *`: Backup is created on the first day of month every six month.
        * `31 jan SUN`: Backup is created in January on Sundays and on January 31.
        * `* * WED`: Backup is created every Wednesday.

        You can try creating a cron expression in the [editor](https://crontab.guru).

      You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

      Result:

      ```text
      policy_id: mdbt553glp51********
      cluster_id: c9q5le6h1a4k********
      policy_name: test-policy
      created_at: "2025-03-25T15:55:50.393000450Z"
      cron:
        day_of_month: "25"
        month: mar
        day_of_week: TUE
      retain_for_days: "300"
      ```

{% endlist %}

## Getting a list of backup policies {#list-policies}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get a list of policies:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list --help
      ```

  1. Get a list of policies for a {{ mpg-name }} cluster:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

      Result:

      ```text
      +----------------------+-------------+--------------------+------------+-------------------+
      |          ID          |     NAME    |     CLUSTER ID     |  CRONTAB   |  RETENTION PERIOD |
      +----------------------+-------------+--------------------+------------+-------------------+
      | mdbt553glp51******** | test-policy | c9q5le6h1a4******* | 31 JAN SUN |                50 |
      +----------------------+-------------+--------------------+------------+-------------------+
      ```

      Order of parameters in the `CRONTAB` column: `day_of_month`, `month`, `day_of_week`.

{% endlist %}

## Deleting a backup policy {#delete-policy}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to delete a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete --help
      ```

  1. Delete a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete <policy_ID> \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

{% endlist %}
