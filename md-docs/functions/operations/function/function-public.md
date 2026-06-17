# Сделать функцию публичной

Чтобы любой пользователь мог вызвать функцию без передачи заголовка авторизации, сделайте ее публичной.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. Выберите функцию, которую хотите сделать публичной.
    1. На странице **Обзор** включите опцию **Публичная функция**.
    
- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы сделать функцию публичной, выполните команду:
    
    ```bash
    yc serverless function allow-unauthenticated-invoke <имя_функции>
    ```

    Результат:

    ```text
    done (1s)
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы сделать функцию публичной:

  1. Опишите в конфигурационном файле параметры прав доступа к функции:

     ```hcl
     resource "yandex_function_iam_binding" "function-iam" {
       function_id = "<идентификатор_функции>"
       role        = "functions.functionInvoker"
       members = [
         "system:allUsers",
       ]
     }
     ```

     Где:

     * `function_id` — идентификатор функции. Чтобы узнать идентификатор функции, [получите список функций](function-list.md) в каталоге.
     * `role` — роль, которую нужно назначить.
     * `members` — список пользователей, которым нужно назначить роль.

        Чтобы функция стала публичной, назначьте роль `functions.functionInvoker` всем неавторизованным пользователям ([публичной группе](../../../iam/concepts/access-control/public-group.md) `All users`).

     Подробнее о параметрах ресурса `yandex_function_iam_binding` в [документации провайдера](../../../terraform/resources/function_iam_binding.md).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить назначение роли функции можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc serverless function list-access-bindings <имя_функции>
     ```

- API {#api}

   Чтобы сделать функцию публичной, воспользуйтесь методом REST API [setAccessBindings](../../functions/api-ref/Function/setAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetAccessBindings](../../functions/api-ref/grpc/Function/setAccessBindings.md).

{% endlist %}