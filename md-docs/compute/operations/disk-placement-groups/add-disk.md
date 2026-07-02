[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Группы размещения дисков > Добавить диск в группу размещения

# Добавить диск в группу размещения


{% note warning %}

Из-за технических особенностей инфраструктуры Yandex Cloud не гарантируется, что существующий [нереплицируемый диск](../../concepts/disk.md#nr-disks) получится добавить в [группу размещения](../../concepts/disk-placement-group.md), но вы можете гарантированно [создать](../disk-create/nonreplicated.md#nr-disk-in-group) [диск](../../concepts/disk.md) сразу в группе.

{% endnote %}

Нереплицируемый диск может быть размещен только в одной группе и должен находится с ней в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

Чтобы добавить диск в группу размещения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить диск в группу размещения.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **Группы размещений**.
  1. Перейдите на вкладку **Группы размещения нереплицируемых дисков**.
  1. Выберите группу размещения, в которую нужно добавить диск.
  1. Перейдите на панель **Диски** и нажмите кнопку ![image](../../../_assets/plus-sign.svg) **Добавить диск**.
  1. В открывшемся окне выберите диск, который хотите добавить.

     Для групп со стратегией [размещения разделами](../../concepts/disk-placement-group.md#partition) (partition) задайте номер раздела.
  1. Нажмите кнопку **Добавить**.


- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Disk/update.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Update](../../api-ref/grpc/Disk/update.md).

  Список доступных дисков запрашивайте методом REST API [list](../../api-ref/Disk/list.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/List](../../api-ref/grpc/Disk/list.md).

{% endlist %}