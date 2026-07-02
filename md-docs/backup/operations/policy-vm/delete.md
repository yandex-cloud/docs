[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Backup](../../index.md) > [Пошаговые инструкции](../index.md) > Политики резервного копирования > Удалить политику

# Удалить политику резервного копирования

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить [политику резервного копирования](../../concepts/policy.md).
  1. Перейдите в сервис **Cloud Backup**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **Политики копирования**.
  1. Напротив политики резервного копирования, которую нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**. 
  1. Подтвердите удаление политики резервного копирования.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для удаления [политики резервного копирования](../../concepts/policy.md):

     ```bash
     yc backup policy delete --help
     ```

  1. Узнайте идентификатор политики резервного копирования, которую нужно удалить:

     ```bash
     yc backup policy list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     |          ID          |      FOLDER ID       |  NAME   | ENABLED |     CREATED AT      |     UPDATED AT      |
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     | abc7n3wln123******** | ghi681qpe789******** | policy1 | true    | 2023-07-03 09:12:02 | 2023-07-03 09:12:43 |
     | deflqbiwc456******** | ghi681qpe789******** | policy2 | true    | 2023-07-07 14:58:23 | 2023-07-07 14:58:23 |
     +----------------------+----------------------+---------+---------+---------------------+---------------------+
     ```

  1. Удалите политику резервного копирования, указав ее идентификатор:

     ```bash
     yc backup policy delete <идентификатор_политики_резервного_копирования>
     ```

     Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/delete.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить [политику резервного копирования](../../concepts/policy.md), созданную с помощью Terraform:
  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием ресурса `yandex_backup_policy`:

     {% cut "Пример описания ресурса `yandex_backup_policy` в конфигурации Terraform" %}

     ```hcl
     resource "yandex_backup_policy" "my_policy" {
         archive_name                      = "[<имя_ВМ_или_сервера_BareMetal>]-[<идентификатор_плана>]-[<уникальный_идентификатор>]a"
         cbt                               = "USE_IF_ENABLED"
         compression                       = "NORMAL"
         fast_backup_enabled               = true
         format                            = "AUTO"
         multi_volume_snapshotting_enabled = true
         name                              = "<имя_политики_резервного_копирования>"
         performance_window_enabled        = true
         silent_mode_enabled               = true
         splitting_bytes                   = "9223372036854775807"
         vss_provider                      = "NATIVE"

         reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }

         retention {
             after_backup = false

             rules {
                 max_age       = "365d"
                 repeat_period = []
             }
         }

         scheduling {
             enabled              = false
             max_parallel_backups = 0
             random_max_delay     = "30m"
             scheme               = "ALWAYS_INCREMENTAL"
             weekly_backup_day    = "MONDAY"

             backup_sets {
                 execute_by_time {
                     type                      = "MONTHLY"
                     include_last_day_of_month = true
                     monthdays                 = []
                     months                    = [1,2,3,4,5,6,7,8,9,10,11,12]
                     repeat_at                 = ["04:10"]
                     repeat_every              = "30m"
                     weekdays                  = []
                 }
             }
         }

         vm_snapshot_reattempts {
             enabled      = true
             interval     = "1m"
             max_attempts = 10
         }
     } 
     ```

     {% endcut %}

     Подробнее о параметрах ресурса `yandex_backup_policy` в [документации провайдера](../../../terraform/resources/backup_policy.md).
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

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc backup policy list
     ```

- API {#api}

  Чтобы удалить [политику резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [delete](../../backup/api-ref/Policy/delete.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Delete](../../backup/api-ref/grpc/Policy/delete.md).

{% endlist %}