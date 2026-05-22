# Получить информацию о секрете, его содержимом и правах доступа

Вы можете получить подробную [информацию о секрете](#secret-info), [содержимое секрета](#secret-contents), а также [просмотреть права доступа к секрету](#secret-access).

## Получить информацию о секрете {#secret-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит [секрет](../concepts/secret.md).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Lockbox**.
    1. В меню слева выберите **Секреты**.
    1. Нажмите на имя нужного секрета.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [секрете](../concepts/secret.md):

      ```bash
      yc lockbox secret get --help
      ```

  1. Получите информацию о секрете, указав его имя или идентификатор:

      ```bash
      yc lockbox secret get <имя_секрета>
      ```

     Результат:

      ```text
      id: e6qi98vtdva1********
      folder_id: b1go79qlt1tp********
      created_at: "2023-11-03T15:28:18.909Z"
      name: test-secret
      kms_key_id: abj765aos682********
      status: ACTIVE
      current_version:
        id: e6q7nvojsgmk********
        secret_id: e6qi98vtdva1********
        created_at: "2023-11-03T15:28:18.909Z"
        status: ACTIVE
        payload_entry_keys:
          - example-key
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы получить информацию о [секрете](../concepts/secret.md) с помощью Terraform:
  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_lockbox_secret" "my_secret" {
       secret_id = "<идентификатор_секрета>"
     }

     output "current_version" {
       value = data.yandex_lockbox_secret.my_secret.current_version
     }
     ```

     Где:
     * `data "yandex_lockbox_secret"` — описание секрета в качестве источника данных:
       * `secret_id` — идентификатор секрета.
     * `output "current_version"` — выходная переменная, которая содержит информацию о текущей версии секрета:
       * `value` — возвращаемое значение.

     Вместо `current_version` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_lockbox_secret` см. в [документации провайдера](../../terraform/data-sources/lockbox_secret.md).
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

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     current_version = tolist([
       {
         "created_at" = "2024-03-27T02:45:05Z"
         "description" = ""
         "destroy_at" = ""
         "id" = "e6qo5a6imnm0********"
         "payload_entry_keys" = tolist([
           "key",
         ])
         "secret_id" = "e6qnva6ntl66********"
         "status" = "ACTIVE"
       },
     ])
     ```

- API {#api}

  Чтобы получить информацию о [секрете](../concepts/secret.md), воспользуйтесь методом REST API [get](../api-ref/Secret/get.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Get](../api-ref/grpc/Secret/get.md).

{% endlist %}

## Получить содержимое секрета {#secret-contents}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит секрет.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Lockbox**.
    1. В меню слева выберите **Секреты**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **Версии** нажмите на нужную версию секрета.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения содержимого секрета:

      ```bash
      yc lockbox payload get --help
      ```

  1. Получите содержимое секрета, указав его имя или идентификатор:

      ```bash
      yc lockbox payload get <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```text
      version_id: e6q7nvojsgmk********
      entries:
        - key: example-key
          text_value: example-value
      ```

      Если в качестве конфиденциального значения используется файл, то содержимое секрета возвращается в [кодировке Base64](https://ru.wikipedia.org/wiki/Base64). Вы можете декодировать файл с помощью утилиты base64 на Linux:
      
      ```bash
      base64 --decode <путь_к_файлу> > output.txt
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы получить содержимое секрета с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_lockbox_secret_version" "my_secret_version" {
       secret_id  = "<идентификатор_секрета>"
       version_id = "<идентификатор_версии>"
     }

     output "my_secret_entries" {
       value = data.yandex_lockbox_secret_version.my_secret_version.entries
     }
     ```

     Где:
     * `data "yandex_lockbox_secret_version"` — описание секрета в качестве источника данных:
       * `secret_id` — идентификатор секрета.
       * `version_id` — идентификатор версии секрета. Необязательный параметр. По умолчанию используется текущая версия секрета.
     * `output "my_secret_entries"` — выходная переменная, которая хранит содержимое секрета:
       * `value` — возвращаемое значение.

     Более подробно о параметрах источника данных `yandex_lockbox_secret_version` см. в [документации провайдера](../../terraform/data-sources/lockbox_secret_version.md).

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

     Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     my_secret_entries = [
       {
         key        = "example-key"
         text_value = "example-value"
       },
       {
         key        = "example-key"
         text_value = "example-value"
       },
     ]
     ```

- API {#api}

  Чтобы получить содержимое секрета, воспользуйтесь методом REST API [get](../api-ref/Payload/get.md) для ресурса [Payload](../api-ref/Payload/index.md) или вызовом gRPC API [PayloadService/Get](../api-ref/grpc/Payload/get.md).

  Если в качестве конфиденциального значения используется файл, то содержимое секрета возвращается в [кодировке Base64](https://ru.wikipedia.org/wiki/Base64). Вы можете декодировать файл с помощью модуля [base64 в Python](https://docs.python.org/3/library/base64.html) или других инструментов.

{% endlist %}

## Просмотреть права доступа к секрету {#secret-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит секрет.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Lockbox**.
    1. В меню слева выберите **Секреты**.
    1. Нажмите на имя нужного секрета.
    1. На панели слева выберите раздел ![image](../../_assets/console-icons/persons.svg) **Права доступа**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра прав доступа к секрету:

      ```bash
      yc lockbox secret list-access-bindings --help
      ```

  1. Просмотрите права доступа к секрету, указав его имя или идентификатор:

      ```bash
      yc lockbox secret list-access-bindings <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```text
      +---------+---------------+----------------------+
      | ROLE ID | SUBJECT TYPE  |      SUBJECT ID      | 
      +---------+---------------+----------------------+
      | viewer  | federatedUser | ajej2i98kcjd******** | 
      +---------+---------------+----------------------+
      ```

- API {#api}

  Чтобы посмотреть права доступа к секрету, воспользуйтесь методом REST API [ListAccessBindings](../api-ref/Secret/listAccessBindings.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ListAccessBindings](../api-ref/grpc/Secret/listAccessBindings.md).

{% endlist %}