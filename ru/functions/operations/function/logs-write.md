---
title: Запись логов в журнал выполнения в {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование функции.
---

# Записать логи в журнал выполнения функции

{% include [logging-note](../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, для которой хотите настроить логирование.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.logging.label_title }}**:
        
        1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
        1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:
          
           * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать [логи](../../concepts/logs.md) в [лог-группу](../../../logging/concepts/log-group.md) по умолчанию для каталога, в котором находится функция.
           * {% include [log-group](../../../_includes/functions/log-group.md) %}

        1. (Опционально) Выберите минимальный уровень логирования.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**. 
    
    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    ### Назначение логирования {#destination}

    {% include [logging-destination](../../../_includes/functions/logging-destination.md) %}

    Чтобы записывать логи в лог-группу по умолчанию для другого каталога, укажите идентификатор этого каталога в параметре `--log-folder-id` при [создании версии функции](version-manage.md). [Аккаунту](../../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../../logging/security/index.md#logging-editor) `logging.editor` или выше.

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в параметре `--log-group-id` при создании версии функции. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.


    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `--min-log-level` при создании версии функции. 
    
    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании версии функции укажите параметр `--no-logging`.

    ### Пример команды {#example}
    
    Чтобы записывать логи в пользовательскую лог-группу, выполните команду:
        
    ```
    {{ yc-serverless }} function version create \
      --function-id <идентификатор_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --memory <объем_RAM> \
      --source-path <ZIP-архив_c_кодом_функции> \
      --log-group-id <идентификатор_лог-группы> \
      --min-log-level <минимальный_уровень_логирования>
    ```

    Где:
    * `--function-id` — идентификатор функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.
    * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.
    * `--min-log-level` — минимальный уровень логирования. Необязательный параметр.

    Результат:
    ```
    done (4s)
    id: d4ech7qdki6r********
    function_id: d4e7tbg7m4np********
    created_at: "2024-04-19T10:13:00.019Z"
    runtime: python37
    entrypoint: index.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "53248"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      log_group_id: e23u2vn449av********
      min_level: DEBUG
    ```

- {{ TF }} {#tf}
    
    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    ### Назначение логирования {#destination}

    {% include [logging-destination](../../../_includes/functions/logging-destination.md) %}

    Чтобы записывать логи в лог-группу по умолчанию для другого каталога, укажите идентификатор этого каталога в блоке `log_options` в параметре `folder_id` при [создании версии функции](version-manage.md). [Аккаунту](../../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../../logging/security/index.md#logging-editor) `logging.editor` или выше.

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в блоке `log_options` в параметре `log_group_id` при создании версии функции. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.

    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в блоке `log_options`  в параметре `min_level` при создании версии функции.

    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании версии функции в блоке `log_options` укажите параметр `disabled` со значением `true`.

    ### Пример {#example}

    Чтобы записывать логи в пользовательскую лог-группу:

    1. Откройте файл конфигурации {{ TF }} и добавьте к описанию ресурса `yandex_function` блок `log_options`:

        Примеры структуры конфигурационного файла:

        ```hcl
        resource "yandex_function" "my-function" {
          name       = "<имя_функции>"
          user_hash  = "<хeш_версии_функции>"
          runtime    = "<среда_выполнения>"
          entrypoint = "<точка_входа>"
          memory     = "<объем_RAM>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
          log_options {
            log_group_id = "<идентификатор_лог-группы>"
            min_level    = "<минимальный_уровень_логирования>"
          }
        }
        ```

        Где:
        * `name` — имя функции.
        * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
        * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
        * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
        * `content` — исходный код функции:
            * `zip_filename` — путь к ZIP-архиву, содержащему исходный код функции и необходимые зависимости.
        * `log_options` — настройки логирования:
            * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.
            * `min_level` — минимальный уровень логирования. Необязательный параметр.

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

    1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Чтобы записывать логи в журнал выполнения функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/LogOptions](../../functions/api-ref/grpc/Function/createVersion.md#yandex.cloud.serverless.functions.v1.LogOptions).

{% endlist %}

## Структурированные логи {#structured-logs}

Кроме текстовых записей, в стандартный поток вывода (`stdout`) и стандартный поток вывода ошибок (`stderr`) можно писать [структурированные логи](../../concepts/logs.md#structured-logs).

### Примеры функций

{% list tabs group=programming_language %}

- Node.js {#node}

    **package.json**
    ```json
    {
      "name": "server-app",
      "version": "1.0.0",
      "dependencies": {
        "winston": "^3.8.2"
      }
    }
    ```

    **index.js**
    ```js
    const winston = require('winston');

    const logger = winston.createLogger({
        level: 'debug',
        format: winston.format.json(),
        transports: [new winston.transports.Console()],
    });

    module.exports.handler = async function (event, context) {
        logger.info({"message": "My log message", "my-key": "my-value"})
        return {
            statusCode: 200,
            body: 'Hello World!',
        };
    };
    ```

- Python {#python}

    **requirements.txt**
    ```
    python-json-logger==2.0.4

    ```

    **index.py**
    ```python
    import logging
    from pythonjsonlogger import jsonlogger


    class YcLoggingFormatter(jsonlogger.JsonFormatter):
        def add_fields(self, log_record, record, message_dict):
            super(YcLoggingFormatter, self).add_fields(log_record, record, message_dict)
            log_record['logger'] = record.name
            log_record['level'] = str.replace(str.replace(record.levelname, "WARNING", "WARN"), "CRITICAL", "FATAL")

    logHandler = logging.StreamHandler()
    logHandler.setFormatter(YcLoggingFormatter('%(message)s %(level)s %(logger)s'))

    logger = logging.getLogger('MyLogger')
    logger.propagate = False
    logger.addHandler(logHandler)
    logger.setLevel(logging.DEBUG)

    def handler(event, context):
        logger.info("My log message", extra={"my-key": "my-value"})
        
        return "Hello, world!"
    ```
- Go {#go}

    **index.go**
    ```go
    package main

    import (
        "context"
        "go.uber.org/zap"
    )

    type Response struct {
        StatusCode int         `json:"statusCode"`
        Body       interface{} `json:"body"`
    }

    func Handler(ctx context.Context) (*Response, error) {
        config := zap.NewProductionConfig()
        config.DisableCaller = true
        config.Level.SetLevel(zap.DebugLevel)
        logger, _ := config.Build()
        defer logger.Sync()

        logger.Info(
            "My log message",
            zap.String("my-key", "my-value"),
        )

        return &Response{
            StatusCode: 200,
            Body:       "Hello, world!",
        }, nil
    }
    ```

- Java {#java}

    **pom.xml**
    ```xml
    ...
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-api</artifactId>
        <version>2.19.0</version>
    </dependency>
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-core</artifactId>
        <version>2.19.0</version>
    </dependency>
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-layout-template-json</artifactId>
        <version>2.19.0</version>
    </dependency>
    ...
    ```

    **log4j2.xml**
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <Configuration>
        <Appenders>
            <Console name="Console" target="SYSTEM_OUT">
                <JsonTemplateLayout eventTemplateUri="classpath:YcLoggingLayout.json"/>
            </Console>
        </Appenders>
        <Loggers>
            <Root level="TRACE">
                <AppenderRef ref="Console"/>
            </Root>
        </Loggers>
    </Configuration>
    ```

    **YcLoggingLayout.json**
    ```json
    {
      "message": {
        "$resolver": "message",
        "stringified": true
      },
      "level": {
        "$resolver": "level",
        "field": "name"
      },
      "logger": {
        "$resolver": "logger",
        "field": "name"
      },
      "labels": {
        "$resolver": "mdc",
        "flatten": true,
        "stringified": true
      },
      "tags": {
        "$resolver": "ndc"
      }
    }
    ```

    **Handler.java**
    ```java
    import org.apache.logging.log4j.LogManager;
    import org.apache.logging.log4j.Logger;
    import org.apache.logging.log4j.ThreadContext;

    import java.util.function.Function;

    public class Handler implements Function<String, String> {

        private static final Logger logger = LogManager.getLogger();

        @Override
        public String apply(String s) {
            ThreadContext.put("my-key", "my-value");
            logger.info("My log message");
            ThreadContext.clearAll();
            return "Hello, world!";
        }
    }
    ```
- Rust {#rust}

    **Cargo.toml**
    ```
    [dependencies]
    tracing = "0.1.*"
    tracing-subscriber = { version = "0.3.*", features = ["std", "env-filter", "time", "json"] }
    ```

    **main.rs**
    ```rust
    use tracing_subscriber::{
        fmt,
        layer::SubscriberExt,
        util::SubscriberInitExt,
        EnvFilter,
    };
    use tracing_subscriber::fmt::time::UtcTime;
    
    pub fn init_tracing() {
        let env_filter = EnvFilter::try_from_default_env()
            .unwrap_or_else(|_| EnvFilter::new("info"));
    
        let fmt_layer = fmt::layer()
            .json()
            .flatten_event(true)
            .with_timer(UtcTime::rfc_3339())
            .with_ansi(false)
            .with_target(false)
            .with_thread_ids(false)
            .with_thread_names(false)
            .with_writer(std::io::stderr)
            .with_filter(env_filter);
    
        tracing_subscriber::registry()
            .with(fmt_layer)
            .init();
    }
    
    fn main() {
        init_tracing();
    
        tracing::info!(my_key = "my-value", "My log message");
        tracing::error!(error_code = 42, "Something went wrong");
    }
    ```

{% endlist %}
