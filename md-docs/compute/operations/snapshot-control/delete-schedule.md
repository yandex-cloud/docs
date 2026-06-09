# Удалить расписание, по которому создаются снимки дисков

Чтобы удалить [расписание](../../concepts/snapshot-schedule.md) [снимков дисков](../../concepts/snapshot.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится расписание.
  1. Перейдите в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.snapshots-schedules.label_title }}**.
  1. Напротив расписания, которое нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление расписания.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команд [CLI](../../../cli/index.md) для работы с расписаниями:

     ```bash
     yc compute snapshot-schedule --help
     yc compute snapshot-schedule delete --help
     ```

  1. Получите список расписаний в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute snapshot-schedule list --format yaml
     ```

     Результат:

     ```text
     - id: fc852cvb1ipd5********
       folder_id: e1ea8s8l71li********
       created_at: "2022-09-28T13:25:02Z"
     ...
         expression: 10 19 ? * *
       snapshot_count: "7"
       snapshot_spec: {}
     ```

  1. Удалите выбранное расписание:

     ```bash
     yc compute snapshot-schedule delete <имя_или_идентификатор_расписания>
     ```

     Результат:

     ```text
     done (5s)
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием расписания:

     {% cut "Пример описания расписания в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_compute_snapshot_schedule" "default" {
       name = "my-name"

       schedule_policy {
         expression = "0 0 * * *"
       }

       snapshot_count = 1

       snapshot_spec {
         description = "snapshot-description"
         labels = {
           snapshot-label = "my-snapshot-label-value"
         }
       }

       disk_ids = ["test_disk_id", "another_test_disk_id"]
     }
     ```

     {% endcut %}

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

  Проверить удаление расписания можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc compute snapshot-schedule list
  ```

- API {#api}

  1. Получите список расписаний с помощью метода REST API [list](../../api-ref/SnapshotSchedule/list.md) для ресурса [SnapshotSchedule](../../api-ref/SnapshotSchedule/index.md) или вызова gRPC API [SnapshotScheduleService/List](../../api-ref/grpc/SnapshotSchedule/list.md).
  1. Удалите расписание снимков с помощью метода REST API [delete](../../api-ref/SnapshotSchedule/delete.md) для ресурса `SnapshotSchedule` или вызова gRPC API [SnapshotScheduleService/Delete](../../api-ref/grpc/SnapshotSchedule/delete.md).

{% endlist %}

Все операции по созданию и удалению снимков, начатые до удаления расписания, будут доведены до конца.