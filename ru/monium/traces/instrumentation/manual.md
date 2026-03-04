# Ручная инструментация

Ручная инструментация дает полный контроль над тем, какие операции трассируются, какие атрибуты и события записываются. Она позволяет создавать спаны в тех местах кода, которые не покрываются [автоматической инструментацией](auto.md): бизнес-логика, кастомные обработчики, внутренние вызовы. Для ручной инструментации используется [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/).

На практике автоматическая и ручная инструментация дополняют друг друга. Начните с автоматической — она покроет типовые протоколы. Затем добавляйте ручные спаны в местах, где не хватает контекста для диагностики.

Примеры в этом разделе приведены на Python. Для других языков API аналогичен — см. [документацию OpenTelemetry SDK](https://opentelemetry.io/docs/languages/).

## Инициализация трейсера {#init}

Трейсер — объект, через который создаются спаны. Получите его один раз в модуле и используйте во всех функциях:

```python
from opentelemetry import trace

tracer = trace.get_tracer("my_service.orders")
```

Аргумент `get_tracer` — имя модуля или компонента. Для именования можно использовать `__name__` (чтобы легко находить файл с кодом) или фиксированную строку (например, `my_service.orders`), чтобы имя компонента не менялось при рефакторинге и перемещении файлов.

Если вы запускаете приложение через [автоинструментацию](auto.md), `TracerProvider` настраивается автоматически. Если нет — инициализируйте провайдер до вызова `get_tracer`.

## Создание спанов {#creating-spans}

Основной способ создать спан — контекстный менеджер `start_as_current_span`. Название отражает поведение: метод создает спан и делает его _текущим_ в контексте — благодаря этому вложенные спаны автоматически становятся дочерними. При выходе из блока спан завершается:

```python
def handle_order(order_id):
    with tracer.start_as_current_span("handle_order") as span:
        span.set_attribute("order.id", order_id)
        result = process(order_id)
        return result
```

### Вложенные спаны {#nested-spans}

Спаны, созданные внутри другого спана, автоматически становятся дочерними. Это формирует дерево операций в трейсе:

```python
def handle_order(order_id):
    with tracer.start_as_current_span("handle_order"):

        with tracer.start_as_current_span("validate_payment"):
            validate(order_id)

        with tracer.start_as_current_span("update_inventory"):
            update(order_id)
```

В интерфейсе {{ traces-name }} этот код создаст три спана: `handle_order` с двумя дочерними — `validate_payment` и `update_inventory`.

### Именование спанов {#naming}

Используйте короткие, стабильные имена с низкой кардинальностью:

* `checkout.calculate_total` — хорошо.
* `process_order_a3f82c1` — плохо (содержит уникальный идентификатор).

Для сетевых операций следуйте конвенциям OpenTelemetry: `GET /api/orders` для HTTP, `mypackage.MyService/GetOrder` для gRPC.

### Виды спанов {#span-kind}

При создании спана можно указать его вид. Вид определяет роль операции в распределенном взаимодействии:

```python
from opentelemetry.trace import SpanKind

with tracer.start_as_current_span("GET /api/orders", kind=SpanKind.SERVER):
    ...
```

#|
|| Вид | Описание ||
|| `SERVER` | Обработка входящего запроса от другого сервиса ||
|| `CLIENT` | Исходящий запрос к другому сервису ||
|| `INTERNAL` | Внутренняя операция, не связанная с удаленным вызовом (по умолчанию) ||
|| `PRODUCER` | Отправка сообщения в очередь ||
|| `CONSUMER` | Получение сообщения из очереди и его обработка (спан охватывает весь цикл от получения до завершения обработки) ||
|#

## Атрибуты {#attributes}

Атрибуты — пары «ключ — значение», которые добавляют контекст к спану. Они используются для поиска и фильтрации в интерфейсе {{ traces-name }}.

```python
with tracer.start_as_current_span("handle_order") as span:
    span.set_attribute("order.id", order_id)
    span.set_attribute("order.type", "online")
    span.set_attribute("order.items_count", len(items))
```

Для типовых операций используйте атрибуты из [семантических конвенций OpenTelemetry](https://opentelemetry.io/docs/specs/semconv/). Конкретные имена ключей зависят от версии конвенций и настроек инструментации — сверяйтесь с актуальной спецификацией для вашего типа операции ([HTTP](https://opentelemetry.io/docs/specs/semconv/http/http-spans/), [DB](https://opentelemetry.io/docs/specs/semconv/database/), [Messaging](https://opentelemetry.io/docs/specs/semconv/messaging/)).

## События {#events}

События фиксируют важные моменты внутри спана. Каждое событие содержит временную метку, название и (опционально) атрибуты:

```python
with tracer.start_as_current_span("process_batch") as span:
    span.add_event("Batch processing started", {"batch.size": 100})
    process(batch)
    span.add_event("Batch processing completed")
```

Типичные применения: начало или завершение этапа, промах кэша, повторная попытка, результат валидации.

## Статусы и ошибки {#status}

Каждый спан имеет статус. По умолчанию спан создается со статусом `UNSET`, что означает успешное завершение операции без ошибок. Используйте `OK` только тогда, когда хотите явно застраховаться от переопределения статуса автоинструментацией или другим кодом.

Ошибки можно отразить в трейсе двумя способами.

**Исключение пробрасывается наружу.** Контекстный менеджер `start_as_current_span` по умолчанию перехватывает исключение, вышедшее из блока `with`, записывает его как событие, устанавливает статус `ERROR` и пробрасывает дальше. Достаточно не ловить исключение внутри блока:

```python
# Исключение выйдет из with — OTel запишет его в спан, выставит ERROR и пробросит дальше
with tracer.start_as_current_span("charge_payment"):
    if order_id < 0:
        raise ValueError(f"Invalid order ID: {order_id}")
```

**Исключение перехватывается и обрабатывается.** Если вы обрабатываете ошибку внутри блока, исключение не выходит за пределы `with` — автоматическая запись контекстным менеджером не срабатывает. Вызовите `record_exception` и `set_status` вручную.

Важно: `record_exception` и `set_status` — независимые операции. `record_exception` создает событие с типом `exception`, сообщением и стектрейсом, но **не** устанавливает статус `ERROR`. Без явного вызова `set_status` спан не будет помечен как ошибочный. Согласно спецификации OTel, исключение следует записывать как событие только вместе с установкой статуса `ERROR` — именно такой паттерн отражает реальную ошибку в трейсе.

```python
from opentelemetry.trace import Status, StatusCode

with tracer.start_as_current_span("handle_order") as span:
    try:
        result = process(order_id)
        return result
    except Exception as e:
        # Событие: тип, сообщение, стектрейс
        span.record_exception(e)
         # Помечает спан как ошибочный
        span.set_status(Status(StatusCode.ERROR, str(e)))
```

Спаны со статусом `ERROR` выделяются в интерфейсе {{ traces-name }}.

## Propagation контекста {#context}

Контекст трассировки (`trace_id`, `span_id`) передается между сервисами через заголовки запросов в формате [W3C Trace Context](https://www.w3.org/TR/trace-context/). Это позволяет объединить спаны из разных сервисов в один трейс.

Внутри одного процесса контекст передается автоматически: каждый новый спан, созданный через `start_as_current_span`, наследует текущий контекст и становится дочерним.

При межсервисном взаимодействии контекст нужно передавать явно. Если вы используете автоинструментацию для HTTP или gRPC, это происходит автоматически. Для других протоколов внедрите контекст вручную:

```python
from opentelemetry.propagate import inject, extract

headers = {}
inject(headers)
# headers теперь содержит traceparent и tracestate —
# передайте их вместе с запросом

# На принимающей стороне:
ctx = extract(incoming_headers)
with tracer.start_as_current_span("process", context=ctx):
    ...
```

## Полный пример {#full-example}

Консольная программа с ручной инструментацией. Демонстрирует все основные приемы: инициализацию провайдера, создание вложенных спанов, атрибуты, событие и обработку ошибки.

```python
from opentelemetry import trace
from opentelemetry.trace import Status, StatusCode, SpanKind
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.resources import Resource
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# Инициализация провайдера.
# Параметры подключения берутся из переменных окружения OTEL_*.
resource = Resource.create()
provider = TracerProvider(resource=resource)
provider.add_span_processor(BatchSpanProcessor(OTLPSpanExporter()))
trace.set_tracer_provider(provider)

tracer = trace.get_tracer("my_service.orders")


def validate_order(order_id: int) -> None:
    """
    Исключение пробрасывается наружу из блока with.
    Контекстный менеджер перехватит его, запишет в спан и выставит ERROR автоматически.
    """
    with tracer.start_as_current_span("validate_order") as span:
        span.set_attribute("order.id", order_id)

        if order_id <= 0:
            raise ValueError(f"Invalid order ID: {order_id}")

        span.add_event("Validation passed")


def charge_payment(order_id: int, amount: float) -> bool:
    """
    Исключение перехватывается внутри блока with.
    Автоматическая запись не срабатывает — вызываем record_exception и set_status явно.
    """
    with tracer.start_as_current_span("charge_payment") as span:
        span.set_attribute("order.id", order_id)
        span.set_attribute("payment.amount", amount)

        try:
            if amount <= 0:
                raise ValueError(f"Invalid payment amount: {amount}")
            span.add_event("Payment charged")
            return True
        except Exception as e:
            # record_exception записывает событие с типом, сообщением и стектрейсом.
            # set_status — отдельный вызов: без него спан не будет помечен как ошибочный.
            span.record_exception(e)
            span.set_status(Status(StatusCode.ERROR, str(e)))
            return False


def update_inventory(order_id: int) -> None:
    with tracer.start_as_current_span("update_inventory") as span:
        span.set_attribute("order.id", order_id)
        span.add_event("Inventory updated")


def process_order(order_id: int, amount: float) -> None:
    # SpanKind.SERVER — точка входа, обрабатывающая входящий запрос.
    # Дочерние спаны создаются внутри и наследуют контекст автоматически.
    with tracer.start_as_current_span("process_order", kind=SpanKind.SERVER) as span:
        span.set_attribute("order.id", order_id)
        span.set_attribute("order.amount", amount)
        span.add_event("Order processing started")

        try:
            validate_order(order_id)
        except ValueError as e:
            span.set_status(Status(StatusCode.ERROR, str(e)))
            print(f"Order {order_id} failed: {e}")
            return

        if not charge_payment(order_id, amount):
            span.set_status(Status(StatusCode.ERROR, "Payment failed"))
            print(f"Order {order_id} failed: payment rejected")
            return

        update_inventory(order_id)
        span.add_event("Order processing completed")
        print(f"Order {order_id} processed successfully")

if __name__ == "__main__":
    process_order(1, 50.0)   # успешный сценарий
    process_order(-1, 50.0)  # ошибка валидации
    process_order(2, -1.0)   # ошибка оплаты

    # Дожидаемся отправки всех буферизованных спанов перед завершением процесса
    provider.shutdown()
```

Для запуска установите зависимости и задайте переменные окружения из раздела [Настройка подключения](../index.md#connection-setup):

```bash
pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-otlp
```

```bash
export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
```

```bash
export OTEL_SERVICE_NAME=my-service
```

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <API-ключ>,x-monium-project=folder__<идентификатор_каталога>"
```

```bash
python app.py
```
