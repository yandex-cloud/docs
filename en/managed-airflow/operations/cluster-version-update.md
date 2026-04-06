---
title: Updating {{ AF }} and Python versions
description: Follow this guide to upgrade your {{ maf-name }} cluster.
---

# Updating {{ AF }} and Python versions

You can find the list of supported versions in the [Versioning](../concepts/versions.md) section.

{% include [version-update-rules](../../_includes/managed-airflow/version-update-rules.md) %}

To learn about updates within the same version and host maintenance, see [Maintenance](../concepts/maintenance.md).

{% note alert %}

Before the upgrade, make sure it will not affect your applications: review the [release notes](https://airflow.apache.org/docs/apache-airflow/stable/release_notes.html) for {{ AF }} and [Python](https://www.python.org/downloads/).

Once your {{ AF }} version is upgraded, you cannot revert the cluster to the previous version.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    To upgrade your {{ AF }} or Python version:

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}** service.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the {{ AF }} and Python version you need.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To upgrade your {{ AF }} or Python version:

    1. Get the list of your {{ maf-name }} clusters:

        ```bash
        {{ yc-mdb-af }} cluster list
        ```

    1. Get information about the cluster you need and check the version in the `config.airflow_version` and `config.python_version` properties:

        ```bash
        {{ yc-mdb-af }} cluster get <cluster_name_or_ID>
        ```

    1. To upgrade your {{ AF }} version, run this command:

        ```bash
        {{ yc-mdb-af }} cluster update <cluster_name_or_ID> \
          --airflow-version=<new_version_number>
        ```

    1. To upgrade your Python version, run this command:

        ```bash
        {{ yc-mdb-af }} cluster update <cluster_name_or_ID> \
          --python-version=<new_version_number>
        ```

- {{ TF }} {#tf}

    To upgrade your {{ AF }} or Python version:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more on how to create this file, see [Creating a cluster](cluster-create.md).

    1. Add the `airflow_version` or `python_version` parameter to the cluster description or update it if it is already there:

        ```hcl
        resource "yandex_airflow_cluster" "<cluster_name>" {
          ...
          airflow_version = "<Apache_Airflow™_version>"
          python_version  = "<Python_version>"
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-maf }}).

- REST API {#api}

    To upgrade your {{ AF }} or Python version:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method and run the request, e.g., via {{ api-examples.rest.tool }}.

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        * To upgrade your {{ AF }} version, run this request:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "airflowVersion",
                          "airflowVersion": "<Apache_Airflow™_version>"
                        }'
            ```

           Where:

            * `updateMask`: List of parameters to update. Specify only `airflowVersion`.

            * `airflowVersion`: Target {{ AF }} version.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        * To upgrade your Python version, run this request:

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-airflow }}/managed-airflow/v1/clusters/<cluster_ID>' \
                --data '{
                          "updateMask": "pythonVersion",
                          "pythonVersion": "<Python_version>"
                        }'
            ```

            Where:

            * `updateMask`: List of parameters to update. Specify only `pythonVersion`.

            * `pythonVersion`: Target Python version.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To upgrade your {{ AF }} or Python version:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        * To upgrade your {{ AF }} version, run this request:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>",
                      "update_mask": {
                        "paths": [
                          "airflow_version"
                        ]
                      },
                      "airflow_version": "<Apache_Airflow™_version>"
                    }' \
                {{ api-host-airflow }}:{{ port-https }} \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of parameters to update. Specify only `airflow_version`.

            * `airflow_version`: Target {{ AF }} version.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

        * To upgrade your Python version, run this request:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<cluster_ID>",
                      "update_mask": {
                        "paths": [
                          "python_version"
                        ]
                      },
                      "python_version": "<Python_version>"
                    }' \
                {{ api-host-airflow }}:{{ port-https }} \
                yandex.cloud.airflow.v1.ClusterService.Update
            ```

            Where:

            * `update_mask`: List of parameters to update. Specify only `python_version`.

            * `python_version`: Target Python version.

            You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade {{ AF }} from `2.10` to `2.11`, and Python from `3.10` to `3.12`.

{% list tabs group=instructions %}

- CLI {#cli}

    1. To get a list of clusters with their IDs and names, run this command:

        ```bash
        {{ yc-mdb-af }} cluster list
        ```

        ```text
        +----------------------+------------+---------------------+--------+---------+
        |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------------+---------------------+--------+---------+
        | c9qqhh2u3r20******** | airflow411 | 2026-02-26 15:39:33 | ALIVE  | RUNNING |
        +----------------------+------------+---------------------+--------+---------+
        ```

    1. To get information about the `airflow411` cluster, run the following command:

        ```bash
        {{ yc-mdb-af }} cluster get airflow411
        ```

        Result:

        ```text
        id: c9qqhh2u3r20********
        ...
        config:
          ...
          airflow-version: "2.10"
          python-version: "3.10"
        ```

    1. To update {{ AF }} to version `2.11`, run this command:

        ```bash
        {{ yc-mdb-af }} cluster update airflow411 \
          --airflow-version=2.11
        ```

        Wait for the operation to complete.

    1. To update Python to version `3.12`, run this command:

        ```bash
        {{ yc-mdb-af }} cluster update airflow411 \
          --python-version=3.12
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.
    1. In the cluster description, set the `airflow_version` field value to `2.11`.

        ```hcl
        resource "yandex_airflow_cluster" "<cluster_name>" {
          ...
          airflow_version = "2.11"
          ...
        }
        ```

    1. Apply the changes:

        ```bash
        terraform apply
        ```

    1. Set the `python_version` field value to `3.12`:

        ```hcl
        resource "yandex_airflow_cluster" "<cluster_name>" {
          ...
          python_version = "3.12"
          ...
        }
        ```

    1. Apply the changes once again:

        ```bash
        terraform apply
        ```

{% endlist %}

#### See also {#see-also}

* [Versioning in {{ maf-name }}](../concepts/versions.md)
* [{{ AF }} versioning policy](../concepts/update-policy.md)
