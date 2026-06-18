# Получить информацию о расписании, по которому создаются снимки дисков

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится [расписание](../../concepts/snapshot-schedule.md).
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **Снимки дисков**.
  1. Перейдите на вкладку **Расписания снимков**.
  1. Выберите нужное расписание.
  1. На странице **Обзор** отобразится подробная информация о расписании снимков дисков.

- CLI

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о расписании:

      ```bash
      yc compute snapshot-schedule get --help
      ```

  1. Получите информацию о расписании, указав его имя или идентификатор:

      ```bash
      yc compute snapshot-schedule get <имя_расписания>
      ```

      Результат:

      ```text
      id: fd8cc5qd25cp********
      folder_id: b1gmit33ngp3********
      created_at: "2023-10-30T14:53:33Z"
      name: schedule-1
      status: ACTIVE
      schedule_policy:
        start_at: "2023-10-30T14:00:51Z"
        expression: 0 10 */1 * *
      snapshot_count: "2"
      snapshot_spec: {}
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [расписании снимков дисков](../../concepts/snapshot-schedule.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_snapshot_schedule" "snapshot_schedule" {
        snapshot_schedule_id = "<идентификатор_расписания>"
      }

      output "snapshot_schedule" {
        value = data.yandex_compute_snapshot_schedule.snapshot_schedule.status
      }
      ```

      Где:

      * `data "yandex_compute_snapshot_schedule"` — описание расписания снимков дисков в качестве источника данных:
        * `snapshot_schedule_id` — идентификатор расписания снимков дисков.
      * `output "snapshot_schedule"` — выходная переменная, которая содержит информацию о расписании снимков дисков:
        * `value` — возвращаемое значение.

      Вместо `status` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_snapshot_schedule` читайте в [документации провайдера](../../../terraform/data-sources/compute_snapshot_schedule.md).

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

      ```text
      snapshot_schedule = "inactive"
      ```

- API {#api}

  Чтобы получить подробную информацию о [расписании снимков дисков](../../concepts/snapshot-schedule.md), воспользуйтесь методом REST API [get](../../api-ref/SnapshotSchedule/get.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md), или вызовом gRPC API [SnapshotScheduleService/Get](../../api-ref/grpc/SnapshotSchedule/get.md).

{% endlist %}