[Документация Yandex Cloud](../../../index.md) > [Yandex IoT Core](../../index.md) > [Пошаговые инструкции](../index.md) > Управление паролями > Управление паролями реестра

# Управление паролями реестра

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями реестра для соответствующего способа авторизации.

{% note info %}

Если X.509 сертификат используется вместе с паролем, приоритет пароля выше.

{% endnote %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль реестру {#create-or-add}

Вы можете добавить пароль уже созданному реестру или задать его при создании реестра с помощью параметра `--password`.

{% note info %}

Задать пароль можно также из потока ввода. Для этого используйте флаг `--read-password` вместо параметра `--password`.

{% endnote %}

### Добавить пароль уже созданному реестру {#add}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить пароль уже созданному реестру:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите добавить пароль уже созданному реестру.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В блоке **Пароли** нажмите кнопку **Добавить пароль**.
   1. В поле **Пароль** введите пароль, который вы будете использовать для доступа к реестру.<br/>Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).<br/>Не забудьте сохранить пароль, он вам понадобится.
   1. Нажмите кнопку **Добавить**.

- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    Чтобы добавить пароль: 
    1. Получите список реестров в каталоге: 
    
        ```
        yc iot registry list
		```
		
		Результат:
		```
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct******** | my-registry       |
        +----------------------+-------------------+
        ```    
    1. Добавьте пароль реестру:
    
        ```
        yc iot registry password add --registry-name my-registry --password Passw0rdForRegistry
        ```
		
		Результат:
		```
		registry_id: arenou2oj4ct********
        id: areuu2hgsv6k********
        created_at: "2019-12-16T15:32:46.655139Z"
        ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить пароль реестру, созданному с помощью Terraform:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:
       * `name` — имя реестра.
       * `description` — описание реестра.
       * `passwords` — список паролей реестра для аутентификации с помощью [логина и пароля](../../concepts/authorization.md#log-pass).

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<пароль_1>",
          "<пароль_2>"
        ]
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_registry` в [документации провайдера](../../../terraform/resources/iot_core_registry.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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

      Проверить пароли реестра можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry password list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы добавить пароль реестру, воспользуйтесь методом REST API [addPassword](../../api-ref/Registry/addPassword.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/AddPassword](../../api-ref/grpc/Registry/addPassword.md).

{% endlist %}

### Задать пароль реестру при создании {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Как задать пароль реестру при создании, читайте в разделе [Создание реестра](../registry/registry-create.md).

- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Создайте реестр с паролем:       
    
    ```
    yc iot registry create --name registry-with-pass --password Passw0rdForDevice
    ```
	
	Результат:
	```
	done (1s)
    id: areg96c8loru********
    folder_id: b1g88tflru0e********
    created_at: "2019-12-16T15:34:25.563Z"
    name: registry-with-pass
    status: ACTIVE
    log_group_id: ckghhil3b5o9********
    ```

- Terraform {#tf}

   Как задать пароль реестру при создании, читайте в разделе [Создание реестра](../registry/registry-create.md).

- API {#api}

  Чтобы задать пароль реестру при создании, воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/Registry/create.md).

{% endlist %}

## Получить список паролей реестра {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы просмотреть список паролей реестра:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите получить список паролей реестра.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. На странице **Обзор** перейдите к разделу **Пароли**.

- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы получить список паролей:  
    1. Получите список реестров в каталоге: 
    
        ```
        yc iot registry list
		```
		
		Результат:
		```
        +----------------------+--------------------+
        |          ID          |        NAME        |
        +----------------------+--------------------+
        | areg96c8loru******** | registry-with-pass |
        | arenou2oj4ct******** | my-registry        |
        +----------------------+--------------------+
        ```
    1. Получите список паролей реестра: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```

- API {#api}

  Чтобы получить список паролей реестра, воспользуйтесь методом REST API [listPasswords](../../api-ref/Registry/listPasswords.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListPasswords](../../api-ref/grpc/Registry/listPasswords.md).

{% endlist %}
   
## Удалить пароль реестра {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить пароль реестра:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите удалить пароль реестра.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В строке с нужным паролем нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы удалить пароль:  
    1. Получите список паролей реестра: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
    
        ```
        yc iot registry password delete --registry-name registry-with-pass --password-id are0gffs957e********
        ```
    1. Убедитесь, что пароль действительно удален: 
        
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Результат:
		```
		+----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить пароль реестра, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите значение пароля в блоке `passwords`, во фрагменте с описанием реестра. Чтобы удалить все пароли, удалите блок `passwords` целиком.

      Пример описания реестра в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<пароль_1>",
          "<пароль_2>"
        ]
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_registry` в [документации провайдера](../../../terraform/resources/iot_core_registry.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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

      Проверить пароли реестра можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry password list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы удалить пароль реестра, воспользуйтесь методом REST API [deletePassword](../../api-ref/Registry/deletePassword.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/DeletePassword](../../api-ref/grpc/Registry/deletePassword.md).

{% endlist %}