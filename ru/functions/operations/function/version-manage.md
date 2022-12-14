# Создать версию функции

{% include [create-version](../../../_includes/functions/create-version.md) %}

## Подготовить ZIP-архив с кодом функции {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

## Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:

* _Среда выполнения_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция. Подробнее см. в разделе [Среда выполнения](../../concepts/runtime/index.md).
* _Точка входа_ — функция, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../../concepts/function.md#programming-model).
* _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите [среду выполнения](../../concepts/runtime/index.md). Не выбирайте опцию **Добавить файлы с примерами кода**.
    1. Подготовьте код функции:
       * Среда выполнения: `nodejs`.
       * Способ: ZIP-архив.
       * Файл: `hello-js.zip`.
       * Точка входа: `index.handler`.
    1. Задайте параметры версии:
       * Таймаут, с: 5.
       * Память: 128 МБ.
       * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts): Не выбрано.
       * [Переменные окружения](../../concepts/runtime/environment-variables.md): Не выбрано.
    1. В правом верхнем углу нажмите **Создать версию**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

    ```
    yc serverless function version create \
      --function-name=my-nodejs-function \
      --runtime nodejs12 \
      --entrypoint index.handler \
      --memory 128m \
      --execution-timeout 5s \
      --source-path ./hello-js.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя файла без расширения>`.`<имя обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

    Результат:

    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs12
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```

- API

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы создать новую версию функции:

    1. Откройте файл конфигурации {{ TF }} и измените параметры функции:
      
       * `yandex_function` — описание создаваемой функции и ее исходный код.
         * `name` — имя функции.
         * `description` — текстовое описание функции.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и  эту строку. Функция обновится при изменении этой строки.
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
            runtime            = "python37"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор сервисного аккаунта>"
            content {
                zip_filename = "<путь к ZIP-архиву>"
            }
        }
        ```

       {% note info %}
    
       При изменении имени или описания функции версия создана не будет.

       {% endnote %}

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-link }}/function).

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
      
    Проверить появление версии можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя функции>
    ```

- Yandex Cloud Toolkit

    Создать версию функции можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% note info %}

Для сохранения целостности связей изменение и удаление версий функции не предусмотрено. Подробнее о взаимосвязи ресурсов читайте в разделе [{#T}](../../concepts/function.md).

{% endnote %}
