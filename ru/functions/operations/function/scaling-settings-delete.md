# Удалить настройки масштабирования функции

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В блоке **История версий** наведите курсор на тег версии функции (например, ![image](../../../_assets/settings.svg) `$latest`), для которой хотите удалить настройки масштабирования.
    1. Во всплывающем окне нажмите кнопку **Изменить**.
    1. Чтобы удалить настройку масштабирования, сделайте ее значение равным нулю.
    1. Нажмите кнопку **Сохранить**.

- CLI

    Чтобы удалить настройки масштабирования для функции, выполните команду:

    ```
    yc serverless function remove-scaling-policy \
      --id=d4eokpuol55h******** \
      --tag=\$latest
    ```

    Где:

    * `--id` — идентификатор функции. Чтобы узнать его, [получите](./function-list.md) список функций.
    * `--tag` —  [тег](../../concepts/function.md#tag) версии функции.

- API

    Удалить настройки масштабирования для функции можно с помощью метода API [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md).

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

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
      
        Более подробную информацию о параметрах ресурса `yandex_function_scaling_policy` см. в [документации провайдера]({{ tf-provider-link }}/yandex_function_scaling_policy).
      
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

    Проверить удаление настроек масштабирования можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):
    
    ```
    yc serverless function list-scaling-policies <имя_функции>|<идентификатор_функции>
    ```

- Yandex Cloud Toolkit

    Удалить настройки масштабирования для функции можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}