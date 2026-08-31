---
title: Удаление окружения для кластера {{ SPRK }}
description: Вы можете удалить окружение кластера {{ SPRK }}, если оно вам больше не потребуется.
---

# Удаление окружения

Вы можете удалить окружение, если оно вам больше не потребуется.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить окружение.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Нажмите![image](../../_assets/console-icons/ellipsis.svg) для нужного окружения и выберите **{{ ui-key.yacloud.spark.EnvironmentActions.button_action-delete_kqb63 }}**.
  1. В открывшемся окне подтвердите удаление и нажмите **{{ ui-key.yacloud.spark.EnvironmentActions.popup-action_label_delete-msg_4d5Cr }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [EnvironmentService/Delete](../environment/api-ref/grpc/Environment/delete.md), чтобы удалить окружение:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "environment_id": "<идентификатор_окружения>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Delete
       ```

       Идентификатор окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../environment/api-ref/grpc/Environment/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
