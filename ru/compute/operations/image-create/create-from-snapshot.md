---
title: Как создать образ из снимка диска в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать образ из снимка диска.
---

# Создать образ из снимка диска

Чтобы создать образ из [снимка](../../concepts/snapshot.md) диска:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать образ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.snapshots_81jHX }}**.
  1. В строке с нужным снимком нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.snapshots.list.button_action-image }}**.
  1. Введите имя образа. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. При необходимости укажите произвольное текстовое описание образа.
  1. Разверните блок **{{ ui-key.yacloud.compute.section_additional_7yvYG }}**.
  1. (Опционально) В поле **{{ ui-key.yacloud.compute.hardware-generation_1iEpT }}** выберите нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, которое будет закреплено за создаваемым образом:

      {% include [generation-types-console](../../../_includes/compute/generation-types-console.md) %}

      Если вы не зададите поколение оборудования, по умолчанию за создаваемым образом будет закреплено то же поколение, что и за снимком-источником.
  1. (Опционально) Чтобы создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment), включите опцию **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания образа:

      ```
      yc compute image create --help
      ```
  1. Получите список снимков в каталоге по умолчанию:

      {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного снимка.
  1. Создайте образ в каталоге по умолчанию:

      ```
      yc compute image create \
        --name <имя_создаваемого_образа> \
        --source-snapshot-name <имя_снимка-источника> \
        --pooled \
        --hardware-generation-id <поколение_оборудования> \
        --hardware-features pci_topology=<топология_PCI>
      ```

      Где:
      * `--name` — имя создаваемого образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--source-snapshot-name` — имя снимка-источника. Вместо имени вы можете передать в команду идентификатор снимка-источника в параметре `--source-snapshot-id`.
      * `--pooled` — параметр, позволяющий создать [оптимизированный образ](../../concepts/image.md#images-optimized-for-deployment). Необязательный параметр.
      * `--hardware-generation-id` — [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемое за образом. Необязательный параметр. Возможные значения:

          {% include [generation-types-cli](../../../_includes/compute/generation-types-cli.md) %}

          Если параметр не задан, за созданным образом будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.
      * `--hardware-features` — дополнительные настройки для поколения `Gen 1`. Необязательный параметр. Возможные значения:

          * `pci_topology=v1` — выбор топологии `PCI_TOPOLOGY_V1`.
          * `pci_topology=v2` — выбор топологии `PCI_TOPOLOGY_V2`.


          Если за снимком-источником закреплено поколение `Gen 1`, по умолчанию у создаваемого образа для параметра `--hardware-features` будет задано то же значение, что и у снимка-источника.

      Результат:

      ```text
      done (5s)
      id: fd8lt5sskh12********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-23T19:26:46Z"
      name: my-first-image
      storage_size: "3116367872"
      min_disk_size: "21474836480"
      product_ids:
        - f2evcrm9ti79********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_compute_image" "image-1" {
       name            = "<имя_образа>"
       source_snapshot = "<идентификатор_снимка-источника>"
       hardware_generation {
         legacy_features {
           pci_topology = "<топология_PCI>"
         }
       }
     }
     ```

      Где:
      * `name` — имя создаваемого образа. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `source_snapshot` — идентификатор снимка-источника.
      * `hardware_generation` — блок настроек с описанием [поколения](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования, закрепляемого за образом. Необязательный параметр. Включает в себя следующие блоки настроек:

          {% include [generation-types-tf](../../../_includes/compute/generation-types-tf.md) %}

          {% note info %}

          Если блок `hardware_generation` не задан, за созданным образом будет закреплено то же поколение оборудования, которое закреплено за снимком-источником.

          {% endnote %}

     Более подробную информацию о ресурсе `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_image).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  1. Получите список снимков с помощью метода REST API [list](../../api-ref/Snapshot/list.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызова gRPC API [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md).
  1. Создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Snapshot/index.md) или вызова gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md). В запросе укажите идентификатор снимка-источника, а также при необходимости задайте нужное [поколение](../../concepts/hardware-generations.md#configurations) виртуализированного оборудования в [объекте `hardwareGeneration`](../../api-ref/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) ([`hardware_generation`](../../api-ref/grpc/Image/create.md#yandex.cloud.compute.v1.HardwareGeneration) при использовании gRPC API).

{% endlist %}

После создания образ перейдет в статус `CREATING`. Дождитесь, когда образ перейдет в статус `READY`, прежде чем его использовать.
