[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Пошаговые инструкции](index.md) > Окружения > Изменение окружения

# Изменения окружения

После создания окружения вы можете изменить общую информацию о нем: имя, описание и метки. Если вы хотите изменить список пакетов или версию Apache Spark™, [создайте новое окружение на основе существующего](environment-create.md#create-copy-env) и внесите необходимые изменения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/managed-spark) в сервис **Managed Service for Apache Spark**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **Окружения**.
  1. Выберите в списке необходимое окружение, перейдите в него и нажмите **Редактировать** на панели сверху.
  1. В блоке **Общая информация** измените имя, описание окружения и метки. 
  1. Нажмите **Сохранить изменения**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       ```bash
       export IAM_TOKEN="<IAM-токен>"
       ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

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
         spark.api.cloud.yandex.net:443 \
         yandex.cloud.spark.v1.environment.EnvironmentService.Update
       ```

       Идентификатор окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md).

       В параметре `update_mask` перечислите параметры, которые нужно изменить. Передайте новые значения этих параметров в соответствующих полях.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../environment/api-ref/grpc/Environment/update.md#yandex.cloud.operation.Operation).

{% endlist %}