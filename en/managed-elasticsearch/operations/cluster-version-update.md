---
title: How to update {{ ES }} versions and editions
description: Follow this guide to update {{ ES }} versions and editions.
---

# Updating the {{ ES }} version and edition

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

In the {{ mes-name }} cluster, you can [update the version](#version-update) and [update the edition](#start-edition-update) of {{ ES }}.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

## {{ ES }} version upgrade {#version-update}

You can update a {{ mes-name }} cluster to a newer [{{ ES }} version](../concepts/update-policy.md#versioning-policy).

### Viewing a list of available {{ ES }} versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Open the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

### Before a version upgrade {#before-version-update}

Make sure this does not affect your applications:

1. See {{ ES }} [changelog](https://www.elastic.co/downloads/past-releases#elasticsearch) for how upgrades may affect your applications.
1. Try a version upgrade on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.

### Updating the {{ ES }} version {#start-version-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the appropriate {{ ES }} version.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get a list of your {{ ES }} clusters:

        ```bash
        {{ yc-mdb-es }} cluster list
        ```

    1. Get information about the cluster you need and check the version in the `config.version` property:

        ```bash
        {{ yc-mdb-es }} cluster get <cluster_name_or_ID>
        ```

    1. Update the version:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> --version <{{ ES }}_version>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

       For more information about creating this file, see [Creating clusters](cluster-create.md).

       For a complete list of available {{ mes-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mes }}).

    1. To the {{ mes-name }} cluster description, add the `config.version` field or change its value if it is already there:

       ```hcl
       resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
         ...
         config {
           version = "<{{ ES }}_version>"
         }
       }
       ```

    1. Make sure the settings are correct.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    To update a version, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * New {{ ES }} version in the `configSpec.version` parameter.
    * List of editable cluster configuration fields in the `updateMask` parameter (in this case, `configSpec.version`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Updating the {{ ES }} edition {#start-edition-update}

{% note info %}

As of June 13, 2022, the `Gold` [edition](../concepts/es-editions.md) has been discontinued in {{ mes-name }} clusters. You cannot switch to it from the `Basic` or `Platinum` edition. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum`.

{% endnote %}

You can change the [{{ ES }} edition](../concepts/es-editions.md) used by the cluster. Before you downgrade the edition, make sure that reduced functionality will not affect your applications.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.elasticsearch.base_field_edition }}** field, select the {{ ES }} edition you need: `Basic` or `Platinum`.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get a list of your {{ ES }} clusters:

        ```bash
        {{ yc-mdb-es }} cluster list
        ```

    1. Get information about the cluster you need and check the edition in the `config.edition` property:

        ```bash
        {{ yc-mdb-es }} cluster get <cluster_name_or_ID>
        ```

    1. Update the edition:

        ```bash
        {{ yc-mdb-es }} cluster update <cluster_name_or_ID> \
           --edition <{{ ES }}_edition>
        ```

        Where `--edition` is the {{ ES }} edition, `basic` or `platinum`.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Add the `config.edition` field to the {{ mes-name }} cluster description or edit it if the field already exists:

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<cluster_name>" {
          ...
          config {
            edition = "<{{ ES }}_edition>"
            ...
          }
          ...
        }
        ```

        Where `edition` is the {{ ES }} edition, `basic` or `platinum`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_elasticsearch_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    To update the {{ ES }} edition, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
      
    * New {{ ES }} edition in the `configSpec.edition` parameter.
    * List of editable cluster configuration fields in the `updateMask` parameter (in this case, `configSpec.edition`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
