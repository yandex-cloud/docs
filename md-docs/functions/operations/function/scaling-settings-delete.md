# Удалить настройки масштабирования функции

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию.
    1. В блоке **История версий** наведите курсор на тег версии функции (например, ![image](../../../_assets/console-icons/gear.svg) `$latest`), для которой хотите удалить настройки масштабирования.
    1. Во всплывающем окне нажмите кнопку **Настройки масштабирования**.
    1. Чтобы удалить настройку масштабирования, сделайте ее значение равным нулю.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Чтобы удалить настройки масштабирования, выполните команду:

    ```
    yc serverless function remove-scaling-policy \
      --id=<идентификатор_функции> \
      --tag=\$latest
    ```

    Где:

    * `--id` — идентификатор функции. Чтобы узнать его, [получите](function-list.md) список функций.
    * `--tag` — [тег](../../concepts/function.md#tag) версии функции.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.  

    Чтобы удалить настройки масштабирования:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `yandex_function_scaling_policy` — описание настроек масштабирования функции.
         * `function_id` — идентификатор функции.
         * `policy` — настройки масштабирования:
           * `policy.0.tag` — [тег](../../concepts/function.md#tag) версии функции.
           * `policy.0.zone_instances_limit` — количество экземпляров функции. Установите значение `0`.
           * `policy.0.zone_requests_limit` — количество выполняемых вызовов. Установите значение `0`.

        Пример структуры конфигурационного файла:

        ```
        resource "yandex_function_scaling_policy" "my_scaling_policy" {
            function_id = "are1samplefu********"
            policy {
                tag                  = "$latest"
                zone_instances_limit = 0
                zone_requests_limit  = 0
            }
        }
        ```
      
        Более подробную информацию о параметрах ресурса `yandex_function_scaling_policy` см. в [документации провайдера](../../../terraform/resources/function_scaling_policy.md).
      
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

    Проверить удаление настроек масштабирования можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):
    
    ```
    yc serverless function list-scaling-policies <имя_или_идентификатор_функции>
    ```

- API {#api}

    Чтобы удалить настройки масштабирования, воспользуйтесь методом REST API [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/RemoveScalingPolicy](../../functions/api-ref/grpc/Function/removeScalingPolicy.md).


{% endlist %}

## См. также

* [Масштабирование функции](../../concepts/function.md#scaling)