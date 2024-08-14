# История изменений в {{ managed-k8s-full-name }}

Изменения появляются в [релизных каналах](./concepts/release-channels-and-updates.md) сервиса последовательно. Сначала обновления, содержащие новую функциональность и улучшения, появляются на канале `rapid`, через некоторое время они попадают в `regular` и уже после этого добавляются в `stable`.

## I полугодие 2024 {#h1-2024}

### Новые возможности {#h1-2024-new-features}

* Добавлена поддержка {{ k8s }} версий [1.28](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.28.md), [1.29](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.29.md) и [1.30](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.30.md). Подробнее см. [{#T}](./concepts/release-channels-and-updates.md).
* Обновлены лимиты [CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md) для поддержки дисков объемом более 200 ТБ.

### Исправления и улучшения {#h1-2024-problems-solved}

* Исправлена ошибка, в результате которой мог теряться размер [снапшота](https://kubernetes.io/docs/concepts/storage/volume-snapshots/) при большом размере [PersistentVolume](./concepts/volume.md#persistent-volume).
* Исправлена ошибка, в результате которой в некоторых случаях при обновлении [группы узлов](./concepts/index.md#node-group) не обновлялись маршруты до [podCIDR](https://kubernetes.io/docs/reference/kubernetes-api/cluster-resources/node-v1/#NodeSpec), из-за чего поды на узле могли быть недоступны.
* Устранен ряд уязвимостей в [runC](https://github.com/opencontainers/runc).
* Исправлена проблема c запуском [кластера](./concepts/index.md#kubernetes-cluster) после обновления сертификатов в остановленном состоянии.
* Исправлена ошибка, в результате которой в некоторых случаях узел при создании навсегда оставался в статусе `NOT_CONNECTED`.

## 2023 {#2023}

### Релиз 2023-6 {#2023-6}

В релизных каналах `rapid`, `regular` и `stable` доступны следующие изменения:
* Добавлена поддержка [сверхбыстрых сетевых хранилищ с тремя репликами (SSD)](../compute/concepts/disk.md#disks-types) для [классов хранилищ](./operations/volumes/manage-storage-class.md) и [постоянных томов](./concepts/volume.md#persistent-volume).
* Появилась возможность использовать группы узлов c [GPU](../compute/concepts/gpus.md) без предустановленных драйверов. Теперь вы можете самостоятельно выбирать подходящую версию драйвера с помощью приложения [GPU Operator](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/overview.html). Подробнее см. [{#T}](./tutorials/driverless-gpu.md).
* Убрано ограничение ресурса CPU у подов [CoreDNS](https://kubernetes.io/docs/tasks/administer-cluster/coredns/) для предотвращения троттлинга.
* Добавлена поддержка [групп размещения нереплицируемых дисков](../compute/concepts/disk-placement-group.md) в CSI-драйвере {{ k8s }}. Параметры групп размещения доступны для [классов хранилищ](./operations/volumes/manage-storage-class.md).
* Исправлена ошибка игнорирования идентификатора [лог-группы](../logging/concepts/log-group.md) при обновлении параметра `master_logging` в кластере.
* Обновлен сетевой контроллер [Calico](./concepts/network-policy.md#calico) до версии [3.25](https://docs.tigera.io/archive/v3.25/release-notes/) для версий {{ k8s }} начиная с 1.24.

### Релиз 2023-5 {#2023-5}

В релизных каналах `rapid`, `regular` и `stable` доступны следующие изменения:
* Исправлена ошибка, при которой Guest Agent на узлах обращался к ресурсу за пределами кластера.
* Обновлена [патч-версия](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.27.md#changelog-since-v1273) для {{ k8s }} версии 1.27.
* Добавлена поддержка {{ k8s }} версии 1.26.
