# Изменить облачную сеть

После создания облачной сети вы можете изменить ее имя, описание и метки.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется изменить [облачную сеть](../concepts/network.md).
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной подсети и выберите **Редактировать**.
  1. Внесите нужные изменения.
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров [облачной сети](../concepts/network.md):

      ```bash
      yc vpc network update --help
      ```

  1. Получите список всех сетей в каталоге по умолчанию:

      ```bash
      yc vpc network list
      ```

      Результат:
      ```text
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapum******** | test-network-1 |
      | enplom7a98s1******** | default        |
      +----------------------+----------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Измените параметры облачной сети, указав ее имя:

      ```bash
      yc vpc network update enpavfmgapum******** --new-name test-network-renamed
      ```

      Результат:
      ```text
      id: enpavfmgapum********
      folder_id: b1g6ci08ma55********
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```
     
      Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью параметров `--id` и `--name`:

      ```bash
      yc vpc network update \
        --id enpavfmgapum******** \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

      ```bash
      yc vpc network update \
        --name test-network-1 \
        --new-name test-network-renamed \
        --labels new_label=test_label
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием [облачной сети](../concepts/network.md):

     ```hcl
     # Пример описания облачной сети
     resource "yandex_vpc_network" "default" {
       name        = "network-1"
       description = "My first network"
       labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_network` в Terraform см. в [документации провайдера](../../terraform/resources/vpc_network.md).

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

     Проверить изменение облачной сети можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc network get <имя_сети>
     ```

- API {#api}

  Чтобы изменить [облачную сеть](../concepts/network.md), воспользуйтесь методом REST API [update](../api-ref/Network/update.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Update](../api-ref/grpc/Network/update.md) и передайте в запросе:

  * Идентификатор изменяемой облачной сети в параметре `networkId`.

    Чтобы узнать идентификатор облачной сети, воспользуйтесь методом REST API [list](../api-ref/Network/list.md) для ресурса [Network](../api-ref/Network/index.md) или вызовом gRPC API [NetworkService/List](../api-ref/grpc/Network/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

    О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

  * Новые настройки сети по необходимости:

    * имя в параметре `name`;
    * описание в параметре `description`;
    * метки сети в параметре `labels`.

  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Примеры {#examples}

### Изменение облачной сети с использованием имени {#using-name}

Можно изменять облачную сеть, используя имя вместо идентификатора:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc vpc network update test-network-1 \
    --new-name test-network-renamed \
    --labels new_label=test_label
  ```

  Результат:
  ```text
  id: enpavfmgapum********
  folder_id: b1g6ci08ma55********
  created_at: "2018-10-23T14:05:32Z"
  name: test-network-renamed
  description: My first network
  labels:
    new_label: test_label
  ```

{% endlist %}