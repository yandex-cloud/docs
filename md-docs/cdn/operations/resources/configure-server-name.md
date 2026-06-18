# Настройка пользовательского имени сервера для SNI

Вы можете настроить пользовательское имя сервера для [SNI (Server Name Indication)](https://ru.wikipedia.org/wiki/Server_Name_Indication) при установке HTTPS-соединения [CDN-серверов с источником](../../concepts/servers-to-origins.md).

{% note info %}

Настройка доступна только при использовании HTTPS-соединения между CDN-серверами и источником.

{% endnote %}


## Создать ресурс с пользовательским именем сервера для SNI {#create}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания ресурсов:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список всех [групп источников](../../concepts/origins.md#groups) в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Результат:

      ```text
      - id: "*****"
        folder_id: b1g86q4m5vej********
        name: test-group-1
      ...
          origin_group_id: "*****"
          source: www.a1.com
          enabled: true
      ```

  1. [Создайте](create-resource.md) ресурс с пользовательским именем сервера для SNI:

      ```bash
      yc cdn resource create <доменное_имя_ресурса> \
        --origin-group-id <идентификатор_группы_источников> \
        --origin-protocol HTTPS \
        --custom-server-name <имя_сервера_для_SNI>
      ```

      Результат:

      ```text
      id: bc8rpzaciiyp********
      folder_id: b1g681qpemb4********
      cname: example.com
      ...
        custom_server_name:
          enabled: true
          value: custom.example.com
      ...
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      ```tf
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "<имя_домена>"
          active              = true
          origin_protocol     = "https"
          origin_group_id     = <идентификатор_группы_источников>
          options {
            custom_server_name  = <имя_сервера_для_SNI>
          }
      }
      ```

      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей: `true` — контент из CDN доступен клиентам, `false` — доступ к контенту отключен. Значение по умолчанию: `true`. Необязательный параметр.
      * `origin_protocol` — протокол для источников. Значение по умолчанию: `http`. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
      * `custom_server_name` — пользовательское имя сервера для SNI.

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

     Terraform создаст все требуемые ресурсы. Проверить создание CDN-ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

     ```bash
     yc cdn resource list
     ```

- REST API {#rest-api}

  Добавьте блок `customServerName` при использовании метода [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "originProtocol": "HTTPS",
  "options": {
    "customServerName": {
      "enabled": "<true_или_false>",
      "value": "string"
    }
  }
  ```

  Где:

  * `customServerName.enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `customServerName.value` — пользовательское имя сервера для SNI.
  * `originProtocol` — протокол соединения между CDN-серверами и источником.

- gRPC API {#grpc-api}

  Добавьте блок `custom_server_name` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md):

  ```json
  "origin_protocol": "HTTPS",
  "options": {
    "custom_server_name": {
      "enabled": "<true_или_false>",
      "value": "string"
    }
  }
  ```

  Где:

  * `custom_server_name.enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `custom_server_name.value` — новое пользовательское имя сервера для SNI.
  * `origin_protocol` — протокол соединения между CDN-серверами и источником.

{% endlist %}


## Изменить пользовательское имя сервера для SNI {#update}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для редактирования ресурсов:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список всех ресурсов в каталоге:

      ```bash
      yc cdn resource list --format yaml
      ```

      Результат:

      ```text
      - id: bc8rpzaciiyp********
        folder_id: b1g681qpemb4********
        cname: example.com
        ...
          custom_server_name:
            enabled: true
            value: custom.example.com
        ...
      ```

  1. [Измените](configure-basics.md) пользовательское имя сервера для SNI:

      ```bash
      yc cdn resource update <идентификатор_ресурса> \
        --origin-protocol HTTPS \
        --custom-server-name <новое_имя_сервера_для_SNI>
      ```

      Результат:

      ```text
      - id: bc8rpzaciiyp********
        folder_id: b1g681qpemb4********
        cname: example.com
        ...
          custom_server_name:
            enabled: true
            value: new.example.com
        ...
      ```

      Чтобы удалить пользовательское имя сервера для SNI, используйте флаг `--clear-custom-server-name`:

      ```bash
      yc cdn resource update <идентификатор_ресурса> \
        --clear-custom-server-name
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить параметры CDN-ресурса, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием ресурса:

      ```tf
      resource "yandex_cdn_resource" "my_resource" {
          cname               = "<имя_домена>"
          active              = true
          origin_protocol     = "https"
          origin_group_id     = <идентификатор_группы_источников>
          options {
            custom_server_name  = <новое_имя_сервера_для_SNI>
          }
      }
      ```

      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей: `true` — контент из CDN доступен клиентам, `false` — доступ к контенту отключен. Значение по умолчанию: `true`. Необязательный параметр.
      * `origin_protocol` — протокол для источников. Значение по умолчанию: `http`. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
      * `custom_server_name` — новое пользовательское имя сервера для SNI.

  1. Примените изменения:

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

      Terraform обновит все требуемые ресурсы. Проверить обновление CDN-ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc cdn resource list
      ```

- REST API {#rest-api}

  Добавьте блок `customServerName` при использовании метода [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "originProtocol": "HTTPS",
  "options": {
    "customServerName": {
      "enabled": "<true_или_false>",
      "value": "string"
    }
  }
  ```

  Где:

  * `customServerName.enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `customServerName.value` — пользовательское имя сервера для SNI.
  * `originProtocol` — протокол соединения между CDN-серверами и источником.

- gRPC API {#grpc-api}

  Добавьте блок `custom_server_name` при использовании вызова [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "origin_protocol": "HTTPS",
  "options": {
    "custom_server_name": {
      "enabled": "<true_или_false>",
      "value": "string"
    }
  }
  ```

  Где:

  * `custom_server_name.enabled` — включение опции:
      * `true` — включить опцию.
      * `false` — отключить опцию.

  * `custom_server_name.value` — новое пользовательское имя сервера для SNI.
  * `origin_protocol` — протокол соединения между CDN-серверами и источником.


{% endlist %}