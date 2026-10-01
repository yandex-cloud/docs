---
title: How to change {{ SPRK }} version in a {{ msp-full-name }} cluster
description: Follow this guide to change {{ SPRK }} version in a {{ msp-full-name }} cluster.
---

# {{ SPRK }} version update

You can change the {{ SPRK }} version to any of the versions [supported](#available-versions) by {{ msp-name }}.

Updates and fixes within a version are installed automatically during maintenance.

## Get a list of available versions {#available-versions}

{% note info %}

If you use environments to manage versions, the version is indicated in the base environment name.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel. This will open the cluster editing page.
      
    You can see the list of available versions in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before a version upgrade {#before-update}

Make sure the upgrade will not disrupt your applications:

1. Check the {{ SPRK }} [release notes](https://spark.apache.org/news/) to learn how upgrades may affect your applications.
1. Try upgrading the {{ SPRK }} version on a test cluster.

## Upgrading the version {#update}

{{ SPRK }} version upgrade method depends on how dependencies are configured in your cluster:

* If the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-packages_wJq6n }}** value is selected in the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** field, [change the version in the cluster settings](#update-with-packages).

  {% note warning %}
  
  This method is deprecated and will soon become unavailable. We recommend using environments to work with different {{ SPRK }} versions.
  
  {% endnote %}
  
* If the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-environment_wJq6n }}** value is selected in the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** field, select the base environment ({{ SPRK }} and Python version) or [connect a custom environment with your required version to the cluster](#update-with-environment). The {{ SPRK }} version is fixed within the environment and cannot be set separately in the cluster settings.

### Cluster uses manually added packages {#update-with-packages}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, go to the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** → **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-packages_wJq6n }}** and select an {{ SPRK }} version.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the {{ SPRK }} version:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-sp }} cluster update --help
        ```

    1. Change the version by running this command:

        ```bash
        {{ yc-mdb-sp }} cluster update <cluster_name_or_ID> \
          --spark-version <Apache_Spark_version>
        ```

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ SPRK }} configuration file with the infrastructure plan.

        Learn how to create this file in [Creating a cluster](cluster-create.md).
        
    1. Edit the `spark_version` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_spark_cluster" "<cluster_name>" {
          ...
          config = {
            ...
            spark_version = "<Apache_Spark_version>"
            ...
          }
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "config_spec.spark_version"
            ]
          },
          "config_spec": {
            "spark_version": "<Apache_Spark_version>"
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

            {% cut "Format for listing settings" %}

            ```yaml
            "update_mask": {
              "paths": [
                "<setting_1>",
                "<setting_2>",
                ...
                "<setting_N>"
              ]
            }
            ```

            {% endcut %}

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

            {% endnote %}

        * `spark_version`: {{ SPRK }} version.

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.ClusterService.Update \
          < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

### Cluster uses an environment {#update-with-environment}

Your cluster can use either the base or a custom environment. 

The base environment contains only the {{ SPRK }} version and Python version. You can select it when [creating](cluster-create.md) or [updating](cluster-update.md#change-additional-settings) your cluster.

A custom environment contains the base environment and a list of required pip and deb packages enabling you to install additional libraries and applications in the cluster. You need to specify the list of packages manually. You cannot modify the list of packages and {{ SPRK }} version in an existing custom environment. To update the {{ SPRK }} version, set up a custom environment with the version you need and connect it to the cluster.

{% list tabs group=instructions %}

- Management console {#console}

    1. Set up an environment with the {{ SPRK }} you need using one of these methods:

        * [Create a new environment](environment-create.md#create-env).
        * [Create a new environment based on an existing one](environment-create.md#create-copy-env).

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, in the **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_dependencies-type_wJq6n }}** → **{{ ui-key.yacloud.spark.ClusterForm.DependenciesSection.title_software-configuration-type-environment_wJq6n }}** field, select the environment you set up.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- gRPC API {#grpc-api}

    1. [Set up an environment](environment-create.md#create-env) with the {{ SPRK }} version you need.

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "config_spec.environment_id"
            ]
          },
          "config_spec": {
            "environment_id": "<environment_ID>"
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `environment_id`: ID of the environment with the {{ SPRK }} version you need. Call the [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md) method to get the custom environment ID or [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md) to get the base environment ID.

    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.ClusterService.Update \
          < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
