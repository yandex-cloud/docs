# Записать логи в журнал выполнения функции

Кроме текстовых записей, в стандартный поток вывода (`stdout`) и стандартный поток вывода ошибок (`stderr`) можно писать [структурированные логи](../../concepts/logs.md#structured-logs).

## Примеры функций

{% list tabs %}

- Node.js

    **package.json**
    ```
    {
      "name": "server-app",
      "version": "1.0.0",
      "dependencies": {
        "winston": "^3.8.2"
      }
    }
    ```

    **index.js**
    ```
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

- Python

    **requirements.txt**
    ```
    python-json-logger==2.0.4

    ```

    **index.py**
    ```
    import logging
    from pythonjsonlogger import jsonlogger


    class YcLoggingFormatter(jsonlogger.JsonFormatter):
        def add_fields(self, log_record, record, message_dict):
            super(YcLoggingFormatter, self).add_fields(log_record, record, message_dict)
            log_record['logger'] = record.name
            log_record['level'] = str.replace(str.replace(record.levelname, "WARNING", "WARN"), "CRITICAL", "FATAL")


    def handler(event, context):
        logHandler = logging.StreamHandler()
        logHandler.setFormatter(YcLoggingFormatter('%(message)s %(level)s %(logger)s'))

        logger = logging.getLogger('MyLogger')
        logger.propagate = False
        logger.addHandler(logHandler)
        logger.setLevel(logging.DEBUG)

        logger.info("My log message", extra={"my-key": "my-value"})
        
        return "Hello, world!"
    ```
- Go

    **index.go**
    ```
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

- Java

    **pom.xml**
    ```
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
    ```
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
    ```
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
    ```
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

{% endlist %}