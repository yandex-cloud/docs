# Автоматическая инструментация

При автоматической инструментации библиотеки и агенты OpenTelemetry перехватывают вызовы стандартных фреймворков и протоколов и самостоятельно создают спаны. Вы получаете трассировку без написания дополнительного кода — достаточно подключить агент или библиотеку и указать параметры экспорта.

## Принцип работы {#how-it-works}

Автоинструментация встраивается между вашим приложением и используемыми библиотеками. В зависимости от языка это работает по-разному:

* **Java** — Java-агент модифицирует байткод при загрузке классов.
* **Python, Node.js** — инструменты подменяют вызовы стандартных модулей на обертки, создающие спаны.

Во всех случаях каждый перехваченный вызов автоматически создает спан с атрибутами по [семантическим конвенциям OpenTelemetry](https://opentelemetry.io/docs/specs/semconv/) — HTTP-метод, URL, статус ответа, имя таблицы БД и т. д.

## Что покрывается автоматически {#coverage}

Автоинструментация создает спаны для типовых операций:

* HTTP-серверы и клиенты (Flask, Django, Express, Spring, `requests`, `net/http` и др.)
* Клиенты баз данных (PostgreSQL, MySQL, Redis, MongoDB)
* Очереди сообщений (Kafka, RabbitMQ)

Полный список поддерживаемых библиотек для каждого языка см. в [реестре инструментации OpenTelemetry](https://opentelemetry.io/ecosystem/registry/?language=python&component=instrumentation).

## Общие параметры подключения {#common-config}

Независимо от языка, для отправки трейсов в {{ traces-name }} укажите параметры подключения через переменные окружения:

```bash
export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
```

```bash
export OTEL_SERVICE_NAME=<имя_приложения>
```

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <API-ключ>,x-monium-project=folder__<идентификатор_каталога>"
```

```bash
export OTEL_RESOURCE_ATTRIBUTES="cluster=<окружение>"
```

Где:

* `OTEL_SERVICE_NAME` — имя вашего приложения. Используется как значение `service.name` в атрибутах ресурса.
* `OTEL_EXPORTER_OTLP_ENDPOINT` — эндпоинт {{ monium-name }}.
* `OTEL_EXPORTER_OTLP_HEADERS` — заголовки авторизации и привязки к проекту. Для получения API-ключа [создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `monium.traces.writer` и [API-ключ](../../../iam/operations/authentication/manage-api-keys.md) с областью действия `yc.monium.traces.write`.
* `OTEL_RESOURCE_ATTRIBUTES` — атрибуты ресурса. `cluster` задает окружение (по умолчанию `default`).

## Подключение по языкам {#languages}

### Python {#python}

1. Установите дистрибутив OpenTelemetry и экспортер:

   ```bash
   pip install opentelemetry-distro opentelemetry-exporter-otlp
   ```

1. Установите инструментацию для библиотек, которые использует ваше приложение:

   ```bash
   opentelemetry-bootstrap -a install
   ```

   Команда автоматически определит установленные библиотеки (Flask, Django, requests, psycopg2 и др.) и установит соответствующие пакеты инструментации.

1. Запустите приложение через обертку `opentelemetry-instrument`:

   ```bash
   opentelemetry-instrument python my_app.py
   ```

### Java {#java}

1. Скачайте [Java-агент OpenTelemetry](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases):

   ```bash
   curl -L -o opentelemetry-javaagent.jar \
     https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
   ```

1. Запустите приложение с агентом:

   ```bash
   java -javaagent:opentelemetry-javaagent.jar -jar my_app.jar
   ```

   Агент автоматически инструментирует Spring, Servlet, JAX-RS, JDBC, Kafka, gRPC и другие библиотеки.

### Node.js {#nodejs}

1. Установите пакет автоинструментации:

   ```bash
   npm install @opentelemetry/auto-instrumentations-node
   ```

1. Запустите приложение с автоматической регистрацией:

   ```bash
   node --require @opentelemetry/auto-instrumentations-node/register app.js
   ```

## Ограничения {#limitations}

Автоинструментация покрывает только операции, для которых существуют готовые библиотеки. Она не создает спаны для:

* внутренней бизнес-логики приложения;
* кастомных компонентов и протоколов;
* операций, где нужно добавить специфические атрибуты.

Для трассировки таких операций используйте [ручную инструментацию](manual.md).
