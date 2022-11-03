---
title: Расширения спецификации {{ api-gw-name }}. Обзор
description: "Расширение x-yc-apigateway позволяет задать верхнеуровневые параметры API-шлюза, значения которых будут наследоваться вложенными расширениями. Расширение x-yc-apigateway-integration — это точка входа для интеграции API-шлюза с другими сервисами."
---

# Обзор

## Расширение x-yc-apigateway {#top-level}

Расширение `x-yc-apigateway` позволяет задать верхнеуровневые параметры API-шлюза, значения которых будут наследоваться вложенными расширениями.

### Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`service_account_id` | `string` | Идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого API-шлюз будет выполнять операции.

### Спецификация расширения {#tl-spec}

```yaml
x-yc-apigateway:
  service_account_id: <ID сервисного аккаунта>
```

## Расширение x-yc-apigateway-integration {#integration}

Расширение `x-yc-apigateway-integration` — это точка входа для интеграции API-шлюза с другими сервисами. 

### Поддерживаемые параметры {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Параметр | Тип | Описание 
----|----|----
`type` | `string` | Тип расширения. Доступные значения: `dummy`, `cloud_functions`, `http`, `object_storage`, `cloud_datasphere`, `cloud_datastreams` и `serverless_containers`.

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
