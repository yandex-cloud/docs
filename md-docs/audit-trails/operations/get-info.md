# Получить информацию о трейле

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [трейл](../concepts/trail.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Выберите трейл. На странице **{{ ui-key.yacloud.audit-trails.label_trail }}** отобразится подробная информация о трейле.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [трейле](../concepts/trail.md):

     ```bash
     yc audit-trails trail get --help
     ```

  1. Получите список трейлов:
     
     ```bash
     yc audit-trails trail list
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+--------+-------------------+
     |          ID          |     NAME     | STATUS |      FILTERS      |
     +----------------------+--------------+--------+-------------------+
     | cnp82sb0phnm******** | trailfromapi | ACTIVE | storage compute   |
     |                      |              |        | management.events |
     | cnp8v52idttr******** | tf-trail     | ACTIVE | storage compute   |
     |                      |              |        | mdb.postgresql    |
     | cnpnkcubr529******** | test-2       | ACTIVE | compute           |
     +----------------------+--------------+--------+-------------------+
     ```

  1. Получите подробную информацию о трейле, указав его имя или идентификатор:

     ```bash
     yc audit-trails trail get <имя_или_идентификатор_трейла>
     ```

     Результат:

     ```text
     id: cnp82sb0phnm********
     folder_id: b1geoelk7fld********
     created_at: "2025-02-20T07:28:00.815Z"
     updated_at: "2025-02-20T07:28:00.815Z"
     name: trailfromapi
     description: trailfromapi
     destination:
       object_storage:
         bucket_id: rsample-logs-bucket
     service_account_id: ajenfbssm9o5********
     status: ACTIVE
     cloud_id: b1gia87mbaom********
     filtering_policy:
       management_events_filter:
         resource_scopes:
           - id: b1geoelk7fld********
             type: resource-manager.folder
       data_events_filters:
         - service: mdb.postgresql
           excluded_events:
             event_types:
               - yandex.cloud.audit.mdb.postgresql.CreateDatabase
               - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
           resource_scopes:
             - id: b1gia87mbaom********
               type: resource-manager.cloud
             - id: b1geoelk7fld********
               type: resource-manager.folder
         - service: storage
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
             - id: b1g0g14rq0mv********
               type: resource-manager.folder
         - service: compute
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
     ```

- {{ TF }}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [трейле](../concepts/trail.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_audit_trails_trail" "my-trail" {
        trail_id = "<идентификатор_трейла>"
      }

      output "my-trail-status" {
        value = data.yandex_audit_trails_trail.my-trail.status
      }
      ```

      Где:

      * `data "yandex_audit_trails_trail"` — описание трейла в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "my-trail-status"` — выходная переменная, которая содержит информацию о текущем статусе трейла (`status`):
         * `value` — возвращаемое значение.

     Вместо `status` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_audit_trails_trail` см. в [документации провайдера]({{ tf-provider-datasources-link }}/audit_trails_trail).

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
      my-trail-status = ACTIVE
      ```

- API {#api}

  Чтобы получить подробную информацию о [трейле](../concepts/trail.md), воспользуйтесь методом REST API [get](../api-ref/Trail/get.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

{% endlist %}