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
        --disk-id fhm4aq4hvq5g******** \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI>
      ```

      Где:
      * `--name` — имя создаваемого снимка. Требования к имени:

          {% include [name-format](../name-format.md) %}

      * `--description` — описание создаваемого снимка. Необязательный параметр.
      * `--disk-id` — идентификатор диска, для которого вы создаете снимок. Вместо идентификатора вы можете передать в команду имя диска в параметре `--disk-name`.
      * `--hardware-generation-id` — [поколение](../../compute/concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемое за снимком. Необязательный параметр. Возможные значения:

          {% include [generation-types-cli](generation-types-cli.md) %}

          Если параметр не задан, за снимком будет закреплено то же поколение оборудования, которое закреплено за диском-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.


          Если за диском-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого снимка для параметра `--hardware-features` будет задано то же значение, что и у диска-источника.

      Результат:

      ```text
      done (19s)
      id: fd81qi89ldop********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T09:56:04Z"
      name: first-snapshot
      description: my first snapshot via CLI
      storage_size: "3116367872"
      disk_size: "21474836480"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      source_disk_id: epd8lmcncidv********
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_snapshot`.

     Пример структуры конфигурационного файла:
     
     ```hcl
     resource "yandex_compute_snapshot" "snapshot-1" {
       name           = "disk-snapshot"
       source_disk_id = "<идентификатор_диска>"
       hardware_generation {
         legacy_features {
           pci_topology = "<топология_PCI>"
         }
       }
     }
     ```

      Где:
      * `name` — имя создаваемого снимка. Требования к имени:

          {% include [name-format](../name-format.md) %}

      * `source_disk_id` — идентификатор диска, для которого вы создаете снимок.
      * `hardware_generation` — блок настроек с описанием [поколения](../../compute/concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемого за снимком. Необязательный параметр. Включает в себя следующие блоки настроек:

          {% include [generation-types-tf](generation-types-tf.md) %}

          {% note info %}

          Если блок `hardware_generation` не задан, за снимком будет закреплено то же поколение оборудования, которое закреплено за диском-источником.

          {% endnote %}

     Более подробную информацию о ресурсе `yandex_compute_snapshot` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_snapshot).

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
  1. Создайте снимок с помощью метода REST API [create](../../compute/api-ref/Snapshot/create.md) для ресурса [Snapshot](../../compute/api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/Create](../../compute/api-ref/grpc/Snapshot/create.md). В запросе укажите идентификатор диска-источника, а также при необходимости задайте нужное [поколение](../../compute/concepts/hardware-generations.md#configurations) виртуализированного оборудования в [объекте `hardwareGeneration`](../../compute/api-ref/Snapshot/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../compute/api-ref/grpc/Snapshot/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}