# Добавить переменные окружения функции

При добавлении переменных окружения создается новая версия функции. В существующую версию переменные добавить нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
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

    ```bash
    yc serverless function version create \
      --function-name=<имя_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <идентификатор_версии> \
      --environment <переменные_окружения>
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--environment` — переменные окружения в формате `key=value`. Можно указать несколько пар через запятую.

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы добавить переменные окружения:

    1. В конфигурационном файле добавьте блок `environment` для ресурса `yandex_function` и укажите список переменных окружения в формате `<ключ> = "<значение>"`.

       Пример описания функции в конфигурации {{ TF }}:
      
        ```hcl
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "python37"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            tags               = ["my_tag"]
            environment = {
                <ключ_переменной_окружения> = "<значение_переменной_окружения>"
            }
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ```

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-link }}/function).

    1. Проверьте конфигурацию командой:
        
       ```bash
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```text
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```bash
       terraform plan
       ```
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
         
    1. Примените изменения конфигурации:

       ```bash
       terraform apply
       ```

    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
    Проверить появление переменных окружения можно в [консоли управления]({{ link-console-main }}).

- API

    Чтобы добавить переменные окружения, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

- {{ yandex-cloud }} Toolkit

    Добавить переменные окружения можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}


## См. также

* [Переменные окружения](../../concepts/runtime/environment-variables.md#env).