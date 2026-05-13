# Получить информацию о политике резервного копирования

Просмотр информации о политиках доступен после [активации](../../concepts/index.md#providers) сервиса Cloud Backup.

После активации автоматически создаются следующие политики резервного копирования:
* `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
* `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
* `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [политика резервного копирования](../../concepts/policy.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Backup**.
  1. На панели слева выберите ![policies](../../../_assets/console-icons/calendar.svg) **Политики копирования**.
  1. Выберите политику резервного копирования для просмотра.
  1. На странице **Обзор** отобразится подробная информация о политике.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список [политик резервного копирования](../../concepts/policy.md), размещенных в каталоге по умолчанию:

     ```bash
     yc backup policy list
     ```  

     Результат:

     ```bash
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     |          ID          |      FOLDER ID       |      NAME       | ENABLED |     CREATED AT      |     UPDATED AT      |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     | cdgp2n2s73lg******** | b1gsm0k26v1l******** | Default daily   | true    | 2023-07-20 13:55:14 | 2024-08-15 08:27:41 |
     | cdguolnopexf******** | b1gsm0k26v1l******** | Default weekly  | true    | 2023-07-20 13:55:14 | 2023-09-05 16:24:05 |
     | cdgklelzc4pi******** | b1gsm0k26v1l******** | Default monthly | true    | 2023-07-20 13:55:15 | 2024-09-02 08:40:18 |
     +----------------------+----------------------+-----------------+---------+---------------------+---------------------+
     ```
  
     Сохраните идентификатор (`ID`) или имя (`NAME`) политики, информацию о который вы хотите получить.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для получения информации о политике резервного копирования:

     ```bash
     yc backup policy get --help
     ```

  1. Получите информацию о политике резервного копирования, указав ее имя или идентификатор:

     ```bash
     yc backup policy get <идентификатор_политики_резервного_копирования>
     ```

     Результат:

     ```bash
     id: cdgvykqerzzc********
     name: Default weekly
     created_at: "2023-10-09T20:23:46.980915356Z"
     updated_at: "2023-10-09T20:23:46.978341789Z"
     enabled: true
     settings:
       compression: NORMAL
       format: AUTO
       multi_volume_snapshotting_enabled: true
       preserve_file_security_settings: true
       reattempts:
         enabled: true
         interval:
           type: SECONDS
           count: "30"
         max_attempts: "30"
     ...
     ```

  Подробнее о команде читайте в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/get.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы получить информацию о [политике резервного копирования](../../concepts/policy.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_backup_policy" "my_policy" {
        policy_id = "<идентификатор_политики>"
      }

      output "my_policy_schedule" {
        value = data.yandex_backup_policy.my_policy.scheduling
      }
      ```

      Где:

      * `data "yandex_backup_policy"` — описание политики резервного копирования в качестве источника данных:
        * `policy_id` — идентификатор политики резервного копирования. Вы также можете использовать параметр `name` — имя политики резервного копирования.
      * `output "my_policy_schedule"` — выходная переменная, которая содержит информацию о расписании политики резервного копирования:
        * `value` — возвращаемое значение.

      Вместо `scheduling` вы можете выбрать любой другой [параметр политики](../../../terraform/resources/backup_policy.md) для получения информации.

      Более подробно о параметрах источника данных `yandex_backup_policy` см. в [документации провайдера](../../../terraform/data-sources/backup_policy.md).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      my_policy_name = toset([
        {
          "backup_sets" = toset([
            {
              "execute_by_interval" = 0
              "execute_by_time" = toset([
                {
                  "include_last_day_of_month" = false
                  "monthdays" = tolist([])
                  "months" = tolist([])
                  "repeat_at" = tolist([
                    "01:45",
      ...
      "enabled" = true
      "max_parallel_backups" = 2
      "random_max_delay" = "30m"
      "scheme" = "ALWAYS_INCREMENTAL"
      "weekly_backup_day" = "MONDAY"
      ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [политике резервного копирования](../../concepts/policy.md), воспользуйтесь методом REST API [get](../../backup/api-ref/Policy/get.md) для ресурса [Policy](../../backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Get](../../backup/api-ref/grpc/Policy/get.md).

{% endlist %}