---
title: Writing to the execution log in {{ serverless-containers-full-name }}
description: Follow this guide to configure container logging.
---

# Writing to the container execution log

{% include [logging-note](../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with your container.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select the container you want to configure logging for.
    1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. Under **{{ ui-key.yacloud.logging.label_title }}**:

        1. Enable **{{ ui-key.yacloud.logging.field_logging }}**.
        1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select:
                  
           * `{{ ui-key.yacloud.common.folder }}`: To write [logs](../concepts/logs.md) to the default [log group](../../logging/concepts/log-group.md) for the folder the container is in.
           * {% include [log-group](../../_includes/functions/log-group.md) %}
        
        1. Optionally, select the minimum logging level.

    1. At the top of the page, click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. 
    
    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    ### Logging destination {#destination}

    {% include [logging-destination](../../_includes/serverless-containers/logging-destination.md) %}

    To write logs to a custom log group, provide the log group ID in the `--log-group-id` parameter when [creating a container revision](manage-revision.md). The log group must reside in the same folder as the container.

    ### Minimum logging level {#log-level}

    To set a minimum logging level, specify it in the `--min-log-level` parameter when creating a container revision. 

    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

    ### Disabling logging {#disabled}

    To disable logging, specify the `--no-logging` parameter when creating a container revision.

    ### Command example {#example}

    To write logs to a custom log group, run this command:

    ```bash
    {{ yc-serverless }} container revision deploy \
      --container-id <container_ID> \
      --image <Docker_image_URL> \
      --service-account-id <service_account_ID> \
      --log-folder-id <folder_ID> \
      --min-log-level <minimum_logging_level>
    ```

    Where:
    * `--container-id`: Container ID. To find out the ID, [get](list.md) a list of containers.
    * `--image`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
    * `--service-account-id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
    * `--log-group-id`: ID of the log group to write logs to.
    * `--min-log-level`: Minimum logging level. This is an optional parameter.

    Result:

    ```text
    done (5s)
    id: bba9vrtrjlld********
    container_id: bbanb9mvu1dl********
    created_at: "2024-05-08T07:22:45.378Z"
    image:
      image_url: {{ registry }}/crprip91p1q9********/ubuntu:hello
      image_digest: sha256:aa55c46fba9b14b8d8de16e2f8a07d716edfb1dbbb9433b827214ad2********
    resources:
      memory: "1073741824"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    service_account_id: ajeh91ebakk1********
    status: ACTIVE
    log_options:
      log_group_id: e23824sf51g5********
      min_level: ERROR
    ```

- {{ TF }} {#tf}
    
    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
    
    {% include [terraform-install](../../_includes/terraform-install.md) %}

    ### Logging destination {#destination}

    {% include [logging-destination](../../_includes/serverless-containers/logging-destination.md) %}

    To write logs to a custom log group, in the `log_options` section, provide the log group ID in the `log_group_id` parameter when [creating a container revision](manage-revision.md). The log group must reside in the same folder as the container.

    ### Minimum logging level {#log-level}

    To set a minimum logging level, specify it in the `log_group_id` parameter when creating a container revision. 

    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

    ### Disabling logging {#disabled}

    To disable logging, under `log_options`, set the `disabled` parameter to `true` when creating a container revision.

    ### Example {#example}

    To write logs to a custom log group:

    1. Open the {{ TF }} configuration file and add the `log_options` section to the `yandex_serverless_container` resource description:

        Here is an example of the configuration file structure:
        
        ```hcl
        resource "yandex_serverless_container" "<container_name>" {
          name               = "<container_name>"
          service_account_id = "<service_account_ID>"
          memory             = <RAM_size>
          image {
            url = "<Docker_image_URL>"
          }
          log_options {
            folder_id = "<folder_ID>"
            min_level = "<minimum_logging_level>"
          }
        }
        ```

        Where:
        * `name`: Container name.
        * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) with permissions to download a Docker image.
        * `memory`: Required memory. The default value is 128 MB.
        * `url`: [Docker image](../../container-registry/concepts/docker-image.md) URL.
        * `folder_id`: Folder ID.
        * `min_level`: Minimum logging level. This is an optional parameter.

        For more information about the `yandex_serverless_container` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

    1. Create the resources:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

 - API {#api}

    To write to the container execution log, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## Structured logs {#structured-logs}

Apart from text, you can write [structured logs](../concepts/logs.md#structured-logs) to the standard output stream (`stdout`) and standard error output stream (`stderr`).

### Applications and Dockerfile examples

{% list tabs group=programming_language %}

- Node.js {#node}

    **index.js**
    ```js
    const winston = require('winston');
    const express = require('express');

    const logger = winston.createLogger({
        level: 'debug',
        format: winston.format.json(),
        transports: [new winston.transports.Console()],
    });

    const app = express();
    app.use(express.urlencoded({ extended: true }));
    app.use(express.json());

    app.get("/", (req, res) => {
        logger.info({"message": "My log message", "my-key": "my-value"})
        return res.send("Hello, world!");
    });

    app.listen(process.env.PORT);
    ```

    **Dockerfile**
    ```dockerfile
    FROM node:16-slim

    WORKDIR /app
    RUN npm install winston express
    COPY ./index.js .

    CMD [ "node", "index.js" ]
    ```

- Python {#python}

    **requirements.txt**
    ```text
    python-json-logger==2.0.4
    sanic==22.12.0
    ```

    **index.py**
  
    ```python
    import logging
    import os

    from pythonjsonlogger import jsonlogger
    from sanic import Sanic
    from sanic.response import text


    class YcLoggingFormatter(jsonlogger.JsonFormatter):
        def add_fields(self, log_record, record, message_dict):
            super(YcLoggingFormatter, self).add_fields(log_record, record, message_dict)
            log_record['logger'] = record.name
            log_record['level'] = str.replace(str.replace(record.levelname, "WARNING", "WARN"), "CRITICAL", "FATAL")


    app = Sanic(__name__)

    logHandler = logging.StreamHandler()
    logHandler.setFormatter(YcLoggingFormatter('%(message)s %(level)s %(logger)s'))

    logger = logging.getLogger('MyLogger')
    logger.propagate = False
    logger.addHandler(logHandler)
    logger.setLevel(logging.DEBUG)


    @app.route("/")
    async def hello(request):
        logger.info("My log message", extra={"my-key": "my-value"})
        return text("Hello, world!", status=200)


    if __name__ == "__main__":
        app.run(host='0.0.0.0', port=int(os.environ['PORT']), motd=False, access_log=False)
    ```

    **Dockerfile**
    ```dockerfile
    FROM python:3.10-slim

    WORKDIR /app
    COPY ./index.py .
    COPY ./requirements.txt .
    RUN pip install --no-cache-dir --prefer-binary --requirement=./requirements.txt

    CMD [ "python", "index.py" ]
    ```

- Go {#go}

    **index.go**
    ```go
    package main

    import (
        "go.uber.org/zap"
        "net/http"
        "os"
    )

    func main() {
        zapConfig := zap.NewProductionConfig()
        zapConfig.DisableCaller = true
        zapConfig.Level.SetLevel(zap.DebugLevel)
        logger, _ := zapConfig.Build()

        portStr := os.Getenv("PORT")
        http.Handle("/", handler{logger})
        http.ListenAndServe(":"+portStr, nil)
    }

    type handler struct {
        logger *zap.Logger
    }

    func (h handler) ServeHTTP(writer http.ResponseWriter, _ *http.Request) {
        h.logger.Info(
            "My log message",
            zap.String("my-key", "my-value"),
        )

        writer.WriteHeader(200)
        _, _ = writer.Write([]byte("Hello, world!"))
    }
    ```

    **Dockerfile**
    ```dockerfile
    FROM golang:latest AS build

    WORKDIR /app
    ADD index.go .
    ADD go.mod .
    ADD go.sum .
    RUN go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o server-app *.go

    FROM scratch
    COPY --from=build /app/server-app /server-app

    ENTRYPOINT ["/server-app"]
    ```

{% endlist %}