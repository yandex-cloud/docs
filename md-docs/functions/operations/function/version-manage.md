[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Пошаговые инструкции](../index.md) > Создание функции > Создать версию функции

# Создать версию функции

Чтобы создать [версию](../../concepts/function.md#version) функции, вы можете воспользоваться одним из [форматов загрузки кода](../../concepts/function.md#upload). Для примера будет использован ZIP-архив.

{% note warning %}

Файл больше 3,5 МБ необходимо [загружать через Object Storage](../../../storage/operations/objects/upload.md). Подробнее об ограничениях читайте в разделе [Квоты и лимиты в Cloud Functions](../../concepts/limits.md).

{% endnote %}

## Подготовить ZIP-архив с кодом функции {#zip-archive}

1. Сохраните следующий код в файл с названием `index.js`:

    ```js
    exports.handler = async function (event, context) {
        let name = 'World';
        if (event.queryStringParameters && event.queryStringParameters.name) {
            name = event.queryStringParameters.name
        }
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };
    ```

1. Добавьте файл `index.js` в ZIP-архив `hello-js.zip`.

    {% note info %}
    
    При создании ZIP-архива на macOS с помощью контекстного меню Finder в архив автоматически добавляется служебная папка `__MACOSX`, которая может вызвать ошибки при сборке функций. Чтобы удалить папку из ZIP-архива, в командной строке перейдите в каталог, в котором расположен архив, и выполните команду:
    
    ```bash
    zip -d <имя_архива>.zip "__MACOSX/*"
    ```
    
    {% endnote %}

## Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:

* _Среда выполнения_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция. Подробнее в разделе [Среда выполнения](../../concepts/runtime/index.md).
* _Точка входа_ — функция, которая будет вызываться в качестве [обработчика](../../concepts/function.md#programming-model).
* _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите [среду выполнения](../../concepts/runtime/index.md). Отключите опцию **Добавить файлы с примерами кода**.
    1. Нажмите кнопку **Продолжить**.
    1. Подготовьте код функции:
       * **Среда выполнения**: `nodejs18`.
       * **Источник кода**: `ZIP-архив`.
       * **Файл**: `hello-js.zip`.
       * **Точка входа**: `index.handler`.
    1. Задайте параметры версии:
       * **Таймаут**: `5`.
       * **Память**: `128 МБ`.
       * [**Сервисный аккаунт**](../../../iam/concepts/users/service-accounts.md): `Не выбрано`.
       * [**Переменные окружения**](../../concepts/runtime/environment-variables.md): `Не выбрано`.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать версию функции, выполните команду:

    ```
    yc serverless function version create \
      --function-name=my-nodejs-function \
      --runtime nodejs18 \
      --entrypoint index.handler \
      --memory 128m \
      --execution-timeout 5s \
      --source-path ./hello-js.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.

    Результат:

    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs18
    entrypoint: index.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      folder_id: b1g681qpemb4********
    ```

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    Чтобы создать новую версию функции:

    1. Откройте файл конфигурации Terraform и измените параметры функции:
      
       * `yandex_function` — описание создаваемой функции и ее исходный код.
         * `name` — имя функции.
         * `description` — текстовое описание функции.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
         * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
         * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
         * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
         * `execution_timeout` — таймаут выполнения функции.
         * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
         * `content` — исходный код функции.
           * `content.0.zip_filename` — имя ZIP-архива, содержащего исходный код функции.

        Пример структуры конфигурационного файла:

        ```
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "nodejs18"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ```

       {% note info %}
    
       При изменении имени или описания функции версия создана не будет.

       {% endnote %}

        Подробнее о параметрах ресурса `yandex_function` в [документации провайдера](../../../terraform/resources/function.md).

    1. Проверьте конфигурацию командой:
        
       ```
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```
       terraform plan
       ```
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
    Проверить появление версии можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя_функции>
    ```

- API {#api}

    Чтобы создать версию функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

    **Примеры запросов**

    Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se) и [аутентифицируйтесь](../../api-ref/functions/authentication.md) в API.

    {% cut "Пример с загрузкой кода из бакета Object Storage" %}

    1. [Загрузите](../../../storage/operations/objects/upload.md) в бакет Object Storage ZIP-архив с кодом версии функции `hello-js.zip`.
    1. Подготовьте файл `body.json` с телом запроса:

        ```json
        {
          "functionId": "<идентификатор_функции>",
          "runtime": "nodejs22",
          "entrypoint": "index.handler",
          "resources": {
            "memory": "134217728"
          },
          "executionTimeout": "5s",
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "package": {
            "bucketName": "<имя_бакета>",
            "objectName": "hello-js.zip"
          },
        }
        ```

        Где:

        * `functionId` — идентификатор функции, версию которой вы хотите создать.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md#runtimes).
        * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
        * `memory` — объем RAM.
        * `executionTimeout` — максимальное время выполнения функции до таймаута.
        * `serviceAccountId` — идентификатор сервисного аккаунта, которому назначена [роль](../../../storage/security/index.md#service-roles), разрешающая чтение данных в бакете.
        * `bucketName` — имя бакета, в который вы загрузили ZIP-архив c кодом функции и необходимыми зависимостями.
        * `objectName` — [ключ объекта](../../../storage/concepts/object.md#key) с кодом функции в бакете.

    {% endcut %}

    {% cut "Пример с загрузкой кода в теле запроса" %}

    1. Кодируйте ZIP-архив с кодом функции в формат Base64:

        ```bash
        base64 -i hello-js.zip > output.txt
        ```

    1. Подготовьте файл `body.json` с телом запроса:

        ```json
        {
          "functionId": "<идентификатор_функции>",
          "runtime": "nodejs22",
          "entrypoint": "index.handler",
          "resources": {
            "memory": "134217728"
          },
          "executionTimeout": "5s",
          "content": "<содержимое_ZIP-архива_в_кодировке_Base64>"
        }
        ```

        Где:

        * `functionId` — идентификатор функции, версию которой вы хотите создать.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md#runtimes).
        * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
        * `memory` — объем RAM.
        * `executionTimeout` — максимальное время выполнения функции до таймаута.
        * `content` — код версии функции в кодировке Base64, содержимое файла `output.txt`.

    {% endcut %}

    {% cut "Пример с загрузкой кода из другой версии функции Cloud Functions" %}

    Подготовьте файл `body.json` с телом запроса:

    ```json
    {
      "functionId": "<идентификатор_функции>",
      "runtime": "nodejs22",
      "entrypoint": "index.handler",
      "resources": {
        "memory": "134217728"
      },
      "executionTimeout": "5s",
      "versionId": "<идентификатор_предыдущей_версии_функции>"
    }
    ```

    Где:

    * `functionId` — идентификатор функции, версию которой вы хотите создать.
    * `runtime` — [среда выполнения](../../concepts/runtime/index.md#runtimes).
    * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
    * `memory` — объем RAM.
    * `executionTimeout` — максимальное время выполнения функции до таймаута.
    * `versionId` — идентификатор одной из [предыдущих версий](version-list.md) функции.

    {% endcut %}

    Выполните запрос, указав путь к подготовленному ранее файлу с телом запроса:

    ```bash
    export IAM_TOKEN=$(yc iam create-token)
    curl -X POST \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d "@<путь_к_файлу_body.json>" \
      https://serverless-functions.api.cloud.yandex.net/functions/v1/versions
    ```
    
    Результат:
    
    ```json
    {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.serverless.functions.v1.CreateFunctionVersionMetadata",
        "functionVersionId": "d4e25m0gila4********"
      },
      "id": "d4edk0oobcc9********",
      "description": "Create function version",
      "createdAt": "2023-10-11T11:22:21.286786431Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2023-10-11T11:22:21.286786431Z"
    }
    ```


{% endlist %}

{% note info %}

Для сохранения целостности связей изменение версий функции не предусмотрено. Подробнее о взаимосвязи ресурсов читайте в разделе [Функция](../../concepts/function.md).

{% endnote %}