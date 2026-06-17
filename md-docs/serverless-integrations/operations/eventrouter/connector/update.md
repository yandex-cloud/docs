# Изменить коннектор

Вы можете изменить имя, описание и метки [коннектора](../../../concepts/eventrouter/connector.md), а также включить или выключить защиту от удаления. Тип и параметры источника данных коннектора изменить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите изменить коннектор.
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **Коннекторы**.
  1. В строке с нужным коннектором нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените дополнительные параметры коннектора.
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для обновления параметров коннектора:

      ```bash
      yc serverless eventrouter connector update --help
      ```

  1. Получите список коннекторов:
     
     ```bash
     yc serverless eventrouter connector list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     |          ID          |         NAME          |        BUS ID        |      FOLDER ID       | STATUS  | DELETION PROTECTION |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     | f66g4h59ih2g******** | connector-my-ydb-flow | f66qn4p7uk6p******** | b1g681qpemb4******** | STOPPED | true                |
     | f66g6jcnc5no******** | yds-via-cli           | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     | f66jfhcg1u71******** | mq-via-terraform      | f66qn4p7uk6p******** | b1g681qpemb4******** | RUNNING | false               |
     +----------------------+-----------------------+----------------------+----------------------+---------+---------------------+
     ```
  1. Укажите в команде параметры, которые необходимо изменить, например имя коннектора:

      ```bash
      yc serverless eventrouter connector update \
        --name <имя_коннектора> \
        --new-name <новое_имя_коннектора>
      ```

      Результат:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      description: consumer-one
      labels:
        owner: admin
        version: beta
      source:
        data_stream:
          database: /ru-central1/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: STOPPED
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить коннектор:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием ресурса `yandex_serverless_eventrouter_connector`.

      Пример описания коннектора в конфигурационном файле Terraform:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
        ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_serverless_eventrouter_connector` в [документации провайдера](../../../../terraform/resources/serverless_eventrouter_connector.md).

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
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы изменить коннектор, воспользуйтесь методом REST API [Update](../../../eventrouter/api-ref/Connector/update.md) для ресурса [Connector](../../../eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Update](../../../eventrouter/api-ref/grpc/Connector/update.md).

{% endlist %}