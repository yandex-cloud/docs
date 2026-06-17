# Начало работы с Serverless Containers

В этой инструкции вы [подготовите](#prepare) [Docker-образ](../../container-registry/concepts/docker-image.md) контейнера в Yandex Container Registry и [добавите](#deploy) его в Serverless Containers.

## Подготовьте Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации.

Приложение должно определять номер порта, на котором принимать запросы, из переменной окружения `PORT`. Значение переменной задается сервисом автоматически.

Чтобы подготовить Docker-образ контейнера:
1. [Создайте](../../container-registry/operations/registry/registry-create.md) реестр Yandex Container Registry.
1. [Создайте и соберите](../../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/).
1. [Загрузите](../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

### Примеры приложений и Dockerfile {#examples}

{% list tabs group=programming_language %}

- Node.js {#node}

    **index.js**

    ```js
    const express = require('express');

    const app = express();
    app.use(express.urlencoded({ extended: true }));
    app.use(express.json());

    app.get("/hello", (req, res) => {
        var ip = req.headers['x-forwarded-for']
        console.log(`Request from ${ip}`);
        return res.send("Hello!");
    });

    app.listen(process.env.PORT, () => {
        console.log(`App listening at port ${process.env.PORT}`);
    });
    ```

    **Dockerfile**

    ```dockerfile
    FROM node:16-slim

    WORKDIR /app
    RUN npm install express
    COPY ./index.js .

    CMD [ "node", "index.js" ]
    ```

- Python {#python}

    **index.py**

    ```python
    import os
    from sanic import Sanic
    from sanic.response import text

    app = Sanic(__name__)

    @app.after_server_start
    async def after_server_start(app, loop):
        print(f"App listening at port {os.environ['PORT']}")

    @app.route("/hello")
    async def hello(request):
        ip = request.headers["X-Forwarded-For"]
        print(f"Request from {ip}")
        return text("Hello!")

    if __name__ == "__main__":
        app.run(host='0.0.0.0', port=int(os.environ['PORT']), motd=False, access_log=False)
    ```

    **Dockerfile**

    ```dockerfile
    FROM python:3.10-slim

    WORKDIR /app
    RUN pip install --no-cache-dir --prefer-binary sanic
    COPY ./index.py .

    CMD [ "python", "index.py" ]
    ```

- Go {#go}

    **index.go**

    ```golang
    package main

    import (
        "fmt"
        "net/http"
        "os"
    )

    func main() {
        portStr := os.Getenv("PORT")
        fmt.Printf("App listening at port %s\n", portStr)
        http.Handle("/hello", hwHandler{})
        http.ListenAndServe(":"+portStr, nil)
    }

    type hwHandler struct{}

    func (hwHandler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
        ip := request.Header.Get("X-Forwarded-For")
        fmt.Printf("Request from %s\n", ip)
        writer.WriteHeader(200)
        _, _ = writer.Write([]byte("Hello!"))
    }
    ```

    **Dockerfile**

    ```dockerfile
    FROM golang:latest AS build

    WORKDIR /app
    ADD index.go .
    RUN GOARCH=amd64 go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o server-app *.go

    FROM scratch
    COPY --from=build /app/server-app /server-app

    ENTRYPOINT ["/server-app"]
    ```

{% endlist %}

## Добавьте образ в Serverless Containers {#deploy}

### Создайте контейнер {#create-container}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Нажмите кнопку **Создать контейнер**.
  1. Введите имя и описание контейнера. Формат имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать [контейнер](../concepts/container.md), выполните команду:

  ```bash
  yc serverless container create --name <имя_контейнера>
  ```

  Результат:

  ```text
  id: bba3fva6ka5g********
  folder_id: b1gqvft7kjk3********
  created_at: "2021-07-09T14:49:00.891Z"
  name: my-beta-container
  url: https://bba3fva6ka5g********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать [контейнер](../concepts/container.md) и его [ревизию](../operations/manage-revision.md):

  {% note info %}

  Если [реестр](../../container-registry/concepts/registry.md) или [репозиторий](../../container-registry/concepts/repository.md) с Docker-образом не являются [публичными](../../container-registry/qa/index.md#public-registry), необходимо указать в настройках ревизии [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого [есть права](../../iam/operations/sa/assign-role-for-sa.md) на скачивание Docker-образа. Например, роль `container-registry.images.puller` на каталог или реестр, в которых находится Docker-образ.
  
  Если в настройках ревизии указан сервисный аккаунт, у пользователя или сервисного аккаунта, от имени которого создается ревизия, должна быть роль `iam.serviceAccounts.user`. Она подтверждает права на использование сервисного аккаунта.

  {% endnote %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * `name` — имя контейнера. Обязательный параметр. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `memory` — объем памяти в МБ, выделенный контейнеру. По умолчанию — 128 МБ.
     * `service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
     * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md) в [Yandex Container Registry](../../container-registry/index.md).

     >Пример структуры конфигурационного файла:
     >
     >```hcl
     >resource "yandex_serverless_container" "test-container" {
     >  name               = "<имя_контейнера>"
     >  memory             = <объем_памяти>
     >  service_account_id = "<идентификатор_сервисного_аккаунта>"
     >  image {
     >    url = "<URL_Docker-образа>"
     >  }
     >}
     >```

     Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

        ```bash
        yc serverless container list 
        ```

- API {#api}

  Чтобы создать [контейнер](../concepts/container.md), воспользуйтесь методом REST API [create](../containers/api-ref/Container/create.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../containers/api-ref/grpc/Container/create.md).

{% endlist %}

### Создайте ревизию контейнера {#create-revision}

Если [реестр](../../container-registry/concepts/registry.md) или [репозиторий](../../container-registry/concepts/repository.md) с Docker-образом не являются [публичными](../../container-registry/qa/index.md#public-registry), необходимо указать в настройках ревизии [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого [есть права](../../iam/operations/sa/assign-role-for-sa.md) на скачивание Docker-образа. Например, роль `container-registry.images.puller` на каталог или реестр, в которых находится Docker-образ.

Если в настройках ревизии указан сервисный аккаунт, у пользователя или сервисного аккаунта, от имени которого создается ревизия, должна быть роль `iam.serviceAccounts.user`. Она подтверждает права на использование сервисного аккаунта.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер, [ревизию](../concepts/container.md#revision) которого хотите создать.
  1. Перейдите на вкладку **Редактор**.
  1. В разделе **Параметры образа**:
      * Укажите URL Docker-образа из Yandex Container Registry.
      * Если необходимо, дополнительно укажите параметры ревизии:
          * **Команда** — команды, которые контейнер выполнит при запуске. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
          * **Аргументы** — соответствует инструкции `CMD` в Dockerfile. Аргументы указываются в формате `ключ = значение`. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.

              В контейнер можно передать несколько аргументов. Для этого нажмите **Добавить**.

          * **Рабочая директория** — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

  1. Нажмите кнопку **Создать ревизию**.

- CLI {#cli}

  Чтобы создать [ревизию](../concepts/container.md#revision) [контейнера](../concepts/container.md), выполните команду:

  ```bash
  yc serverless container revision deploy \
    --container-name <имя_контейнера> \
    --image <URL_Docker-образа> \
    --cores 1 \
    --memory 1GB \
    --execution-timeout 30s \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --command '<команда_1>','<команда_2>' \
    --args '<ключ_1=значение_1>','<ключ_2=значение_2>'
  ```


  Где:
  * `--cores` — количество ядер, которые доступны контейнеру.
  * `--memory` — требуемая память. По умолчанию — 128 МБ.
  * `--execution-timeout` — таймаут. По умолчанию — 3 секунды.
  * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
  * `--command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
  * `--args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.

  Результат:

  ```text
  id: bbajn5q2d74c********
  container_id: bba3fva6ka5g********
  created_at: "2021-07-09T15:04:55.135Z"
  image:
    image_url: cr.yandex/crpd3cicopk7********/test-container:latest
    image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
  resources:
    memory: "1073741824"
    cores: "1"
  execution_timeout: 3s
  service_account_id: ajeqnasj95o7********
  status: ACTIVE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  В Terraform [ревизия](../concepts/container.md#revision) создается при каждом обновлении параметров работы ресурса.

  Чтобы создать ревизию:
  1. Обновите в конфигурационном файле параметры ресурса `yandex_serverless_container`:

     ```hcl
     resource "yandex_serverless_container" "test-container" {
       name               = "<имя_контейнера>"
       cores              = "<количество_ядер>"
       memory             = "<объем_памяти>"
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       image {
         url      = "<URL_Docker-образа>"
         command  = ["<команда_1>","<команда_2>"]
         args     = ["<ключ_1=значение_1>","ключ_2=значение_2"]
         work_dir = "<рабочая_директория>"
       }
     }
     ```

     Где:

     * `cores` — количество ядер, которые доступны контейнеру.
     * `memory` — требуемая память. По умолчанию — 128 МБ.
     * `command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
     * `args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение CMD по умолчанию из Docker-образа.
     * `work_dir` — позволяет изменить рабочую директорию контейнера. Соответствует инструкции `WORKDIR` в Dockerfile. Рекомендуется устанавливать абсолютные пути к папкам.

     Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).

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

     После этого будет создана ревизия. Проверить создание ревизии можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc serverless container revision list
     ```

- API {#api}

  Чтобы создать [ревизию](../concepts/container.md#revision) [контейнера](../concepts/container.md), воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## Вызовите контейнер {#invoke}

После создания контейнера вы получите ссылку для вызова. [Как узнать ее.](../operations/invoke.md#link) Сделайте HTTPS-запрос, передав [IAM-токен](../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```bash
curl \
  --header "Authorization: Bearer $(yc iam create-token)" \
  https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Результат:

```text
Hello!
```

## Что дальше {#whats-next}

* Изучите [концепции сервиса](../concepts/invoke.md).