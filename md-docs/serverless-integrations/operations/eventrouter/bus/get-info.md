# Получить информацию о шине

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [шина](../../../concepts/eventrouter/bus.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите шину. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о шине.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [шине](../../../concepts/eventrouter/bus.md):

     ```bash
     yc serverless eventrouter bus get --help
     ```

  1. Получите список шин:
     
     ```bash
     yc serverless eventrouter bus list
     ```
     
     Результат:
     
     ```text
     +----------------------+------------------+----------------------+--------+---------------------+
     |          ID          |       NAME       |      FOLDER ID       | STATUS | DELETION PROTECTION |
     +----------------------+------------------+----------------------+--------+---------------------+
     | f6676a9ti657******** | my-new-bus-17    | b1g681qpemb4******** | ACTIVE | false               |
     | f66aevm4ithv******** | my-favourite-bus | b1g681qpemb4******** | ACTIVE | true                |
     | f66m2q222n92******** | my-bus-42        | b1g681qpemb4******** | ACTIVE | false               |
     +----------------------+------------------+----------------------+--------+---------------------+
     ```

  1. Получите подробную информацию о шине, указав ее имя или идентификатор:

     ```bash
     yc serverless eventrouter bus get <идентификатор_шины>
     ```

     Результат:

     ```text
     id: f66ngs9760f1********
     folder_id: b1go3el0d8fs********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-18T13:23:45.126870Z"
     name: my-bus
     status: ACTIVE
     ```

- {{ TF }}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_serverless_eventrouter_bus" "my-bus" {
        bus_id = "<идентификатор_шины>"
      }

      output "bus-folder" {
        value = data.yandex_serverless_eventrouter_bus.my-bus.folder_id
      }
      ```

      Где:

      * `data "yandex_serverless_eventrouter_bus"` — описание шины в качестве источника данных:
         * `resource_id` — идентификатор шины.
      * `output "bus-folder"` — выходная переменная, которая содержит информацию о каталоге, в котором находится шина (`folder_id`):
         * `value` — возвращаемое значение.

     Вместо `folder_id` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_serverless_eventrouter_bus` см. в [документации провайдера]({{ tf-provider-datasources-link }}/serverless_eventrouter_bus).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      bus-folder = "b1geoelk7fld********"
      ```

- API {#api}

  Чтобы получить подробную информацию о [шине](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [get](../../../eventrouter/api-ref/Bus/get.md) для ресурса [Bus](../../../eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/Get](../../../eventrouter/api-ref/grpc/Bus/get.md).

{% endlist %}