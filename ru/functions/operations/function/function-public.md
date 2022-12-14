# Сделать функцию публичной

Чтобы любой пользователь мог вызвать функцию без передачи заголовка авторизации, сделайте ее публичной.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию, которую хотите сделать публичной.
    1. На странице **Обзор**, в разделе **Общая информация**, переведите переключатель **Публичная функция** в активное состояние.
    
- CLI 

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы сделать функцию публичной, выполните команду:
    
    ```
    yc serverless function allow-unauthenticated-invoke <имя функции>
    ```

    Результат:

    ```
    done (1s)    
    ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы сделать функцию публичной:

  1. Опишите в конфигурационном файле параметры прав доступа к функции:

     ```
     resource "yandex_function_iam_binding" "function-iam" {
       function_id = "<идентификатор_функции>"
       role        = "{{ roles-functions-ivoker }}"
       members = [
         "system:allUsers",
       ]
     }
     ```

     Где:

     * `function_id` — идентификатор функции. Чтобы узнать идентификатор функции, [получите список функций](function-list.md) в каталоге.
     * `role` — роль, которую нужно назначить.
     * `members` — список пользователей, которым нужно назначить роль.

        Чтобы функция стала публичной, назначьте роль `{{ roles-functions-ivoker }}` всем неавторизованным пользователям ([системной группе](../../../iam/concepts/access-control/system-group.md) `allUsers`).

     Более подробную информацию о параметрах ресурса `yandex_function_iam_binding` см. в [документации провайдера]({{ tf-provider-link }}/function_iam_binding).

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

- API

    Сделать функцию публичной можно с помощью метода API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md).

{% endlist %}
