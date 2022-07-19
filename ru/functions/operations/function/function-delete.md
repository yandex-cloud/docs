# Удаление функции

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Удалить функцию

{% list tabs %}

- Консоль управления
  
    Чтобы удалить [функцию](../../concepts/function.md):
    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором хотите удалить функцию.
    1. Выберите сервис **{{ sf-name }}**.
    1. В строке с функцией нажмите значок ![image](../../../_assets/options.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
  
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Удалите функцию:
    
    ```
    yc serverless function delete <имя функции>
    ```
    Результат:
    ```
    done (1s)    
    id: b09kk2ujb8js23f73b06
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486t34iut5q
    http_invoke_url: https://functions.yandexcloud.net/b09kk2ujb8js23f73b06
    status: DELETING
    ```

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы удалить функцию, созданную с помощью {{ TF }}:

    1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием функции.
       
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
      
    Проверить удаление функции можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function list
    ```

- Yandex Cloud Toolkit

    Удалить функцию можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
