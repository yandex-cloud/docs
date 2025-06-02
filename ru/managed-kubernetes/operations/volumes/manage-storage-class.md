---
title: Управление классами хранилищ
description: Следуя данной инструкции, вы сможете управлять классами хранилищ.
---

# Управление классами хранилищ


_Класс хранилищ_ (`StorageClass`) предоставляет администраторам возможность разделить хранилища, которые они предлагают, на классы с определенными параметрами. Классы отличаются [типом создаваемого диска](../../../compute/concepts/disk.md#disks_types) и правилами тарификации.

{% note alert %}

Стоимость использования хранилища зависит от типа его [диска](../../../compute/concepts/disk.md). Ознакомьтесь с [ценами на диски {{ compute-full-name }}](../../../compute/concepts/disk.md#disks_types) перед созданием хранилища.

{% endnote %}

В {{ managed-k8s-name }} доступны следующие классы хранилищ, которые отличаются [типом создаваемого диска](../../../compute/concepts/disk.md#disks_types):
* `yc-network-hdd` (используется по умолчанию) — хранилище на сетевых HDD-дисках (`network-hdd`).
* `yc-network-ssd` — хранилище на сетевых SSD-дисках (`network-ssd`).
* `yc-network-ssd-nonreplicated` — хранилище на нереплицируемых SSD-дисках с повышенной производительностью (`network-ssd-nonreplicated`).
* `yc-network-ssd-io-m3` — хранилище на сетевых SSD-дисках с повышенной производительностью (`network-ssd-io-m3`).

{% include [Нереплицируемый диск не имеет резервирования](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

Все хранилища создаются с параметрами:
* [Volume Binding Mode](https://kubernetes.io/docs/concepts/storage/storage-classes/#volume-binding-mode) — `WaitForFirstConsumer`.
* [Reclaim Policy](https://kubernetes.io/docs/concepts/storage/storage-classes/#reclaim-policy) — `Delete`.

Данные классы допускают использование объектов `PersistentVolumeClaim` и `PersistentVolume` только в [режиме доступа](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) `ReadWriteOnce`.

Вы можете [создать свой класс хранилищ](#sc-create), а также [изменить класс хранилищ по умолчанию](#sc-default).

{% include [Перед началом установите kubectl](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

{% note info %}

Класс `yc-network-nvme` является устаревшим. Вместо него используйте класс `yc-network-ssd`.

{% endnote %}


## Создайте класс хранилищ {#sc-create}

1. Сохраните спецификацию для создания класса хранилищ в YAML-файл `my-sc-hdd.yaml`:

   Подробнее про [формат спецификации для создания класса хранилищ](#sc-spec).

   ```yaml
   kind: StorageClass
   apiVersion: storage.k8s.io/v1
   metadata:
     name: my-sc-hdd
   provisioner: disk-csi-driver.mks.ycloud.io
   volumeBindingMode: WaitForFirstConsumer
   parameters:
     type: network-hdd
     csi.storage.k8s.io/fstype: ext4
   allowVolumeExpansion: false
   reclaimPolicy: Retain
   ```

1. Выполните команду:

   ```bash
   kubectl create -f my-sc-hdd.yaml
   ```

   Результат:

   ```text
   storageclass.storage.k8s.io/my-sc-hdd created
   ```

1. Проверьте, что класс хранилищ создался:

   ```bash
   kubectl get storageclass
   ```

   Результат:

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

### Формат спецификации для создания класса хранилищ {#sc-spec}

Каждый объект `StorageClass` содержит параметры `parameters`, `allowVolumeExpansion` и `reclaimPolicy`, которые используются для динамического выделения объекта `PersistentVolume`.

Структура YAML-файла:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <имя_класса_хранилищ> # Используется для обращения к классу хранилищ.
provisioner: <имя_поставщика>
volumeBindingMode: WaitForFirstConsumer
parameters: # Параметры класса хранилищ.
  type: <тип_диска>
  csi.storage.k8s.io/fstype: <тип_файловой_системы>
allowVolumeExpansion: <включение_механизма_увеличения_размера_тома>
reclaimPolicy: <политика_переиспользования>
```

Допустимые значения параметров:
* `parameters`:
  * `type` — `network-hdd`, `network-ssd`, `network-ssd-nonreplicated` или `network-ssd-io-m3`.
  * `csi.storage.k8s.io/fstype` — `ext2`, `ext3` или `ext4`.
* `reclaimPolicy` — `Retain` или `Delete`.
* `allowVolumeExpansion` — `true` или `false`.


## Измените класс хранилищ по умолчанию {#sc-default}

1. Посмотрите, какой класс хранилищ установлен по умолчанию. Рядом с его названием в скобках будет указано `default`.

   ```bash
   kubectl get storageclass
   ```

   Результат:

   ```text
   NAME                      PROVISIONER                    AGE
   my-sc-hdd                 disk-csi-driver.mks.ycloud.io  76s
   yc-network-hdd (default)  disk-csi-driver.mks.ycloud.io  16m
   yc-network-ssd            disk-csi-driver.mks.ycloud.io  16m
   ```

1. Измените параметр `storageclass.kubernetes.io/is-default-class` класса хранилищ по умолчанию на `false`, чтобы он перестал быть классом по умолчанию:

   ```bash
   kubectl patch storageclass yc-network-hdd \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
   ```

1. Проверьте, что `yc-network-hdd` больше не является классом хранилищ по умолчанию:

   ```bash
   kubectl get storageclass
   ```

   Результат:

   ```text
   NAME            PROVISIONER                    AGE
   my-sc-hdd       disk-csi-driver.mks.ycloud.io  2m36s
   yc-network-hdd  disk-csi-driver.mks.ycloud.io  17m
   yc-network-ssd  disk-csi-driver.mks.ycloud.io  17m
   ```

1. Укажите новый класс хранилищ по умолчанию, например `my-sc-hdd`:

   ```bash
   kubectl patch storageclass my-sc-hdd \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```

1. Проверьте, что `my-sc-hdd` стал классом хранилищ по умолчанию:

   ```bash
   kubectl get storageclass
   ```

   Результат:

   ```text
   NAME                 PROVISIONER                    AGE
   my-sc-hdd (default)  disk-csi-driver.mks.ycloud.io  4m21s
   yc-network-hdd       disk-csi-driver.mks.ycloud.io  19m
   yc-network-ssd       disk-csi-driver.mks.ycloud.io  19m
   ```

### См. также {#see-also}

* [{#T}](../../concepts/volume.md)
* [{#T}](./encrypted-disks.md)
* [{#T}](./dynamic-create-pv.md)
* [{#T}](./static-create-pv.md)