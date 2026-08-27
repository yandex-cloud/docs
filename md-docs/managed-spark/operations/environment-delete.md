[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Пошаговые инструкции](index.md) > Окружения > Удаление окружения

# Удаление окружения

Вы можете удалить окружение, если оно вам больше не потребуется.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого нужно удалить окружение.
  1. [Перейдите](https://console.yandex.cloud/link/managed-spark) в сервис **Managed Service for Apache Spark**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3.svg) **Окружения**.
  1. Нажмите![image](../../_assets/console-icons/ellipsis.svg) для нужного окружения и выберите **Удалить**.
  1. В открывшемся окне подтвердите удаление и нажмите **Удалить**.

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
         spark.api.cloud.yandex.net:443 \
         yandex.cloud.spark.v1.environment.EnvironmentService.Delete
       ```

       Идентификатор окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../environment/api-ref/grpc/Environment/delete.md#yandex.cloud.operation.Operation).

{% endlist %}