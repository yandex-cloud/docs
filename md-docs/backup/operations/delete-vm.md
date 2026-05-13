# Удалить виртуальную машину из Cloud Backup

При удалении виртуальной машины из Cloud Backup, она остается в Yandex Compute Cloud и продолжает функционировать. [Удаление](../../compute/operations/vm-control/vm-delete.md) ВМ из Compute Cloud выполняется отдельно.

{% note info %}

Если вы удаляете ВМ из Compute Cloud с помощью консоли управления, она также удалится из Cloud Backup. При использовании CLI, Terraform или запроса к API, ВМ останется доступна в Cloud Backup.

{% endnote %}

Если после удаления ВМ из Cloud Backup вы захотите подключить ее к сервису заново, воспользуйтесь инструкциями:

* [Подключить виртуальную машину на Linux](connect-vm-linux.md)
* [Подключить виртуальную машину на Windows](connect-vm-windows.md)

Чтобы удалить ВМ из Cloud Backup:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно удалить ВМ.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Backup**.
  1. Напротив ВМ, которую вы хотите удалить, нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления ВМ из Cloud Backup:

      ```bash
      yc backup vm delete --help
      ```

  1. Узнайте идентификатор ВМ, которую нужно удалить:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      
      ```text
      +----------------------+---------+---------------+---------+--------------+-------------+
      |          ID          |  NAME   |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
      +----------------------+---------+---------------+---------+--------------+-------------+
      | jklp0o9i8012******** | my-vm-1 | ru-central1-b | RUNNING | 51.250.**.** | 192.168.*.* |
      | mnoa5s6d8345******** | my-vm-2 | ru-central1-b | RUNNING | 84.201.**.** | 192.168.*.* |
      +----------------------+---------+---------------+---------+--------------+-------------+
      ```

  1. Удалите ВМ, указав ее идентификатор:

      ```bash
      yc backup vm delete <идентификатор_ВМ>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../backup/api-ref/Resource/delete.md) для ресурса [Resource](../backup/api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Delete](../backup/api-ref/grpc/Resource/delete.md).

{% endlist %}