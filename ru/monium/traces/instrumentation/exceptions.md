# Обработка ошибок

Когда в операции возникает исключение, спан должен зафиксировать два факта: статус `ERROR` и событие `exception` с деталями ошибки. Спаны со статусом `ERROR` выделяются в интерфейсе {{ traces-name }} и доступны для фильтрации.

Базовый паттерн обработки ошибок описан в разделе [{#T}](manual.md#status). Эта страница описывает атрибуты события `exception` согласно [спецификации OpenTelemetry](https://opentelemetry.io/docs/specs/semconv/exceptions/exceptions-spans/).

## Атрибуты события exception {#attributes}

Например, в Python при вызове `record_exception` создается событие с именем `exception` и следующими атрибутами:

#|
|| Атрибут | Описание ||
|| `exception.type` | Тип исключения: `OSError`, `ValueError`, `java.lang.RuntimeException` ||
|| `exception.message` | Текст ошибки: `Can't convert 'int' object to str implicitly` ||
|| `exception.stacktrace` | Стектрейс исключения ||
|#

Полный перечень атрибутов см. в [спецификации OpenTelemetry для exception-событий](https://opentelemetry.io/docs/specs/semconv/exceptions/exceptions-spans/).

## Пример {#example}

Операция `parse_message` завершается с ошибкой:

#|
|| Атрибут | Значение ||
|| Name | `parse_message` ||
|| Kind | `INTERNAL` ||
|| Status | `ERROR` ||
|| `exception.type` | `ValueError` ||
|| `exception.message` | `Can't convert 'int' object to str implicitly` ||
|| `exception.stacktrace` | `Traceback (most recent call last): ...` ||
|#
