# История изменений в {{ managed-k8s-full-name }}

Изменения появляются в [релизных каналах](./concepts/release-channels-and-updates.md) сервиса последовательно. Сначала обновления, содержащие новую функциональность и улучшения, появляются на канале `rapid`, через некоторое время они попадают в `regular` и уже после этого добавляются в `stable`.

## Релиз 2023-6 {#2023-6}

В релизном канале `rapid` доступны следующие изменения:
* Добавлена поддержка [высокопроизводительных SSD-дисков](../compute/concepts/disk.md#disks-types) для [классов хранилищ](./operations/volumes/manage-storage-class.md) и [постоянных томов](./concepts/volume.md#persistent-volume).
* Появилась возможность использовать группы узлов c [GPU](../compute/concepts/gpus.md) без предустановленных драйверов. Теперь вы можете самостоятельно выбирать подходящую версию драйвера с помощью приложения [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html). Подробнее см. [{#T}](./tutorials/driverless-gpu.md).
* Убрано ограничение ресурса CPU у подов [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) для предотвращения троттлинга.
* Добавлена поддержка [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md) в CSI-драйвере {{ k8s }}. Параметры групп размещения доступны для [классов хранилищ](./operations/volumes/manage-storage-class.md).
* Исправлена ошибка игнорирования идентификатора [лог-группы](../logging/concepts/log-group.md) при обновлении параметра `master_logging` в кластере.
* Обновлен сетевой контроллер [Calico](./concepts/network-policy.md#calico) до версии [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) для версий {{ k8s }} начиная с 1.24.

## Релиз 2023-5 {#2023-5}

В релизных каналах `rapid`, `regular` и `stable` доступны следующие изменения:
* Исправлена ошибка, при которой Guest Agent на узлах обращался к ресурсу за пределами кластера.
* Обновлена [патч-версия](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) для {{ k8s }} версии 1.27.
* Добавлена поддержка {{ k8s }} версии 1.26.
