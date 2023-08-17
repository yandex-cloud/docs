# Updating the {{ ES }} version and edition

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

In the {{ mes-name }} cluster, you can [update the version](#version-update) and [update the edition](#start-edition-update) of {{ ES }}.

To learn more about updates within one version and host maintenance, see [{#T}](../concepts/maintenance.md).

## Updating the {{ ES }} version {#version-update}

You can update a {{ mes-name }} cluster to a later [{{ ES }} version](../concepts/update-policy.md#versioning-policy).

### Viewing a list of available {{ ES }} versions {#version-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **Edit**.
   1. Open the list in the **Version** field.

{% endlist %}

### Before updating the version {#before-version-update}

Make sure this does not affect your applications:

1. See the {{ ES }} [changelog](https://www.elastic.co/downloads/past-releases#elasticsearch) to check how updates might affect your applications.
1. Try updating the version on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster before updating the version.

### Updating the {{ ES }} version {#start-version-update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **Edit**.
   1. In the **Version** field, select the version {{ ES }}.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ ES }} clusters:

      ```bash
      {{ yc-mdb-es }} cluster list
      ```

   1. Get information about a cluster and check the version in the `config.version` parameter:

      ```bash
      {{ yc-mdb-es }} cluster get <cluster name or ID>
      ```

   1. Update the version:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster name of ID> --version <{{ ES }} version>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

      For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

   1. To the {{ mes-name }} cluster description, add the `config.version` field or change its value if it already exists:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          version = "<{{ ES }} version"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   To update a version, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * The new {{ ES }} version in the `configSpec.version` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `configSpec.version`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating the {{ ES }} edition {#start-edition-update}

{% note info %}

As of June 13, 2022, the `Gold` [edition](../concepts/es-editions.md) in {{ mes-name }} clusters is no longer supported. You cannot switch to it from the `Basic` or `Platinum` editions. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum`.

{% endnote %}

You can update the [{{ ES }} edition](../concepts/es-editions.md) run in the cluster. If you decide to downgrade the edition, please double-check that reduced functionality won't affect your applications.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **Edit**.
   1. In the **Edition** field, select the required {{ ES }} edition: `Basic` or `Platinum`.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get a list of your {{ ES }} clusters:

      ```bash
      {{ yc-mdb-es }} cluster list
      ```

   1. Get information about the cluster and check the edition in the `config.edition` property:

      ```bash
      {{ yc-mdb-es }} cluster get <cluster name or ID>
      ```

   1. Update the edition:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster name or ID> \
         --edition <{{ ES }} edition: basic or platinum>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add the `config.edition` field to the {{ mes-name }} cluster description or edit it (if it exists):

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          edition = "<{{ ES }} edition: basic or platinum>"
          ...
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_elasticsearch_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   To update the {{ ES }} edition, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

   * The new {{ ES }} edition, in the `configSpec.edition` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (in this case, `configSpec.edition`).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
