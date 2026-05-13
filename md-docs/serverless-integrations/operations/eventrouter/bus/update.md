# Изменить шину

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите изменить [шину](../../../concepts/eventrouter/bus.md).
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. В строке с нужной [шиной](../../../concepts/eventrouter/bus.md) нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените параметры шины.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров [шины](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus update --help
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
  1. Укажите в команде параметры, которые необходимо изменить, например имя шины:

      ```bash
      yc serverless eventrouter bus update \
        --name <имя_шины> \
        --new-name <новое_имя_шины>
      ```

      Результат:

      ```text
      id: f66aevm4ithv********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-13T12:36:59.497985Z"
      name: my-bus-43
      description: this is my bus
      labels:
        owner: admin
      deletion_protection: true
      status: ACTIVE
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить [шину](../../../concepts/eventrouter/bus.md):

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием ресурса `yandex_serverless_eventrouter_bus`.

      Пример описания шины в конфигурационном файле Terraform:

      ```hcl
      resource "yandex_serverless_eventrouter_bus" "example_bus" {
        name                = "my-bus"
        description         = "this is my bus"
        deletion_protection = true

        labels = {
          key1 = "value1"
          key2 = "value2"
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_bus` см. в [документации провайдера](../../../../terraform/resources/serverless_eventrouter_bus.md).

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

      Terraform создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../../cli/index.md):

      ```bash
      yc serverless eventrouter bus list
      ```

- API {#api}

  Чтобы изменить [шину](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [Update](../../../eventrouter/api-ref/Bus/update.md) для ресурса [Bus](../../../eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [Bus/Update](../../../eventrouter/api-ref/grpc/Bus/update.md).

{% endlist %}