# Удалить подсеть

{% note alert %}

Перед удалением [подсети](../concepts/network.md#subnet) необходимо отключить от нее все ресурсы.
После удаления подсеть невозможно восстановить.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить подсеть.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной подсети и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления подсети:

      ```
      yc vpc subnet delete --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

      ```
      yc vpc subnet list
      ```

      Результат:

      ```
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloe******** | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной подсети.
  1. Удалите подсеть из каталога по умолчанию:

      ```
      yc vpc subnet delete test-subnet-1
      ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Чтобы удалить подсеть, созданную с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием подсети.

     {% cut "Пример описания подсети в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_vpc_subnet" "lab-subnet-a" {
       name           = "subnet-1"
	   description    = "My first subnet"
       v4_cidr_blocks = ["10.2.0.0/16"]
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.lab-net.id}"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

     ```
     yc vpc subnet list
     ```

- API {#api}

   Чтобы удалить [подсеть](../concepts/network.md#subnet), воспользуйтесь методом REST API [delete](../api-ref/Subnet/delete.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Delete](../api-ref/grpc/Subnet/delete.md) и передайте в запросе идентификатор удаляемой подсети в параметре `subnetId`.

   Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../api-ref/Subnet/list.md) для ресурса [Subnet](../api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

   О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Примеры {#examples}

### Удаление подсети из указанного каталога {#from-folder}

{% list tabs group=instructions %}

- CLI {#cli}

  Удалите подсеть из другого каталога:

  ```
  yc vpc subnet delete test-subnet-2 --folder-id b1gnbfd11bq5********
  ```

  Где `--folder-id` – идентификатор каталога.

  ```
  yc vpc subnet delete test-subnet-2 --folder-name test-folder
  ```

  Где `--folder-name` – имя каталога.

  Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью параметров `--id` и `--name`:

  ```
  yc vpc subnet delete --id enpavfmgapum********
  ```
  
  ```
  yc vpc subnet delete --name test-network-1
  ```

{% endlist %}