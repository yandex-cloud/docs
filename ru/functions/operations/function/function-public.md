# Сделать функцию публичной

Чтобы любой пользователь мог вызвать функцию без передачи заголовка авторизации, сделайте ее публичной.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, которую хотите сделать публичной.
    1. На странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** включите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
    
- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы сделать функцию публичной, выполните команду:
    
    ```bash
    yc serverless function allow-unauthenticated-invoke <имя_функции>
    ```

    Результат:

    ```text
    done (1s)
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы сделать функцию публичной:

  1. Опишите в конфигурационном файле параметры прав доступа к функции:

     ```hcl
     resource "yandex_function_iam_binding" "function-iam" {
       function_id = "<идентификатор_функции>"
       role        = "{{ roles-functions-invoker }}"
       members = [
         "system:allUsers",
       ]
     }
     ```

     Где:

     * `function_id` — идентификатор функции. Чтобы узнать идентификатор функции, [получите список функций](function-list.md) в каталоге.
     * `role` — роль, которую нужно назначить.
     * `members` — список пользователей, которым нужно назначить роль.

        Чтобы функция стала публичной, назначьте роль `{{ roles-functions-invoker }}` всем неавторизованным пользователям ([публичной группе](../../../iam/concepts/access-control/public-group.md) `All users`).

     Более подробную информацию о параметрах ресурса `yandex_function_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_iam_binding).

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

     Проверить назначение роли функции можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc serverless function list-access-bindings <имя_функции>
     ```

- API {#api}

   Чтобы сделать функцию публичной, воспользуйтесь методом REST API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md).

{% endlist %}
