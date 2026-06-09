# Получить информацию о группе бэкендов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится [группа бэкендов](../concepts/backend-group.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Выберите группу бэкендов.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о группе.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о [группе бэкендов](../concepts/backend-group.md):

      ```bash
      yc alb backend-group get --help
      ```

  1. Получите информацию о группе бэкендов, указав ее имя или идентификатор:

      ```bash
      yc alb backend-group get <имя_группы_бэкендов>
      ```

      Результат:

      ```text
      id: ds7maho6c4or********
      name: alb-bg
      folder_id: b1geoelk7fld********
      http:
        backends:
          - name: backend-1
            backend_weight: "1"
            port: "80"
            target_groups:
              target_group_ids:
                - ds7cjrs15ero********
            healthchecks:
              - timeout: 10s
                interval: 2s
                healthcheck_port: "80"
                http:
                  path: /
      created_at: "2023-10-24T12:22:20.870326850Z"
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [группе бэкендов](../concepts/backend-group.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_alb_backend_group" "my_bg" {
        backend_group_id = "<идентификатор_группы_бэкендов>"
      }

      output "backend_group" {
        value = data.yandex_alb_backend_group.my_bg.http_backend
      }
      ```

      Где:
      * `data "yandex_alb_backend_group"` — описание группы бэкендов в качестве источника данных:
        * `backend_group_id` — идентификатор группы бэкендов.
      * `output "backend_group"` — выходная переменная, которая содержит информацию о подключенном HTTP бэкенде:
        * `value` — возвращаемое значение.

      Вместо `http_backend` вы можете выбрать любой другой параметр для получения информации. Более подробную информацию о параметрах источника данных `yandex_alb_backend_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/alb_backend_group).

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
      backend_group = tolist([
        {
          "healthcheck" = tolist([
            {
              "grpc_healthcheck" = tolist([])
              "healthcheck_port" = 80
              "healthy_threshold" = 1
              "http_healthcheck" = tolist([
                {
                  "host" = ""
                  "http2" = false
                  "path" = "/health"
                },
              ])
              "interval" = "1s"
              "interval_jitter_percent" = 0
              "stream_healthcheck" = tolist([])
              "timeout" = "1s"
              "unhealthy_threshold" = 1
            },
            ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [группе бэкендов](../concepts/backend-group.md), воспользуйтесь методом REST API [get](../api-ref/BackendGroup/get.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Get](../api-ref/grpc/BackendGroup/get.md).

{% endlist %}