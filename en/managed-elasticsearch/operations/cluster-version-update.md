# Updating the {{ ES }} version and edition

In the {{ mes-name }} cluster, you can [update the version](#version-update) and [update the edition](#start-edition-update) of {{ ES }}.

## Updating the {{ ES }} version {#version-update}

You can update a {{ mes-name }} cluster to a later [{{ ES }} version](../concepts/update-policy.md#versioning-policy).

### Viewing a list of available {{ ES }} versions {#version-list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **Edit**.
   1. Open the list in the **Version** field.

{% endlist %}

### Before updating the version {#before-version-update}

Before updating the {{ ES }} version, make sure this doesn't affect your apps:

* View the [past release notes](https://www.elastic.co/downloads/past-releases#elasticsearch) for {{ ES }} to find out how the update might affect your applications.
* Try updating the version on a test cluster. You can deploy a test cluster from a backup of the main cluster.
* [Create a backup](cluster-backups.md#create-backup) of the main cluster before updating the version.

### Updating the {{ ES }} version {#start-version-update}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
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

   1. Run the version update:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster name of ID> --version <{{ ES }} version>
      ```

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new {{ ES }} version in the `configSpec.version` parameter.
   * List of cluster configuration fields to be changed (in this case, `configSpec.version`), in the `updateMask` parameter.

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

   {% endnote %}

{% endlist %}

## Updating the {{ ES }} edition {#start-edition-update}

You can update the [{{ ES }} edition](../concepts/es-editions.md) run in the cluster. If you decide to downgrade the edition, please double-check that reduced functionality won't affect your applications.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}) go to the folder page and select **{{ mes-name }}**.
   1. Select a cluster and click **Edit**.
   1. In the **Edition** field, select{{ ES }} `Basic`, `Gold`, or `Platinum`.
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

   1. Run the edition update:

      ```bash
      {{ yc-mdb-es }} cluster update <cluster name or ID> \
         --edition <{{ ES }} edition: basic, gold, or platinum>
      ```

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about creating this file, see [{#T}](cluster-create.md).

   1. Add the `config.edition` field to the {{ mes-name }} cluster description or edit it (if it exists):

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
        ...
        config {
          edition = "<{{ ES }} edition: basic, gold, or platinum>"
          ...
        }
        ...
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_elasticsearch_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
   * The new {{ ES }} edition, in the `configSpec.edition` parameter.
   * The list of cluster configuration fields to be edited (in this case, `configSpec.edition`) in the `updateMask` parameter.

   {% note warning %}

   This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

   {% endnote %}

{% endlist %}
