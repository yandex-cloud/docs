---
title: Интеграция с {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API
description: Вы научитесь взаимодействовать с {{ cloud-apps-full-name }} Workload API для интеграции вашего приложения с {{ marketplace-full-name }}.
---

# Как начать работать с {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API

В данном разделе приведены примеры использования {{ marketplace-short-name }} {{ cloud-apps-name }} Workload [REST API](../../../workload/api-ref/) и [gRPC API](../../../workload/api-ref/grpc/) для получения информации о приложении {{ cloud-apps-name }}, а также о привязке приложения и виртуальной машины, на которой оно запущено, к сервису [{{ cloud-apps-full-name }}](../../../../cloud-apps/index.yaml).

Все приведенные запросы вы также можете выполнять с помощью SDK для [Node.js](https://github.com/yandex-cloud/nodejs-sdk), [Python](https://github.com/yandex-cloud/python-sdk), [Go](https://github.com/yandex-cloud/go-sdk), [Java](https://github.com/yandex-cloud/java-sdk) или [C#](https://github.com/yandex-cloud/dotnet-sdk).

## Перед началом работы {#before-begin}

Чтобы начать работать c {{ marketplace-short-name }} {{ cloud-apps-name }} Workload API:

1. [Получите](../../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) IAM-токен для [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), автоматически созданного во время установки приложения и привязанного к [виртуальной машине](../../../../compute/concepts/vm.md), на которой оно зупущено.
1. [Получите](../../../../compute/concepts/vm-metadata.md#identity-document) идентификатор виртуальной машины, на которой запущено приложение.

Чтобы воспользоваться примерами, установите утилиты:
* [cURL](https://curl.haxx.se) при использовании [REST API](../../../workload/api-ref/).
* [gRPCurl](https://github.com/fullstorydev/grpcurl) при использовании [gRPC API](../../../workload/api-ref/grpc/).

## Получите информацию о приложении {{ cloud-apps-full-name }} {#get-app-info}

Чтобы получить информацию о приложении {{ cloud-apps-name }}, используйте сервисный аккаунт, автоматически созданный во время установки приложения и привязанный к виртуальной машине, на которой оно запущено. Выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request GET \
    --header "Authorization: Bearer <IAM-токен>" \ 
    https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications
  ```

  Где `<IAM-токен>` — [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [ранее](#before-begin).

  Результат:

  ```json
  {
    "id": "d7fsg12ho5h6********",
    "status": "DEPLOYED",
    "billing": {
      "type": "PAY_AS_YOU_GO"
    }
  }
  ```

  В запросе используется метод REST API [get](../../../workload/api-ref/CloudApplication/get.md) для ресурса [CloudApplication](../../../workload/api-ref/CloudApplication/index.md).

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -H "Authorization: Bearer <IAM-токен>" \
    cloudapps.{{ api-host }}:443 yandex.cloud.cloudapps.workload.v1.CloudApplicationService/Get
  ```

  Где `<IAM-токен>` — [IAM-токен](../../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [ранее](#before-begin).

  Результат:

  ```json
  {
    "id": "d7fsg12ho5h6********",
    "status": "DEPLOYED",
    "billing": {
      "type": "PAY_AS_YOU_GO"
    }
  }
  ```

  В запросе используется вызов gRPC API [CloudApplicationService/Get](../../../workload/api-ref/grpc/CloudApplication/get.md).

{% endlist %}

Данный ответ означает, что сервисный аккаунт был автоматически создан во время установки приложения {{ cloud-apps-name }} с идентификатором `d7fsg12ho5h6********`. Текущий статус приложения — `DEPLOYED`, а текущий тип [тарифа](../../../concepts/tariff.md) — `PAY_AS_YOU_GO`.

## Убедитесь, что приложение запущено сервисом {{ cloud-apps-name }} {#ensure-cloud-app}

Чтобы убедиться, что приложение запущено сервисом {{ cloud-apps-name }}, проверьте, что ВМ привязана к приложению. Для этого используйте сервисный аккаунт, который был автоматически создан во время установки приложения и привязан к ВМ, на которой оно запущено. Выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer <IAM-токен>" \ 
    --data '{"workload_type": "COMPUTE_INSTANCE", "workload_id": "<идентификатор_ВМ>"}' \
    https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications:resolve-by-workload
  ```

  Где:
  
  * `<IAM-токен>` — IAM-токен сервисного аккаунта, полученный [ранее](#before-begin).
  * `<идентификатор_ВМ>` — идентификатор виртуальной машины, полученный [ранее](#before-begin).

  Результат:

  {% cut "ВМ привязана к приложению {{ cloud-apps-name }}" %}

  ```json
  {
    "cloudApplication": {
      "id": "d7fsg12ho5h6********",
      "status": "DEPLOYED",
      "billing": {
        "type": "PAY_AS_YOU_GO"
      }
    }
  }
  ```

  Данный ответ означает, что виртуальная машина и сервисный аккаунт, привязанный к ней, были автоматически созданы во время установки приложения {{ cloud-apps-name }} с идентификатором `d7fsg12ho5h6********`. Текущий статус приложения — `DEPLOYED`, а текущий тип [тарифа](../../../concepts/tariff.md) — `PAY_AS_YOU_GO`.

  {% endcut %}

  {% cut "ВМ не привязана к приложению {{ cloud-apps-name }}" %}

  ```json
  {
   "code": 5,
   "message": "Workload not found",
   "details": [
    {
     "@type": "type.googleapis.com/google.rpc.RequestInfo",
     "requestId": "5899fc83-b123-47b8-94c3-1ad1********"
    }
   ]
  }
  ```

  Если запрос возвращает такую ошибку, это означает, что виртуальная машина была создана пользователем вручную. При этом стоимость программного продукта по тарифу на зачисляется на счет пользователя, а приложение может ограничить свою работу на данной ВМ.

  {% endcut %}


  В запросе используется метод REST API [resolveByWorkload](../../../workload/api-ref/CloudApplication/resolveByWorkload.md) для ресурса [CloudApplication](../../../workload/api-ref/CloudApplication/index.md).

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{"workload_type": "COMPUTE_INSTANCE", "workload_id": "<идентификатор_ВМ>"}' \
    cloudapps.{{ api-host }}:443 yandex.cloud.cloudapps.workload.v1.CloudApplicationService/ResolveByWorkload
  ```

  Где:
  
  * `<IAM-токен>` — IAM-токен сервисного аккаунта, полученный [ранее](#before-begin).
  * `<идентификатор_ВМ>` — идентификатор виртуальной машины, полученный [ранее](#before-begin).

  Результат:

  {% cut "ВМ привязана к приложению {{ cloud-apps-name }}" %}

  ```json
  {
    "cloudApplication": {
      "id": "d7fsg12ho5h6********",
      "status": "DEPLOYED",
      "billing": {
        "type": "PAY_AS_YOU_GO"
      }
    }
  }
  ```

  Данный ответ означает, что виртуальная машина и сервисный аккаунт, привязанный к ней, были автоматически созданы во время установки приложения {{ cloud-apps-name }} с идентификатором `d7fsg12ho5h6********`. Текущий статус приложения — `DEPLOYED`, а текущий тип [тарифа](../../../concepts/tariff.md) — `PAY_AS_YOU_GO`.

  {% endcut %}

  {% cut "ВМ не привязана к приложению {{ cloud-apps-name }}" %}

  ```json
  ERROR:
    Code: NotFound
    Message: Workload not found
    Details:
    1)    {
            "@type": "type.googleapis.com/google.rpc.RequestInfo",
            "requestId": "5899fc83-b123-47b8-94c3-1ad1********"
          }
  ```

  Если запрос возвращает такую ошибку, это означает, что виртуальная машина была создана пользователем вручную. При этом стоимость программного продукта по тарифу на зачисляется на счет пользователя, а приложение может ограничить свою работу на данной ВМ.

  {% endcut %}

  В запросе используется вызов gRPC API [CloudApplicationService/ResolveByWorkload](../../../workload/api-ref/grpc/CloudApplication/resolveByWorkload.md).

{% endlist %}