---
title: "Как получить информацию о диске в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете  получить информацию о диске."
---

# Получить информацию о диске

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [диск](../../concepts/disk.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Выберите диск из списка.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о диске.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [диске](../../concepts/disk.md):

      ```bash
      yc compute disk get --help
      ```

  1. Получите информацию о диске, указав его идентификатор или имя:
      
      ```bash
      yc compute disk get <идентификатор_диска>
      ```

      Результат:

      ```bash
      id: epdi2r341gcq********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:14:30Z"
      name: test-disk
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      disk_placement_policy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [диске](../../concepts/disk.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_disk" "my_disk" {
        disk_id = "epdi2r341gcq********"
      }
      
      output "my_disk_size" {
        value = data.yandex_compute_disk.my_disk.size
      }
      ```

      Где:

      * `data "yandex_compute_disk"` — описание [диска](../../concepts/disk.md) в качестве источника данных:
         * `disk_id` — идентификатор диска.
      * `output "my_disk_size"` — выходная переменная, которая содержит информацию о размере диска:
         * `value` — возвращаемое значение.

     Вместо `size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_disk` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_disk).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```bash
      my_disk_size = 20
      ```

- API {#api}

  Чтобы получить информацию о [диске](../../concepts/disk.md), воспользуйтесь методом REST API [get](../../api-ref/Disk/get.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Get](../../api-ref/grpc/disk_service.md#Get).

{% endlist %}