# Изменить описание функции

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите изменить описание [функции](../../concepts/function.md).
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В правом верхнем углу нажмите кнопку **Редактировать**.
    1. В открывшемся окне укажите нужное описание функции.
    1. Нажмите кнопку **Сохранить**.        
    
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы изменить описание функции, выполните команду:

    ```
    yc serverless function update <имя функции> --description "<описание функции>"
    ```

    Результат:

    ```       
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    Изменить описание функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы изменить описание функции:

    1. Откройте файл конфигурации {{ TF }} и измените поле `description` во фрагменте с описанием функции.

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
      
    Проверить изменение описания функции можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function get <имя_функции>|<идентификатор_функции>
    ```

- {{ yandex-cloud }} Toolkit

    Изменить описание функции можно с помощью [плагина {{ yandex-cloud }} Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
