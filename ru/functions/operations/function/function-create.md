# Создать функцию

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
	1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
	1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
	1. Введите имя и описание функции. Формат имени:

		{% include [name-format](../../../_includes/name-format.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```
    yc serverless function create --name=<имя функции>
    ```

    Результат:

    ```
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9********
    status: ACTIVE
    ```

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

    Чтобы создать функцию: 

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `yandex_function` — описание создаваемой функции и ее исходный код:
         * `name` — имя функции.
         * `folder_id` — идентификатор каталога.
         * `description` — текстовое описание функции.
         * `labels` — метки функции в формате `ключ:значение`.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
         * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
         * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
         * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
         * `execution_timeout` — таймаут выполнения функции.
         * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
         * `environment` — переменные окружения в формате `ключ:значение`.
         * `tags` — теги функции.
         * `version` — версия функции.
         * `image_size` — размер образа для функции.
         * `loggroup_id` — идентификатор группы журналов выполнения функции.
         * `package` — Пакет с исходным кодом версии функции. Можно использовать либо только поле `package`, либо только поле `content`.
         * `package.0.sha_256` — SHA256-хэш развертываемого пакета.
         * `package.0.bucket_name` — имя бакета в {{ objstorage-name }}, в котором хранится исходный код версии функции.
         * `package.0.object_name` — имя объекта в {{ objstorage-name }}, содержащего исходный код версии функции.
         * `content` — исходный код функции. Можно использовать либо только поле `content`, либо только поле `package`.
         * `content.0.zip_filename` — имя ZIP-архива, содержащего исходный код функции.

        Пример структуры конфигурационного файла:

        
        ```
        provider "yandex" {
            token     = "<OAuth или статический ключ сервисного аккаунта>"
            folder_id = "<идентификатор каталога>"
            zone      = "{{ region-id }}-a"
        }
             
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "python37"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор сервисного аккаунта>"
            tags               = ["my_tag"]
            content {
                zip_filename = "<путь к ZIP-архиву>"
            }
        }

        output "yandex_function_test-function" {
            value = "${yandex_function.test-function.id}"
        }
        ```



        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

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
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
         
    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
       Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

       ```
       yc serverless function list
       ```

- API

    Чтобы создать функцию, воспользуйтесь методом REST API [create](../../functions/api-ref/Function/create.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/api-ref/grpc/function_service.md#Create).

- {{ yandex-cloud }} Toolkit

    Создать функцию можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
