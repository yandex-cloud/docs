# Устранение ошибки Permission denied при создании новых ресурсов

## Описание проблемы {#description}

При попытке создания или изменения ресурсов {{ sf-name }}, {{ serverless-containers-name }} или {{ api-gw-name }} в консоли управления отображается ошибка `403 Permission denied` или `Authentication problem: permission denied`.

{% cut "Примеры ошибок" %}
```
url: https://console.yandex.cloud/folders/b1gXXXXXXXXXXXXXXXXX/functions/create-trigger; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: 75eb3f30-1633-40db-9037-a84e9ad983f7; Trace ID: 484838913dde4f28;
```

```
url: https://console.yandex.cloud/folders/b1gXXXXXXXXXXXXXXXXX/serverless-containers/containers/bbapakmadpt4h1tq4ilm/editor; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: 4dca5fb7-e1d2-4c1d-8e1a-b6ac50e94add; Trace ID: a412e0dd69680510;
```

```
url: https://console.yandex.cloud/folders/b1gXXXXXXXXXXXXXXXXX/api-gateway/create; 
message: Permission denied; status: 403; 
description: Permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: cd51f2c8-27f3-4286-8103-b0da7d94a44f; Trace ID: 8a71598e50cd73e3;
```
{% endcut %}

## Решение {#solution}

Ошибка `403 Permission denied` возникает, так как у **IAM-аккаунта**, который используется для операции, нет необходимых прав для взаимодействия с другими ресурсами.

Чтобы исправить это, назначьте сервисному аккаунту недостающие роли, например:
* Для вызова функции — роль `functions.functionInvoker`.
* Для записи в бакет {{ objstorage-short-name }} — роль `storage.uploader`.

Полный список необходимых ролей зависит от настроек ресурса.

Как назначить роль, описано в [инструкции](../../../iam/operations/sa/assign-role-for-sa.md).

Если у вас нет прав на управление ролями, обратитесь к администратору вашего облака.
