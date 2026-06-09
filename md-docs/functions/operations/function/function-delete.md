# Удалить функцию

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором хотите удалить функцию.
    1. Перейдите в сервис **Cloud Functions**.
    1. В строке с функцией нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
  
- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
    http_invoke_url: https://functions.yandexcloud.net/b09kk2ujb8js********
    status: DELETING
    ```

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    Чтобы удалить функцию, созданную с помощью Terraform:

    1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием функции.
       
       Пример описания функции в конфигурации Terraform:

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

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера](../../../terraform/resources/function.md).

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
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет. 
         
    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
    Проверить удаление функции можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function list
    ```

- API {#api}

    Чтобы удалить функцию, воспользуйтесь методом REST API [delete](../../functions/api-ref/Function/delete.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Delete](../../functions/api-ref/grpc/Function/delete.md).


{% endlist %}