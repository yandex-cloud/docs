---
title: Запись логов в журнал выполнения в {{ serverless-containers-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование контейнера.
---

# Записать логи в журнал выполнения контейнера

{% include [logging-note](../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер, для которого хотите настроить логирование.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **{{ ui-key.yacloud.logging.label_title }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}` — чтобы выключить логирование.
        * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать [логи](../concepts/logs.md) в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для каталога, в котором находится контейнер.
            1. (Опционально) В поле **{{ ui-key.yacloud.logging.label_minlevel }}** выберите минимальный уровень логирования.
        * `{{ ui-key.yacloud.logging.label_loggroup }}` — чтобы записывать логи в пользовательскую лог-группу.
            1. (Опционально) В поле **{{ ui-key.yacloud.logging.label_minlevel }}** выберите минимальный уровень логирования.
            1. В поле **{{ ui-key.yacloud.logging.label_loggroup }}** выберите лог-группу, в которую будут записываться логи. Если у вас нет лог-группы, [создайте ее](../../logging/operations/create-group.md).
    1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. 
    
    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    ### Назначение логирования {#destination}

    {% include [logging-destination](../../_includes/serverless-containers/logging-destination.md) %}

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор лог-группы в параметре `--log-group-id` при [создании ревизии контейнера](manage-revision.md). Лог-группа должна находиться в том же каталоге, в котором находится контейнер.

    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `--min-log-level` при создании ревизии контейнера. 

    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании ревизии контейнера укажите параметр `--no-logging`.

    ### Пример команды {#example}

    Чтобы записывать логи в пользовательскую лог-группу, выполните команду:

    ```bash
    {{ yc-serverless }} container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --log-folder-id <идентификатор_каталога> \
      --min-log-level <минимальный_уровень_логирования>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
    * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.
    * `--min-log-level` — минимальный уровень логирования. Необязательный параметр.

    Результат:

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

    ### Назначение логирования {#destination}

    {% include [logging-destination](../../_includes/serverless-containers/logging-destination.md) %}

    Чтобы записывать логи в пользовательскую лог-группу, в блоке `log_options` укажите идентификатор лог-группы в параметре `log_group_id` при [создании ревизии контейнера](manage-revision.md). Лог-группа должна находиться в том же каталоге, в котором находится контейнер.

    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `log_group_id` при создании ревизии контейнера. 

    {% include [min-log-level](../../_includes/serverless-containers/min-log-level.md) %}

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании ревизии контейнера в блоке `log_options` укажите параметр `disabled` со значением `true`.

    ### Пример {#example}

    Чтобы записывать логи в пользовательскую лог-группу:

    1. Откройте файл конфигурации {{ TF }} и добавьте к описанию ресурса `yandex_serverless_container` блок `log_options`:

        Пример структуры конфигурационного файла:
        
        ```hcl
        resource "yandex_serverless_container" "<имя_контейнера>" {
          name               = "<имя_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          memory             = <объем_RAM>
          image {
            url = "<URL_Docker-образа>"
          }
          log_options {
            folder_id = "<идентификатор_каталога>"
            min_level = "<минимальный_уровень_логирования>"
          }
        }
        ```

        Где:
        * `name` — имя контейнера.
        * `service_account_id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
        * `memory` — требуемая память. По умолчанию — 128 МБ.
        * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
        * `folder_id` — идентификатор каталога.
        * `min_level` — минимальный уровень логирования. Необязательный параметр.

        Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

    1. Создайте ресурсы:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

 - API {#api}

    Чтобы записывать логи в журнал выполнения контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## Структурированные логи {#structured-logs}

Кроме текстовых записей, в стандартный поток вывода (`stdout`) и стандартный поток вывода ошибок (`stderr`) можно писать [структурированные логи](../concepts/logs.md#structured-logs).

### Примеры приложений и Dockerfile

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