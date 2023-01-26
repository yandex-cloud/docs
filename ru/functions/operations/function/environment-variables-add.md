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

- {{ yandex-cloud }} Toolkit

    Добавить переменные окружения можно с помощью [плагина {{ yandex-cloud }} Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## См. также

* [Переменные окружения](../../concepts/runtime/environment-variables.md#env).