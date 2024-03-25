---
title: "Как получить информацию о снимке диска в {{ compute-full-name }}"
---

# Получить информацию о снимке диска

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [снимок диска](../../concepts/snapshot.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Выберите нужный снимок диска.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о снимке диска.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для получения информации о [снимке диска](../../concepts/snapshot.md):

     ```bash
     yc compute snapshot get --help
     ```

  1. Получите информацию о снимке диска, указав его имя или идентификатор:

     ```bash
     yc compute snapshot get <имя_снимка_диска>
     ```

     Результат:

     ```text
     id: fd8if7bg95dm********
     folder_id: b1gmit33ngp3********
     created_at: "2023-10-30T14:52:37Z"
     ...
       - f2e8f6be9gr1********
     status: READY
     source_disk_id: fhm0r72q6mvq********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [снимке диска](../../concepts/snapshot.md) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_compute_snapshot" "my_snapshot" {
       snapshot_id = "<идентификатор_снимка_диска>"
     }

     output "snapshot" {
       value = data.yandex_compute_snapshot.my_snapshot.storage_size
     }
     ```

     Где:
     * `data "yandex_compute_snapshot"` — описание снимка диска в качестве источника данных:
       * `snapshot_id` — идентификатор снимка диска.
     * `output "snapshot"` — выходная переменная, которая содержит информацию о размере снимка диска:
       * `value` — возвращаемое значение.

     Вместо `storage_size` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_snapshot` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_snapshot).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     snapshot = 7
     ```

- API {#api}

  Чтобы получить подробную информацию о [снимке диска](../../concepts/snapshot.md), воспользуйтесь методом REST API [get](../../api-ref/Snapshot/get.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md), или вызовом gRPC API [SnapshotService/Get](../../api-ref/grpc/snapshot_service.md#Get).

{% endlist %}