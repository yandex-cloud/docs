---
title: Updating an environment for a {{ SPRK }} cluster
description: In this article, you will learn how to update environment parameters for an {{ SPRK }} cluster.
---

# Updating an environment

After creating an environment, you can update its general information: name, description, and labels. If you want to change the list of packages or your {{ SPRK }} version, [create a new environment based on the existing one](environment-create.md#create-copy-env) and make the necessary changes.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Select the required environment from the list, navigate to it, and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
  1. Under **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_general_fDK9S }}**, update the environment name, description, and labels. 
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [EnvironmentService/Update](../environment/api-ref/grpc/Environment/update.md) call to update the environment:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "environment_id": "<environment_ID>",
                "update_mask": {
                  "paths": [
                    "name",
                    "description"
                  ]
                },
                "name": "<new_environment_name>",
                "description": "<new_environment_description>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Update
       ```

       To get your environment ID, call the [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md) method.

       In `update_mask`, list the parameters to update. Provide new values in relevant fields.

    1. Check the [server response](../environment/api-ref/grpc/Environment/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
