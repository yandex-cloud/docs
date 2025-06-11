---
title: Как получить информацию о файловом хранилище в {{ compute-full-name }}
---

# Получить информацию о файловом хранилище

Вы можете узнать размер, зону доступности и другую информацию о файловом хранилище.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [файловое хранилище](../../concepts/filesystem.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
  1. Выберите нужное файловое хранилище.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о файловом хранилище.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [файловом хранилище](../../concepts/filesystem.md):

      ```bash
      yc compute filesystem get --help
      ```

  1. Получите информацию о файловом хранилище, указав его идентификатор или имя:

      ```bash
      yc compute filesystem get <идентификатор_файлового_хранилища>
      ```

      Результат:

      ```text
      id: epdt429j3unu********
      folder_id: b1go3el0d8fs********
      created_at: "2023-10-27T12:15:53Z"
      name: test-filesystem
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "1073741824"
      block_size: "4096"
      status: READY
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [файловом хранилище](../../concepts/filesystem.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_filesystem" "my_fs" {
        filesystem_id = "<идентификатор_файлового_хранилища>"
      }

      output "filesystem" {
        value = data.yandex_compute_filesystem.my_fs.size
      }
      ```

      Где:

      * `data "yandex_compute_filesystem"` — описание файлового хранилища в качестве источника данных:
         * `resource_id` — идентификатор файлового хранилища.
      * `output "filesystem"` — выходная переменная, которая содержит информацию о размере файлового хранилища:
         * `value` — возвращаемое значение.

     Вместо `size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_filesystem` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_filesystem).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      filesystem = "5"
      ```

- API {#api}

  Чтобы получить подробную информацию о [файловом хранилище](../../concepts/filesystem.md), воспользуйтесь методом REST API [get](../../api-ref/Filesystem/get.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md), или вызовом gRPC API [FilesystemService/Get](../../api-ref/grpc/Filesystem/get.md).

{% endlist %}