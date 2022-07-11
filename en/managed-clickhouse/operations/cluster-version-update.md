# Switching {{ CH }} versions

You can change the {{ CH }} version used by the cluster to any of the [supported {{ mch-name }} versions](../concepts/update-policy.md#versioning-policy), but you can't switch:

* From versions 22.0 and higher to a version lower than 22.0.
* To a version lower than {{ mch-ck-version }} if the cluster was created with {{ CK }} support.

To learn more about updates within one version and host maintenance, see [{#T}](../concepts/maintenance.md).

## List of available versions

{% list tabs %}

- Management console

   You can view a list of available versions on the create and edit cluster screen in the [management console]({{ link-console-main }}):

   ![ch-versions](../../_assets/mdb/clickhouse-version.png)

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of available versions, run the command:

   ```bash
   yc managed-clickhouse version list
   ```

- API

   You can view a list of available versions using the [list](../api-ref/Versions/list.md) API method.

{% endlist %}

## Before switching versions {#before-update}

Before changing the {{ CH }} version, make sure this doesn't affect your apps:

1. See the {{ CH }} [changelog]({{ ch.docs }}/whats-new/changelog/) to check which updates might affect your applications.
1. Try changing versions on a test cluster (you can try deploying it from a backup of the main cluster). Please note that when you deploy a cluster from a backup, only MergeTree engine tables are recovered.
1. [Make a backup](cluster-backups.md#create-backup) of the main cluster before changing the version.

## Switching versions {#start-update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), open the **{{ mch-name }}** page in the folder where you want to change the {{ CH }} version.
   1. In the list of clusters, select the one to change.
   1. Click **Edit cluster**.
   1. In the **Version** field, select the version.
   1. Click **Save changes**.

   When the change starts, the cluster status switches to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ CH }} clusters:

      ```bash
      {{ yc-mdb-ch }} cluster list

      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh | clickhouse691 | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Get information about a cluster and check the {{ CH }} version in your cluster in the `config.version` parameter:

      ```bash
      {{ yc-mdb-ch }} cluster get c9q8p8j2gaih8iti42mh
      id: c9q8p8j2gaih8iti42mh
      folder_id: b1gqs1teo2q2a4vnmi2t
      created_at: "2019-04-23T12:44:17.929853Z"
      name: clickhouse691
      environment: PRODUCTION
      monitoring:
      - name: Console
          description: Console charts
          link: {{ link-console-main }}/folders/b1gqs1teo2q2a4vnmi2t/managed-clickhouse/cluster/c9q8p8j2gaih8iti42mh?section=monitoring
      config:
          version: "19.1"
          ...
      ```

   1. Execute the version change {{ CH }}:

      ```bash
      {{ yc-mdb-ch }} cluster update --id c9q8p8j2gaih8iti42mh --version 19.4
      ```

   When the change starts, the cluster status switches to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- Terraform

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. To the {{ mch-name }} cluster description, add the `version` field or change its value if it's already there:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        version = "<ClickHouse version>"
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

- API

   Use the API [update](../api-ref/Cluster/update.md) method and pass the required value in the `configSpec.clickhouse.config.version` request parameter.

{% endlist %}
