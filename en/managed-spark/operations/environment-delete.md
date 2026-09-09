---
title: Deleting an environment for an {{ SPRK }} cluster
description: You can delete an {{ SPRK }} cluster environment if you no longer need it.
---

# Deleting an environment

You can delete an environment if you no longer need it.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to delete an environment.
  1. [Navigate]({{ link-console-main }}/link/managed-spark) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the environment and select **{{ ui-key.yacloud.spark.EnvironmentActions.button_action-delete_kqb63 }}**.
  1. In the window that opens, confirm the deletion and click **{{ ui-key.yacloud.spark.EnvironmentActions.popup-action_label_delete-msg_4d5Cr }}**.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [EnvironmentService/Delete](../environment/api-ref/grpc/Environment/delete.md) method to delete the environment:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "environment_id": "<environment_ID>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Delete
       ```

       To get your environment ID, call the [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md) method.

    1. Check the [server response](../environment/api-ref/grpc/Environment/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
