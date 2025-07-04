---
title: Удалить диск из группы размещения
description: Следуя данной инструкции, вы сможете удалить диск из группы размещения.
---

# Удалить диск из группы размещения


Удалите [нереплицируемый диск](../../concepts/disk.md#nr-disks) из [группы размещения](../../concepts/disk-placement-group.md). Затем [диск](../../concepts/disk.md) можно [удалить насовсем](../disk-control/delete.md) или добавить обратно в группу размещения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить диск из группы размещения.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}**.
  1. Выберите группу размещения, из которой нужно удалить диск.
  1. Перейдите на панель **{{ ui-key.yacloud.compute.placement-group.switch_disks }}**.
  1. Справа от имени удаляемого диска нажмите значок ![horizontal-ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить нереплицируемый диск из группы размещения, созданный с помощью {{ TF }}:
  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием нереплицируемого диска.

     {% cut "Пример описания нереплицируемого диска в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_compute_disk" "nr" {
       name       = "non-replicated-disk-name"
       size       = 93
       block_size = 4096
       type       = "network-ssd-nonreplicated"
       zone       = "{{ region-id }}-b"

       disk_placement_policy {
         disk_placement_group_id = yandex_compute_disk_placement_group.this.id
       }
     }

     resource "yandex_compute_disk_placement_group" "this" {
       zone = "{{ region-id }}-b"
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc compute disk-placement-group get <имя_группы_размещения_дисков>
     ```

{% endlist %}