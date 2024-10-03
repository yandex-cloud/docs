---
title: Добавить метку функции
description: Следуя данной инструкции, вы сможете добавить метку функции.
---

# Добавить метку функции

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**. 
    1. Введите ключ и значение и нажмите **Enter**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы добавить метку функции, выполните команду:

    ```
    yc serverless function add-labels <имя_функции> --labels <ключ>=<значение>
    ```

    Результат:

    ```     
    id: b097d9ous3ge********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
      version: beta
    log_group_id: eolv6578frac********
    http_invoke_url: https://{{ sf-url }}/b097d9ous3ge********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    Чтобы добавить метку функции:

    1. В конфигурационном файле {{ TF }} добавьте блок `labels` и перечислите в нем список меток в формате `<ключ>:"<значение>"`.

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
            labels = {
              <ключ_1>:"<значение_1>",
              <ключ_2>:"<значение_2>"
            }
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
      
    Проверить добавление меток функции можно с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function get <имя_или_идентификатор_функции>
    ```

- API {#api}

    Чтобы добавить метку функции, воспользуйтесь методом REST API [update](../../functions/api-ref/Function/update.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Update](../../functions/api-ref/grpc/function_service.md#Update).

{% endlist %}
