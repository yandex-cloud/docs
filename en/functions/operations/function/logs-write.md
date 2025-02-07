---
title: Writing to the execution log in {{ sf-full-name }}
description: Follow this guide to configure function logging.
---

# Writing to the function execution log

{% include [logging-note](../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing the function.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Select the function you want to configure logging for.
    1. Go to the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** tab.
    1. Under **{{ ui-key.yacloud.logging.label_title }}**, select the following in the **{{ ui-key.yacloud.logging.label_destination }}** field:
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}`: To disable logging.
        * `{{ ui-key.yacloud.common.folder }}`: To write [logs](../../concepts/logs.md) to the default [log group](../../../logging/concepts/log-group.md) for the folder the function is in.
            1. (Optional) In the **{{ ui-key.yacloud.logging.label_minlevel }}** field, select the minimum logging level.
        * `{{ ui-key.yacloud.logging.label_loggroup }}`: To write logs to a custom log group.
            1. (Optional) In the **{{ ui-key.yacloud.logging.label_minlevel }}** field, select the minimum logging level.
            1. In the **{{ ui-key.yacloud.logging.label_loggroup }}** field, select the log group to write the logs to. If you do not have a log group, [create](../../../logging/operations/create-group.md) one.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
    
    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    ### Logging destination {#destination}

    {% include [logging-destination](../../../_includes/functions/logging-destination.md) %}

    To write logs to a custom log group, provide the log group ID in the `--log-group-id` parameter when [creating a function version](version-manage.md). The log group must reside in the same folder as the function.

    ### Minimum logging level {#log-level}

    To set a minimum logging level, provide it in the `--min-log-level` parameter when creating a function version.
    
    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

    ### Disabling logging {#disabled}

    To disable logging, set the `--no-logging` parameter when creating a function version.

    ### Command example {#example}
    
    To write logs to a custom log group, run this command:
        
    ```
    {{ yc-serverless }} function version create \
      --function-id <function_ID> \
      --runtime <runtime_environment> \
      --entrypoint <entry_point> \
      --memory <RAM_size> \
      --source-path <ZIP_archive_with_function_code> \
      --log-group-id <log_group_ID> \
      --min-log-level <minimum_logging_level>
    ```

    Where:
    * `--function-id`: Function ID.
    * `--runtime`: Runtime environment.
    * `--entrypoint`: Entry point in the following format: `<file_name_without_extension>.<listener_name>`.
    * `--memory`: Amount of RAM.
    * `--source-path`: ZIP archive with the function code and required dependencies.
    * `--log-group-id`: ID of the log group to write logs to.
    * `--min-log-level`: Minimum logging level. This is an optional parameter.

    Result:
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

    ### Logging destination {#destination}

    {% include [logging-destination](../../../_includes/functions/logging-destination.md) %}

    To write logs to a custom log group, provide the log group ID in the `log_group_id` parameter under `log_options` when [creating a function version](version-manage.md). The log group must reside in the same folder as the function.

    ### Minimum logging level {#log-level}

    To set a minimum logging level, provide it in the `log_group_id` parameter when creating a function version.

    {% include [min-log-level](../../../_includes/functions/min-log-level.md) %}

    ### Disabling logging {#disabled}

    To disable logging, set the `disabled` parameter to `true` under `log_options` when creating a function version.

    ### Example {#example}

    To write logs to a custom log group:

    1. Open the {{ TF }} configuration file and add the `log_options` section to the `yandex_function` resource description:

        Here are some examples of the configuration file structure:

        ```hcl
        resource "yandex_function" "<function_name>" {
          name       = "<function_name>"
          user_hash  = "<any_string>"
          runtime    = "<runtime_environment>"
          entrypoint = "<entry_point>"
          memory     = "<RAM_size>"
          content {
            zip_filename = "<ZIP_archive_name>"
          }
          log_options {
            log_group_id = "<log_group_ID>"
            min_level = "<minimum_logging_level>"
          }
        }
        ```

        Where:
        * `name`: Function name.
        * `user_hash`: Any string to identify the function version.
        * `runtime`: Function [runtime environment](../../concepts/runtime/index.md).
        * `entrypoint`: Function name in the source code that will serve as an entry point to applications.
        * `memory`: Amount of memory allocated for the function, in MB.
        * `content`: Function source code.
          * `zip_filename`: Name of the ZIP archive containing the function source code.
        * `log_group_id`: ID of the log group to write logs to.
        * `min_level`: Minimum logging level. This is an optional parameter.

        For more information about the `yandex_function` resource parameters, see the [relevant provider documentation]({{ tf-provider-resources-link }}/function).

    1. Check the configuration using this command:
        
        ```
        terraform validate
        ```

        If the configuration is correct, you will get this message:
          
        ```
        Success! The configuration is valid.
        ```

    1. Run this command:

        ```
        terraform plan
        ```
          
        The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
         
    1. Apply the configuration changes:

        ```
        terraform apply
        ```
    
    1. Confirm the changes: type `yes` into the terminal and press **Enter**.

- API {#api}

    To write to the function execution log, use the [createVersion](../../functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/api-ref/Function/index.md) resource or the [FunctionService/LogOptions](../../functions/api-ref/grpc/Function/createVersion.md#yandex.cloud.serverless.functions.v1.LogOptions) gRPC API call.

{% endlist %}

## Structured logs {#structured-logs}

Apart from text, you can write [structured logs](../../concepts/logs.md#structured-logs) to the standard output stream (`stdout`) and standard error output stream (`stderr`).

### Function examples

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

{% endlist %}
