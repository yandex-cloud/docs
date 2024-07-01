---
title: "Расширения спецификации {{ api-gw-name }}. Обзор"
description: "Расширение x-yc-apigateway позволяет задать верхнеуровневые параметры API-шлюза, значения которых будут наследоваться вложенными расширениями. Расширение x-yc-apigateway-integration — это точка входа для интеграции API-шлюза с другими сервисами."
---

# Расширения спецификации {{ api-gw-name }}. Обзор

## Расширение x-yc-apigateway {#top-level}

Расширение `x-yc-apigateway` позволяет задать верхнеуровневые параметры API-шлюза, значения которых будут наследоваться вложенными расширениями.

### Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

 Параметр                | Тип               | Описание                                                                                                                                          
-------------------------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------
 `service_account_id`    | `string`          | Идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого API-шлюз будет выполнять операции.     
 `validator`             | `ValidatorObject` | [Валидатор HTTP-запросов и ответов](validator.md#validator_object) или ссылка на него. Может быть переопределен на уровне конкретной операции. 
 `cors`                  | `CorsRuleObject`  | [Правило обработки preflight-запросов CORS](cors.md#corsrule_object) или ссылка на него. Может быть переопределено на уровне конкретного пути. 
 `rateLimit`             | `RateLimitObject` | [Ограничение скорости обработки запросов](rate-limit.md#rate_limit_object) или ссылка на него. Может быть переопределено на уровне конкретного пути и/или операции. 
 `ignoreTrailingSlashes` | `boolean`         | Если установлено значение `true`, {{ api-gw-name }} игнорирует слеш (`/`) в конце URL запроса, иначе — учитывает его наличие или отсутствие при поиске обработчика в OpenAPI-спецификации. Значение по умолчанию — `true`.

### Спецификация расширения {#tl-spec}

```yaml
x-yc-apigateway:
  service_account_id: <идентификатор_сервисного_аккаунта>
  validator: <ValidatorObject_или_ссылка_на_него>
  cors: <CorsRuleObject_или_ссылка_на_него>
  rateLimit: <RateLimitObject_или_ссылка_на_него>
  ignoreTrailingSlashes: <true_или_false>
```

## Расширение x-yc-apigateway-integration {#integration}

Расширение `x-yc-apigateway-integration` — это точка входа для интеграции API-шлюза с другими сервисами. 

### Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`type` | `string` | Тип расширения. Доступные значения: `dummy`, `cloud_functions`, `http`, `object_storage`, `cloud_datasphere`, `cloud_datastreams`, `serverless_containers`, `cloud_ymq` и `cloud_ydb` .

### Спецификация расширения {#intg-spec}

```
<Запрос>:
  <Метод>:
    x-yc-apigateway-integration:
      type: <Тип>
      <Список параметров в виде пары ключ: значение>
```

Содержимое расширения меняется в зависимости от указанного типа (`type`) в блоке `x-yc-apigateway-integration`: 
* [dummy](dummy.md) — возвращает фиксированное содержимое с указанным кодом ответа и необходимыми заголовками без участия стороннего сервиса.
* [cloud_functions](cloud-functions.md) — вызывает указанную функцию, передавая ей на вход информацию об HTTP-запросе, и возвращает клиенту результат выполнения этой функции.
* [http](http.md) — перенаправляет запрос в указанный URL.
* [object_storage](object-storage.md) — передает обработку запроса в {{ objstorage-name }} с целью раздачи статических файлов.
* [cloud_datasphere](datasphere.md) — вызывает указанную ноду {{ ml-platform-name }}, передавая ей тело запроса со значениями входных переменных, и возвращает результат выполнения ноды в теле ответа.
* [cloud_datastreams](datastreams.md) — обращается к {{ yds-full-name }} для выполнения операции с указанным потоком.
* [serverless_containers](containers.md) — перенаправляет запрос в указанный контейнер.
* [cloud_ymq](ymq.md) — обращается к {{ message-queue-full-name }} для выполнения операции с указанной очередью.
* [cloud_ydb](ydb.md) — обращается к {{ ydb-full-name }} для выполнения операции с указанной [документной таблицей](../../../ydb/concepts/dynamodb-tables.md).
 
Все типы поддерживают подстановку параметров — замену всех ключей на соответствующее значение. Ключ должен быть определен как параметр соответствующей операции (допускаются все типы параметров, определенные в [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification) — `path`, `query`, `header`, `cookie`).
Подстановка параметров производится только в некоторых значениях, в зависимости от типа расширения.

## Расширение components:x-yc-apigateway-integrations {#integrations}

Расширение `x-yc-apigateway-integrations` позволяет указывать интеграцию в стандартной секции [components](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.1.0.md#components-object). На определенные таким образом интеграции можно ссылаться с помощью параметра `$ref` в расширении `x-yc-apigateway-integration`.

### Спецификация расширения {#intg-spec}

Пример спецификации расширения:
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

x-yc-apigateway:
  variables:
    handler:
      default: "#/components/x-yc-apigateway-integrations/BaseGetDefault"
      enum:
        - "#/components/x-yc-apigateway-integrations/BaseGetDefault"
        - "#/components/x-yc-apigateway-integrations/BaseGetUnimplemented"

paths:
  /:
    get:
      x-yc-apigateway-integration:
        $ref: "${var.handler}"

components:
  x-yc-apigateway-integrations:
    BaseGetDefault:
      type: cloud_functions
      function_id: b095c95icnvb********
      tag: "$latest"
      service_account_id: ajehfe84hhl********
    BaseGetUnimplemented:
      type: dummy
      content:
        '*': Sorry, endpoint is not implemented yet.
      http_code: 501
      http_headers:
        Content-Type: text/plain
```