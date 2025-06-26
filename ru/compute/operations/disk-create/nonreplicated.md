---
title: Как создать нереплицируемый диск в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать нереплицируемый диск.
---

# Создать нереплицируемый диск


Вы можете создать отдельный [нереплицируемый диск](../../concepts/disk.md#nr-disks), либо добавить его в [группу размещения дисков](../../concepts/disk-placement-group.md).

Размер [диска](../../concepts/disk.md) должен быть кратен 93 ГБ.

## Создать отдельный нереплицируемый диск {#nr-disk}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
  1. Укажите тип диска `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}`.
  1. Выберите нужный размер блока.
  1. Задайте нужный размер диска.
  1. {% include [encryption-section](../../../_includes/compute/encryption-section.md) %}
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться [снимки](../../concepts/snapshot.md), или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

     При создании диска для него можно выбрать только одно расписание снимков. Если требуется, после создания диска вы можете добавить к нему еще несколько расписаний по [инструкции](../disk-control/configure-schedule.md#add-schedule).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания дисков:

     ```bash
     yc compute disk create --help
     ```

  1. Чтобы создать нереплицируемый диск с именем `nr-disk`, выполните команду:

     ```bash
     yc compute disk create \
       --name nr-disk \
       --type network-ssd-nonreplicated \
       --size 93 \
       --kms-key-id <идентификатор_ключа>
     ```

       Где:
       * `--name` — имя диска.
       * `--type` — тип диска.
       * `--size` — размер диска.
       * `--kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     Результат:

     ```text
     done (1s)
     id: epdb2517b970********
     folder_id: b1g7gvsi89m3********
     ...
     block_size: "4096"
     status: READY
     disk_placement_policy: {}
     hardware_generation:
       legacy_features:
         pci_topology: PCI_TOPOLOGY_V1
     kms_key:
       key_id: abjbaqdga6hs********
       version_id: abj295dgqnlp********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры нереплицируемого диска:

     ```hcl
     resource "yandex_compute_disk" "nr" {
       name       = "<имя_нереплицируемого_диска>"
       size       = <размер_нереплицируемого_диска>
       block_size = <размер_блока>
       type       = "network-ssd-nonreplicated"
       zone       = "<зона_доступности>"
       kms_key_id = "<идентификатор_KMS_ключа>"
     }
     ```

     Где:
     * `name` — имя нереплицируемого диска. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `size` — размер нереплицируемого диска, должен быть кратен 93 ГБ.
     * `block_size` — размер блока в байтах (минимальный объем хранения информации на диске). Максимальный размер диска зависит от заданного размера блока. По умолчанию размер блоков всех создаваемых дисков равен 4 КБ, однако для дисков больше 8 ТБ этого недостаточно. Подробнее см. в разделе [{#T}](../../../compute/operations/disk-create/empty-disk-blocksize.md).
     * `type` — тип создаваемого диска. Укажите `network-ssd-nonreplicated` для создания нереплицируемого диска.
     * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
     * `kms_key_id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания [зашифрованного](../../concepts/encryption.md) диска. Необязательный параметр.

        {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}

        {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

        {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     Более подробную информацию о параметрах ресурса `yandex_compute_disk` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk#example-usage---non-replicated-disk).
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

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

        ```bash
        yc compute disk list
        ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

{% endlist %}

## Создать нереплицируемый диск в группе размещения {#nr-disk-in-group}

Диск можно создать только в существующей группе размещения дисков.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.
  1. Введите имя диска. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. Если требуется, добавьте произвольное описание диска.
  1. Выберите зону доступности, в которой будет находиться диск.

     Зона доступности для диска должна соответствовать зоне группы размещения, в которой вы хотите создать диск.
  1. Укажите тип диска `{{ ui-key.yacloud.compute.value_disk-type-network-ssd-nonreplicated_d7W56 }}`.
  1. Выберите группу размещения дисков.

      Если вы выбрали группу со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition) (partition), укажите номер раздела, в который вы хотите добавить диск.
  1. Задайте нужный размер диска.
  1. Если требуется, выберите [расписание](../../concepts/snapshot-schedule.md), по которому для диска будут автоматически создаваться снимки, или создайте его. Подробнее о настройках расписания см. в [инструкции](../snapshot-control/create-schedule.md).

     Если вы хотите указать еще одно расписание, вы сможете [добавить](../disk-control/configure-schedule.md#add-schedule) его после создания диска.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания дисков:

     ```bash
     yc compute disk create --help
     ```

  1. Создайте нереплицируемый диск в каталоге по умолчанию в группе размещения с одной из стратегий:
     * [Распределенное размещение](../../concepts/disk-placement-group.md#spread) (spread):

       ```bash
       yc compute disk create \
         --name <имя_диска> \
         --type network-ssd-nonreplicated \
         --size <размер_диска> \
         --disk-placement-group-name <имя_группы_размещения> \
         --kms-key-id <идентификатор_ключа>
       ```

       Где:
       * `--name` — имя диска.
       * `--type` — тип диска.
       * `--size` — размер диска.
       * `--disk-placement-group-name` — имя группы размещения.
       * `--kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

       Результат:

       ```text
       done (1s)
       id: epdtncic35ru********
       folder_id: b1g7gvsi89m3********
       ...
       status: READY
       disk_placement_policy:
         placement_group_id: epdn946ilslh********
       hardware_generation:
         legacy_features:
           pci_topology: PCI_TOPOLOGY_V1
       kms_key:
         key_id: abjbaqdga6hs********
         version_id: abj295dgqnlp********
       ```

     * [Размещение разделами](../../concepts/disk-placement-group.md#partition) (partition):

       ```bash
       yc compute disk create \
         --name <имя_диска> \
         --type network-ssd-nonreplicated \
         --size <размер_диска> \
         --disk-placement-group-name <имя_группы_размещения> \
         --disk-placement-group-partition <номер_раздела>
       ```

       Где:
       * `--name` — имя диска.
       * `--type` — тип диска.
       * `--size` — размер диска.
       * `--disk-placement-group-name` — имя группы размещения.
       * `--disk-placement-group-partition` — номер раздела в группе размещения.
       * `--kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного диска. Необязательный параметр.

         {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
         
         {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

         {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

       Результат:

       ```text
       done (1s)
       id: epdtncic35ru********
       folder_id: b1g7gvsi89m3********
       ...
       disk_placement_policy:
         placement_group_id: epdn946ilslh********
         placement_group_partition: 2
       kms_key:
         key_id: abjbaqdga6hs********
         version_id: abj295dgqnlp********
       ```


- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

{% endlist %}


#### См. также {#see-also}

* [{#T}](../snapshot-control/create-schedule.md)
