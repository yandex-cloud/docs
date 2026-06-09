# Записать логи в журнал выполнения контейнера

{% note info %}

Логирование тарифицируется. Подробнее см. в [документации Yandex Cloud Logging](../../logging/pricing.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер, для которого хотите настроить логирование.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Логирование**:

        1. Включите опцию **Запись логов**.
        1. В поле **Назначение** выберите:
                  
           * `Каталог` — чтобы записывать [логи](../concepts/logs.md) в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для каталога, в котором находится контейнер.
           * `Лог-группа` — чтобы записывать логи в пользовательскую лог-группу.
             
             Выберите лог-группу, в которую будут записываться логи, или [создайте](../../logging/operations/create-group.md) новую.
        
        1. (Опционально) Выберите минимальный уровень логирования.

    1. В верхней части страницы нажмите кнопку **Создать ревизию**. 
    
    Если минимальный уровень логирования задан, в журнал выполнения записываются логи указанного уровня и выше. Если минимальный уровень логирования не задан, в журнал выполнения записываются все логи контейнера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    ### Назначение логирования {#destination}

    Если в параметрах ревизии контейнера не указана пользовательская [лог-группа](../../logging/concepts/log-group.md) или логирование не отключено, контейнер автоматически пишет все [логи](../concepts/logs.md) в лог-группу по умолчанию для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором он находится.

    Чтобы записывать логи в лог-группу по умолчанию для другого каталога, укажите идентификатор этого каталога в параметре `--log-folder-id` при [создании ревизии контейнера](manage-revision.md). [Аккаунту](../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../logging/security/index.md#logging-editor) `logging.editor` или выше.

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в параметре `--log-group-id` при создании ревизии контейнера. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.

    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в параметре `--min-log-level` при создании ревизии контейнера. 

    Если минимальный уровень логирования задан, в журнал выполнения записываются логи указанного уровня и выше. Если минимальный уровень логирования не задан, в журнал выполнения записываются все логи контейнера.

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании ревизии контейнера укажите параметр `--no-logging`.

    ### Пример команды {#example}

    Чтобы записывать логи в пользовательскую лог-группу, выполните команду:

    ```bash
    yc serverless container revision deploy \
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
      image_url: cr.yandex/crprip91p1q9********/ubuntu:hello
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

- Terraform {#tf}
    
    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).
    
    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    ### Назначение логирования {#destination}

    Если в параметрах ревизии контейнера не указана пользовательская [лог-группа](../../logging/concepts/log-group.md) или логирование не отключено, контейнер автоматически пишет все [логи](../concepts/logs.md) в лог-группу по умолчанию для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором он находится.

    Чтобы записывать логи в лог-группу по умолчанию для другого каталога, укажите идентификатор этого каталога в блоке `log_options` в параметре `folder_id` при [создании ревизии контейнера](manage-revision.md). [Аккаунту](../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../logging/security/index.md#logging-editor) `logging.editor` или выше.

    Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в блоке `log_options` в параметре `log_group_id` при создании ревизии контейнера. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.

    ### Минимальный уровень логирования {#log-level}

    Чтобы задать минимальный уровень логирования, укажите его в блоке `log_options` в параметре `min_level` при создании ревизии контейнера. 

    Если минимальный уровень логирования задан, в журнал выполнения записываются логи указанного уровня и выше. Если минимальный уровень логирования не задан, в журнал выполнения записываются все логи контейнера.

    ### Отключение логирования {#disabled}

    Чтобы отключить логирование, при создании ревизии контейнера в блоке `log_options` укажите параметр `disabled` со значением `true`.

    ### Пример {#example}

    Чтобы записывать логи в пользовательскую лог-группу:

    1. Откройте файл конфигурации Terraform и добавьте к описанию ресурса `yandex_serverless_container` блок `log_options`:

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
        * `image` — параметры Docker-образа:
            * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
        * `log_options` — настройки логирования:
            * `folder_id` — идентификатор каталога.
            * `min_level` — минимальный уровень логирования. Необязательный параметр.

        Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера](../../terraform/resources/serverless_container.md).

    1. Создайте ресурсы:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

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

    **index.py*
  
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