---
title: Изменение окружения для кластера {{ SPRK }}
description: Из статьи вы узнаете, как изменить параметры окружения для кластера {{ SPRK }}.
---

# Изменения окружения

После создания окружения вы можете изменить общую информацию о нем: имя, описание и метки. Если вы хотите изменить список пакетов или версию {{ SPRK }}, [создайте новое окружение на основе существующего](environment-create.md#create-copy-env) и внесите необходимые изменения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.spark.label_title-environments }}**.
  1. Выберите в списке необходимое окружение, перейдите в него и нажмите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.spark.EnvironmentForm.EnvironmentFormContent.section_general_fDK9S }}** измените имя, описание окружения и метки. 
  1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [EnvironmentService/Update](../environment/api-ref/grpc/Environment/update.md), чтобы изменить окружение:

       ```bash
       grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/environment/environment_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                "environment_id": "<идентификатор_окружения>",
                "update_mask": {
                  "paths": [
                    "name",
                    "description"
                  ]
                },
                "name": "<новое_имя_окружения>",
                "description": "<новое_описание_окружения>"
            }' \
         {{ api-host-spark }}:{{ port-https }} \
         yandex.cloud.spark.v1.environment.EnvironmentService.Update
       ```

       Идентификатор окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md).

       В параметре `update_mask` перечислите параметры, которые нужно изменить. Передайте новые значения этих параметров в соответствующих полях.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../environment/api-ref/grpc/Environment/update.md#yandex.cloud.operation.Operation).

{% endlist %}
