# Удалить функцию

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором хотите удалить функцию.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. В строке с функцией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.serverless-functions.list.button_action-delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.popup-confirm_button_delete }}**.
  
- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор функции, [получите](function-list.md) список функций в каталоге.
    
    Чтобы удалить функцию, выполните команду:
    
    ```
    yc serverless function delete <имя_функции>
    ```
    Результат:
    ```
    done (1s)
    id: b09kk2ujb8js********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486********
    http_invoke_url: https://{{ sf-url }}/b09kk2ujb8js********
    status: DELETING
    ```

- {{ TF }} {#tf}

    [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            tags               = ["my_tag"]
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
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
      
    Проверить удаление функции можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function list
    ```

- API {#api}

    Чтобы удалить функцию, воспользуйтесь методом REST API [delete](../../functions/api-ref/Function/delete.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Delete](../../functions/api-ref/grpc/Function/delete.md).


{% endlist %}