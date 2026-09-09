---
title: Creating an environment for an {{ SPRK }} cluster
description: In this article, you will learn how to create an environment for an {{ SPRK }} cluster.
keywords:
  - creating an environment for an {{ SPRK }} cluster
  - environment for an {{ SPRK }} cluster
---

# Creating a workspace

You can [create an environment from scratch](#create-env) or [create a new environment based on an existing one](#create-copy-env) and edit the parameters.

## Creating a {#create-env} workspace 

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Click **{{ ui-key.yacloud.spark.Spark.EnvironmentsList.button_create_sqDYH }}**.
  1. Under **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_general_fDK9S }}**:
     
     1. Specify a name for the environment.
     1. Optionally, enter a description for the environment.
     1. Optionally, create [labels](../../resource-manager/concepts/labels.md):

        1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
        1. Add a label in `key: value` format.
        1. Press **Enter**.

  1. Under **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_base-environment_tkR1g }}**, select a base environment from the list.
  1. Under **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_packages_oct8m }}**:

     * **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.field_pip-packages_rnW6Y }}**: pip package names separated by spaces to install additional libraries and applications into the environment.
     * **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.field_deb-packages_htNFj }}**: deb package names separated by spaces to install additional libraries and applications into the environment.

     You can set version restrictions for the installed packages, e.g.:

     ```text
     py4j>=0.10.9.7 pandas>=1.05 grpcio>=1.48,<1.57 grpcio-status>=1.48,<1.57 googleapis-common-protos==1.56.4
     ```

     The package name format and version are defined by the install command: `pip install` for pip packages and `apt install` for deb packages.

     {% note warning %}
   
     You cannot change the package list after the environment has been created. If you want to change the list of packages, [create a new environment based on an existing one](#create-copy-env) and make the changes.
   
     {% endnote %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Get a list of base environments by calling [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md):

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "folder_id": "<folder_ID>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.ListBase
       ```

       You can get the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. Use the [EnvironmentService/Create](../environment/api-ref/grpc/Environment/create.md) call to create your environment:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "base_id": "<base_environment_ID>",
                "folder_id": "<folder_ID>",
                "name": "<environment_name>",
                "description": "<environment_description>",
                "labels": {
                  "<label_key>": "<label_value>"
                },
                "config": {
                  "pip_packages": [
                    "<pip_package_1>",
                    "<pip_package_2>"
                  ],
                  "deb_packages": [
                    "<deb_package_1>",
                    "<deb_package_2>"
                  ]
                }
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Create
       ```

       Where:

       * `base_id`: Base environment ID you got in the previous step.
       * `folder_id`: Folder ID.
       * `name`: Environment name.
       * `description`: Environment description.
       * `labels`: Environment labels.
       * `config`: Parameters of packages you need to install into the environment:

          * `pip_packages`: List of pip packages.
          * `deb_packages`: List of deb packages.

          You can set version restrictions for the installed packages, e.g.:

          ```json
          "pip_packages": [
            "pandas==2.1.1",
            "scikit-learn>=1.0.0",
            "clickhouse-driver~=0.2.0"
          ]
          ```

          The package name format and version are defined by the install commands: `pip install` for pip packages and `apt install` for deb packages.

    1. Check the [server response](../environment/api-ref/grpc/Environment/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Creating a new environment based on an existing one {#create-copy-env}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Select the required environment from the list, navigate to it and click ![image](../../_assets/console-icons/copy-plus.svg) **{{ ui-key.yacloud.spark.EnvironmentActions.button_action-copy_dFws4 }}** on the top panel.
  1. Add or change the environment parameters.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
