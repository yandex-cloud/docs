[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Пошаговые инструкции](../index.md) > Создание функции > Создать функцию

# Создать функцию

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
    1. Перейдите в сервис **Cloud Functions**
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя и описание функции. Формат имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

    1. Нажмите кнопку **Создать**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=<имя_функции>
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9********
    status: ACTIVE
    ```

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

        ```hcl
        resource "yandex_function" "my-function" {
          name       = "<имя_функции>"
          user_hash  = "<хеш_версии_функции>"
          runtime    = "<среда_выполнения>"
          entrypoint = "<точка_входа>"
          memory     = "<объем_памяти>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
        }
        ```

        Где:

        * `name` — имя функции.
        * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
        * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
        * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
        * `content` — исходный код функции:
            * `zip_filename` — путь к ZIP-архиву, содержащему исходный код функции и необходимые зависимости.

        Подробнее о параметрах ресурса `yandex_function` в [документации провайдера](../../../terraform/resources/function.md).

    1. Создайте ресурсы:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
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
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

        Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

        ```bash
        yc serverless function list
        ```

- API {#api}

    Чтобы создать функцию, воспользуйтесь методом REST API [create](../../functions/api-ref/Function/create.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/api-ref/grpc/Function/create.md).


{% endlist %}