# Удаление инстанса {{ GL }}

Если для инстанса включена защита от удаления, сначала [снимите](instance-update.md) ее, а затем удалите инстанс.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить [инстанс {{ GL }}](../../concepts/index.md#instance).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного инстанса и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить инстанс {{ GL }}, выполните команду:

  ```bash
  {{ yc-gl }} instance delete <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (3m14s)
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/delete.md).

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить инстанс {{ GL }}, созданный с помощью {{ TF }}:

  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ресурса `yandex_gitlab_instance`.

     Пример описания инстанса {{ GL }} в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_gitlab_instance" "my_gitlab_instance" {
       name                      = "gl-instance"
       resource_preset_id        = "s2.micro"
       disk_size                 = 100
       admin_login               = "gitlab-user"
       admin_email               = "gitlab-user@example.com"
       domain                    = "gitlab-terraform.gitlab.yandexcloud.net"
       subnet_id                 = "e9bsdv4iunrv********"
       approval_rules_id         = "BASIC"
       backup_retain_period_days = 7
       deletion_protection       = true
     }
     ```

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  {{ yc-gl }} instance list
  ```

- API {#api}

  Воспользуйтесь методом REST API [Delete](../../api-ref/Instance/delete.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Delete](../../api-ref/grpc/Instance/delete.md).

{% endlist %}

Если вы удалили инстанс {{ GL }}, но хотите его восстановить, обратитесь в [техническую поддержку]({{ link-console-support }}). Для удаленного инстанса автоматически создается [резервная копия](../../concepts/backup.md), которая хранится в течение двух недель.