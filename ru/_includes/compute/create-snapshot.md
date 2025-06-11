{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. В строке с диском нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
  1. Введите имя снимка. Требования к имени:

      {% include [name-format](../name-format.md) %}

  1. Если требуется, укажите произвольное текстовое описание снимка.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команд CLI для создания снимков:

      ```bash
      yc compute snapshot create --help
      ```

  1. Выберите диск, снимок которого необходимо создать. Получить список дисков в каталоге по умолчанию можно с помощью команды:

      {% include [compute-disk-list](../compute/disk-list.md) %}

  1. Создайте снимок в каталоге по умолчанию:

      ```bash
      yc compute snapshot create \
        --name first-snapshot \
        --description "my first snapshot via CLI" \
        --disk-id fhm4aq4hvq5g********
      ```

      В результате будет создан снимок диска с именем `first-snapshot` и описанием `my first snapshot via CLI`.

      Требования к имени снимка:

      {% include [name-format](../name-format.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_snapshot`.

     Пример структуры конфигурационного файла:
     
     ```hcl
     resource "yandex_compute_snapshot" "snapshot-1" {
       name           = "disk-snapshot"
       source_disk_id = "<идентификатор_диска>"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список дисков с помощью метода REST API [list](../../compute/api-ref/Disk/list.md) для ресурса [Disk](../../compute/api-ref/Disk/index.md) или вызова gRPC API [DiskService/List](../../compute/api-ref/grpc/Disk/list.md).
  1. Создайте снимок с помощью метода REST API [create](../../compute/api-ref/Snapshot/create.md) для ресурса [Snapshot](../../compute/api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/Create](../../compute/api-ref/grpc/Snapshot/create.md).

{% endlist %}