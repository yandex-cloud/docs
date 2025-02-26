---
title: Запуск рабочего процесса в {{ sw-full-name }}
description: Запуск рабочего процесса в {{ sw-name }} содержит всю информацию о конкретном выполнении рабочего процесса.
keywords:
  - workflows
  - workflow
  - воркфлоу
  - рабочий процесс
---

# Запуск рабочего процесса

Запуск содержит всю информацию о конкретном выполнении рабочего процесса. Просмотреть список всех запусков, а также детальную информацию о них можно на вкладке **Запуски** в консоли управления. Возможные статусы запуска: `В очереди`, `Выполняется`, `Приостановлен`, `Отменён`, `Ошибка`, `Выполнен`. Подробнее о [возможных кодах ошибок](#errors).

Запустить рабочий процесс можно с помощью [консоли управления](#console), [API](#api) или [{{ er-name }}](#eventrouter).

## Консоль управления {#console}

Запустить рабочий процесс можно:
* нажав ![image](../../../_assets/console-icons/ellipsis.svg) → **Запустить** в строке с рабочим процессом;
* выбрав рабочий процесс и нажав **Запустить** на странице **Обзор**.

## API {#api}

Запустить рабочий процесс можно с помощью метода REST API [start](../../workflows/api-ref/Execution/start.md) для ресурса [Execution](../../workflows/api-ref/Execution/index.md) или вызова gRPC API [ExecutionService/Start](../../workflows/api-ref/grpc/Execution/start.md).

## {{ er-name }} {#eventrouter}

Запустить рабочий процесс можно, указав его в качестве приемника в правиле. Правило определяет события, при которых должен запуститься рабочий процесс. Тело события передается в запуск как входной параметр.

## Возможные коды ошибок {#errors}

Ошибка | Описание
--- | ---
`ALL` | Ошибка, которую можно указать в политике повторных попыток, чтобы политика применялась для любого типа ошибки, кроме `STEP_INTERNAL`.
`STEP_DATA_LIMIT_EXCEEDED` | Превышен лимит входных или выходных данных. Подробнее см. [{#T}](../limits.md).
`STEP_NO_CHOICE_MATCHED` | Нет подходящего пути выполнения в `choices`. Подробнее см. [{#T}](yawl/management/switch.md).
`STEP_PERMISSION_DENIED` | Нет доступа к ресурсу.
`STEP_TIMEOUT` | Превышен таймаут шага. Подробнее см. [{#T}](../limits.md).
`STEP_INVALID_OUTPUT` | Невалидные выходные данные.
`STEP_INTERNAL` | Внутренняя ошибка. Если шаг завершается с такой ошибкой, политику повторных попыток применить нельзя, и запуск сразу переходит в статус `Ошибка`.
`STEP_INVALID_TEMPLATE_EXPRESSION` | Невалидное jq-выражение в шаблоне.
`STEP_FAIL` | Запуск завершился с ошибкой на шаге `Fail`. Подробнее см. [{#T}](yawl/management/fail.md).
`STEP_FAILED_PRECONDITION` | Ресурс находится в недопустимом для выполнения шага состоянии. Например, адрес электронной почты не подтвержден или заблокирован.
`STEP_INVALID_ARGUMENT` | Невалидные параметры шага.
`STEP_QUOTA_EXCEEDED` | Достигнут лимит запросов к ресурсу.
`HTTP_CALL_400`<br/>`HTTP_CALL_401`<br/>`HTTP_CALL_402`<br/>`HTTP_CALL_403`<br/>`HTTP_CALL_404`<br/>`HTTP_CALL_405`<br/>`HTTP_CALL_406`<br/>`HTTP_CALL_407`<br/>`HTTP_CALL_408`<br/>`HTTP_CALL_409`<br/>`HTTP_CALL_410`<br/>`HTTP_CALL_411`<br/>`HTTP_CALL_412`<br/>`HTTP_CALL_413`<br/>`HTTP_CALL_414`<br/>`HTTP_CALL_415`<br/>`HTTP_CALL_416`<br/>`HTTP_CALL_417`<br/>`HTTP_CALL_418`<br/>`HTTP_CALL_419`<br/>`HTTP_CALL_420`<br/>`HTTP_CALL_421`<br/>`HTTP_CALL_422`<br/>`HTTP_CALL_423`<br/>`HTTP_CALL_424`<br/>`HTTP_CALL_425`<br/>`HTTP_CALL_426`<br/>`HTTP_CALL_427`<br/>`HTTP_CALL_428`<br/>`HTTP_CALL_429`<br/>`HTTP_CALL_431`<br/>`HTTP_CALL_449`<br/>`HTTP_CALL_451`<br/>`HTTP_CALL_499`<br/>`HTTP_CALL_500`<br/>`HTTP_CALL_501`<br/>`HTTP_CALL_505`<br/>`HTTP_CALL_502`<br/>`HTTP_CALL_503`<br/>`HTTP_CALL_504`<br/>`HTTP_CALL_506`<br/>`HTTP_CALL_507`<br/>`HTTP_CALL_508`<br/>`HTTP_CALL_509`<br/>`HTTP_CALL_510`<br/>`HTTP_CALL_511`<br/>`HTTP_CALL_520`<br/>`HTTP_CALL_521`<br/>`HTTP_CALL_522`<br/>`HTTP_CALL_523`<br/>`HTTP_CALL_524`<br/>`HTTP_CALL_525`<br/>`HTTP_CALL_526` | Коды состояния ответа HTTP. Подробнее см. в [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses).
`GRPC_CALL_CANCELLED`<br/>`GRPC_CALL_DEADLINE_EXCEEDED`<br/>`GRPC_CALL_UNIMPLEMENTED`<br/>`GRPC_CALL_UNAVAILABLE`<br/>`GRPC_CALL_UNKNOWN`<br/>`GRPC_CALL_INTERNAL`<br/>`GRPC_CALL_RESOURCE_EXHAUSTED`<br/>`GRPC_CALL_UNAUTHENTICATED` | gRPC-статусы. Подробнее см. в [документации gRPC](https://grpc.github.io/grpc/core/md_doc_statuscodes.html).
`GRPC_CALL_INVALID_OPTIONS` | Невалидные параметры gRPC-вызова.
`GRPC_CALL_INVALID_REFLECTION_SERVER_RESPONSE` | Непредвиденный ответ от gRPC-сервера.
`FUNCTION_CALL_INVALID_RESPONSE` | Невалидный код функции или формат возвращаемого JSON-ответа. Подробнее см. [{#T}](../../../functions/concepts/function-invoke.md#http-state).
`CONTAINER_CALL_400`<br/>`CONTAINER_CALL_401`<br/>`CONTAINER_CALL_402`<br/>`CONTAINER_CALL_403`<br/>`CONTAINER_CALL_404`<br/>`CONTAINER_CALL_405`<br/>`CONTAINER_CALL_406`<br/>`CONTAINER_CALL_407`<br/>`CONTAINER_CALL_408`<br/>`CONTAINER_CALL_409`<br/>`CONTAINER_CALL_410`<br/>`CONTAINER_CALL_411`<br/>`CONTAINER_CALL_412`<br/>`CONTAINER_CALL_413`<br/>`CONTAINER_CALL_414`<br/>`CONTAINER_CALL_415`<br/>`CONTAINER_CALL_416`<br/>`CONTAINER_CALL_417`<br/>`CONTAINER_CALL_418`<br/>`CONTAINER_CALL_419`<br/>`CONTAINER_CALL_420`<br/>`CONTAINER_CALL_421`<br/>`CONTAINER_CALL_422`<br/>`CONTAINER_CALL_423`<br/>`CONTAINER_CALL_424`<br/>`CONTAINER_CALL_425`<br/>`CONTAINER_CALL_426`<br/>`CONTAINER_CALL_427`<br/>`CONTAINER_CALL_428`<br/>`CONTAINER_CALL_429`<br/>`CONTAINER_CALL_431`<br/>`CONTAINER_CALL_449`<br/>`CONTAINER_CALL_451`<br/>`CONTAINER_CALL_499`<br/>`CONTAINER_CALL_500`<br/>`CONTAINER_CALL_501`<br/>`CONTAINER_CALL_505`<br/>`CONTAINER_CALL_502`<br/>`CONTAINER_CALL_503`<br/>`CONTAINER_CALL_504`<br/>`CONTAINER_CALL_506`<br/>`CONTAINER_CALL_507`<br/>`CONTAINER_CALL_508`<br/>`CONTAINER_CALL_509`<br/>`CONTAINER_CALL_510`<br/>`CONTAINER_CALL_511`<br/>`CONTAINER_CALL_520`<br/>`CONTAINER_CALL_521`<br/>`CONTAINER_CALL_522`<br/>`CONTAINER_CALL_523`<br/>`CONTAINER_CALL_524`<br/>`CONTAINER_CALL_525`<br/>`CONTAINER_CALL_526` | Коды состояния ответа HTTP. Подробнее см. в [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses).
`YDB_CALL_SERVICE_UNAVAILABLE` | Временный сбой на стороне сервера.
