---
title: Добавить диск в группу размещения
description: Следуя данной инструкции, вы сможете добавить диск в группу размещения.
---

# Добавить диск в группу размещения


{% note warning %}

Из-за технических особенностей инфраструктуры {{ yandex-cloud }} не гарантируется, что существующий [нереплицируемый диск](../../concepts/disk.md#nr-disks) получится добавить в [группу размещения](../../concepts/disk-placement-group.md), но вы можете гарантированно [создать](../disk-create/nonreplicated.md#nr-disk-in-group) [диск](../../concepts/disk.md) сразу в группе.

{% endnote %}

Нереплицируемый диск может быть размещен только в одной группе и должен находится с ней в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

Чтобы добавить диск в группу размещения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить диск в группу размещения.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}**.
  1. Выберите группу размещения, в которую нужно добавить диск.
  1. Перейдите на панель **{{ ui-key.yacloud.compute.placement-group.switch_disks }}** и нажмите кнопку ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.compute.placement-group.disks.button_add-disk }}**.
  1. В открывшемся окне выберите диск, который хотите добавить.

     Для групп со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition) (partition) задайте номер раздела.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.


- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Update](../../api-ref/grpc/Disk/update.md).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

{% endlist %}