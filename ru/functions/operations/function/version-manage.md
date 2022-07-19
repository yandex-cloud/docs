# Управление версиями функции

Управление версиями функции позволяет:

* [Создать версию](version-manage.md#func-version-create)
* [Получить информацию о версии функции](version-manage.md#version-info)
    * [Получить список версий функции](version-manage.md#version-list)
    * [Получить подробную информацию о версии функции](version-manage.md#version-get)
* [Добавить переменную окружения](version-manage.md#version-env)
* [Управлять тегами версии](version-manage.md#manage-tags)

Вы можете изменить код функции с помощью [редактора кода](function-editor.md).

{% note info %}

Для сохранения целостности связей изменение и удаление версий функции не предусмотрено. Подробнее о взаимосвязи ресурсов читайте в разделе [{#T}](../../concepts/function.md).

{% endnote %}

##  Получить список функций {#function-list}

Для управления версиями функции нужны имя или уникальный идентификатор функции, которой эта версия принадлежит. Чтобы узнать их, получите список функций.

{% include [function-list](../../../_includes/functions/function-list.md) %}

## Создать версию функции {#func-version-create}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Подготовить ZIP-архив с кодом функции {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

### Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:

* _Среда выполнения_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция. Подробнее см. в разделе [Среда выполнения](../../concepts/runtime/index.md).
* _Точка входа_ — функция, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../../concepts/function.md#programming-model).
* _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите [среду выполнения](../../concepts/runtime/index.md). Используйте опцию **Добавить файлы с примерами кода**.
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
    id: d4evvn8obisajd51plaq
    function_id: d4elpv8pft639ku7k0u6
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
    log_group_id: ckg3qh8h363p40gmr9gn
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

## Получить информацию о версии функции {#version-info}

### Получить список версий функции {#version-list}

{% include [version-list](../../../_includes/functions/version-list.md) %}

### Получить подробную информацию о версии функции {#version-get}

{% include [version-get](../../../_includes/functions/version-get.md) %}

## Добавить переменную окружения {#version-env}

При добавлении переменных окружения создается новая версия функции. В существующую версию переменные добавить нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию, для версии которой хотите добавить переменную окружения.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Параметры** укажите переменную окружения и нажмите **Добавить**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **Создать версию**. Будет создана новая версия функции с указанными переменными окружения.
    
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой версии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```
    yc serverless function version create \
      --function-name=<имя функции> \
      --runtime <среда выполнения> \
      --entrypoint <точка входа> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <идентификатор версии> \
      --environment <переменные окружения>
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — ID версии функции, код которой вы хотите скопировать.
    * `--environment` — переменные окружения в формате key=value. Можно указать несколько пар через запятую.

- API

    Добавить переменные окружения можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы добавить переменные окружения:

    1. В конфигурационном файле добавьте блок `environment` для ресурса `yandex_function` и укажите список переменных окружения в формате `<ключ>:"<значение>"`.

       Пример описания функции в конфигурации {{ TF }}:
      
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
            tags               = ["my_tag"]
            environment = {
                <ключ_переменной_окружения> = "<имя_переменной_окружения>"
            }
            content {
                zip_filename = "<путь к ZIP-архиву>"
            }
        }
        ``` 

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
      
    Проверить появление переменных окружения можно в [консоли управления]({{ link-console-main }}).

- Yandex Cloud Toolkit

    Добавить переменные окружения можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Управлять тегами версии {#manage-tags}

При создании новой версии ей присваивается [тег](../../concepts/function.md#) по умолчанию — `$latest`. Вы можете [добавить](version-manage.md#set-tag) или [удалить](version-manage.md#remove-tag) тег версии.

Для обращения к версии функции используйте ее уникальный идентификатор. Как узнать уникальный идентификатор версии, читайте в разделе [Получить список версий функции](version-manage.md#version-list).

### Добавить тег {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить тег версии, выполните команду:

    ```
    yc serverless function version set-tag --id <идентификатор версии> --tag <тег>
    ```

    Результат:

    ```
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    - first
    log_group_id: eolv6578frac08uh5h6s
    ```

- API

    Добавить тег можно с помощью метода API [setTag](../../functions/api-ref/Function/setTag.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы добавить тег версии:

    1. В конфигурационном файле добавьте блок `tags` для ресурса `yandex_function` и укажите список тегов формате `tags = ["<имя_тега>"]`.

       Пример описания функции в конфигурации {{ TF }}:
      
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
            tags               = ["my_tag"]
            content {
                zip_filename = "<путь к ZIP-архиву>"
            }
        }
        ``` 

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
      
    Проверить появление тегов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя функции>
    ```

- Yandex Cloud Toolkit

    Добавить тег можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

### Удалить тег {#remove-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить тег версии, выполните команду:

    ```
    yc serverless function version remove-tag --id <идентификатор версии> --tag <тег>
    ```

    Результат:

    ```
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    log_group_id: eolv6578frac08uh5h6s
    ```

- API

    Удалить тег можно с помощью метода API [removeTag](../../functions/api-ref/Function/removeTag.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы удалить тег версии:

    1. Откройте файл конфигурации {{ TF }} и в блоке `tags` удалите строку с ненужным тегом.

       Пример описания функции в конфигурации {{ TF }}:
      
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
            tags               = ["my_tag"]
            content {
                zip_filename = "<путь к ZIP-архиву>"
            }
        }
        ``` 

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
      
    Проверить удаление тегов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя функции>
    ```

- Yandex Cloud Toolkit

    Удалить тег можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
