# Удалить тег версии функции

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
      
    Проверить удаление тегов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя функции>
    ```

- API

    Чтобы удалить тег версии функции, воспользуйтесь методом REST API [removeTag](../../functions/api-ref/Function/removeTag.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/RemoveTag](../../functions/api-ref/grpc/function_service.md#RemoveTag).

- {{ yandex-cloud }} Toolkit

    Удалить тег можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
