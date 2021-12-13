# Создание функции

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
	1. Откройте сервис **{{ sf-name }}**
	1. Нажмите кнопку **Создать функцию**.
	1. Введите имя и описание функции. Формат имени:

		{% include [name-format](../../../_includes/name-format.md) %}

    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```
    yc serverless function create --name=<имя функции>
    ```

    Результат:

    ```
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    status: ACTIVE
    ```

- API

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).

- Terraform

   {% include [terraform-definition](../../../_includes/solutions/terraform-definition.md) %}

   Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

   Чтобы создать функцию: 
     
   1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
      
        * `yandex_function` — описание создаваемой функции и ее исходный код.
            * `name` — имя функции.
            * `folder_id` — идентификатор каталога.
            * `description` — текстовое описание функции.
            * `labels` — метки функции в формате `ключ:значение`.
            * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
            * `runtime` — среда выполнения функции. Полный список сред выполнения см. в разделе [Среды выполнения](../../concepts/runtime/index.md).
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
            zone      = "ru-central1-a"
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
      
        Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).
      
    2. Проверьте корректность конфигурационных файлов.
      
        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        2. Выполните проверку с помощью команды:
            ```
            terraform plan
            ```
        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
   3. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:
            ```
            terraform apply
            ```
        2. Подтвердите создание ресурсов.
      
        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- Yandex.Cloud Toolkit

    Создать функцию можно с помощью [плагина Yandex.Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
