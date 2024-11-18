---
title: How to change a {{ CH }} cluster version in {{ mch-full-name }}
description: Follow this guide to change a {{ CH }} cluster version.
---

# {{ CH }} version upgrade

You can update the {{ CH }} version used by the cluster to any of the [supported {{ mch-name }} versions](../concepts/update-policy.md#versioning-policy); however, switching from versions lower than 23.8 to 23.8 or higher is performed in steps. For example, for {{ mch-name }}, the upgrade sequence from version 22.8 to 24.3 is: 22.8 → 23.3 → 23.8 → 24.3.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

## List of available versions

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), open the {{ mos-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of available versions, run the following command:

    ```bash
    yc managed-clickhouse version list
    ```

- API {#api}

    To view the list of available versions, use the [list](../api-ref/Versions/list.md) REST API method for the [Versions](../api-ref/Versions/index.md) resource or the [VersionsService/List](../api-ref/grpc/Versions/list.md) gRPC API call.

{% endlist %}

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See the {{ CH }} [changelog](https://clickhouse.com/docs/category/changelog) to check how updates might affect your applications.
1. Try upgrading the version on a test cluster. You can deploy it from a backup of the main cluster. In this case, you will only recover MergeTree tables.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.

## Updating the version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), open the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}** page in the folder where you want to update the {{ CH }} version.
    1. In the list of clusters, select the one to change.
    1. Click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select the appropriate version in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    When the change starts, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get a list of your {{ CH }} clusters and view their versions:

        ```bash
        {{ yc-mdb-ch }} cluster list

        +----------------------+------+-------------+---------+---------------------+--------+---------+
        |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        ```

    1. Update the {{ CH }} version for any cluster as needed:

        ```bash
        {{ yc-mdb-ch }} cluster update --id <cluster_ID> --version <{{ CH }}_version>
        ```

        Specify the {{ CH }} version: {{ versions.cli.str }}.

    When the update starts, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To the {{ mch-name }} cluster description, add the `version` field or change its value if it is already there:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          version = "<{{ CH }}_version>"
        }
        ```

        Specify the {{ CH }} version: {{ versions.tf.str }}.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API {#api}

    To update a version, use the [update](../api-ref/Cluster/update.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) gRPC API call and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
    * {{ CH }} version in the `configSpec.version` parameter: {{ versions.api.str }}.
    * List of settings to update (in this case, `configSpec.version`) in the `updateMask` parameter.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
