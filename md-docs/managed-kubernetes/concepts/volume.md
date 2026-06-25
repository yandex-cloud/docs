# Том

Данные для работы приложений в [контейнерах](../../glossary/containerization.md#type-of-containers) можно хранить в самих контейнерах, но при этом возникают проблемы:
* Когда контейнер аварийно завершает работу, `kubelet` перезапускает его, но файлы теряются — контейнер запускается с чистым состоянием.
* Файлы в контейнере недоступны для других контейнеров, работающих в том же [поде](index.md#pod).

Эти проблемы решаются с помощью _томов_ Kubernetes.

_Том_ — общее хранилище для совместного использования объектов в разных контейнерах, развернутых в пределах одного или нескольких подов. Пользователь указывает в спецификации пода тома, которые будут содержать под, и путь, по которому контейнеры монтируют эти тома.

Для работы с томами Kubernetes оперирует объектами [API Kubernetes](https://kubernetes.io/docs/reference/kubernetes-api/): `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, `StorageClass`.

Тома разделяются согласно их жизненному циклу:
* Временные (`Volume`) — имеют то же время жизни, что и содержащие их поды. Эти тома создаются при создании пода и сохраняются при перезапуске контейнера. Когда под останавливается или удаляется, его тома уничтожаются.
* Постоянные (`PersistentVolume`) — имеют свой собственный жизненный цикл. В этих томах данные сохраняются при удалении пода. Том можно размонтировать, например, для переноса данных на другой под или [узел Managed Service for Kubernetes](index.md#node-group).

Временные и постоянные тома могут быть разных типов, в зависимости от хранилища. Ознакомьтесь с [типами томов](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes), поддерживаемых в Kubernetes.

## Работа с постоянными томами {#persistent-volume}


Работа с постоянными томами Kubernetes осуществляется с помощью объектов API `PersistentVolume` и `PersistentVolumeClaim`.
* `PersistentVolumes`, PV — это ресурсы [кластера Managed Service for Kubernetes](index.md#kubernetes-cluster), которые существуют независимо от подов. Это означает, что [диск](../../compute/concepts/disk.md) и данные, предоставленные PV, продолжают существовать при изменении кластера Managed Service for Kubernetes, а также при удалении и повторном создании подов.

  Ресурсы объекта `PersistentVolume` могут быть подготовлены динамически с помощью объектов `PersistentVolumeClaims` или заранее созданы администратором кластера Managed Service for Kubernetes.
* `PersistentVolumeClaim`, PVC — используются для указания объектов `PersistentVolumes` в спецификации пода, так как объекты `PersistentVolumes` не могут быть указаны напрямую.

  Объекты `PersistentVolumeClaim` запрашивают определенный размер, режим доступа и класс хранилищ для объекта `PersistentVolume`. Если объект `PersistentVolume`, удовлетворяющий запросу, существует или может быть подготовлен, объект `PersistentVolumeClaim` связывается с необходимым объектом `PersistentVolume`. Кластер Managed Service for Kubernetes монтирует объект `PersistentVolumeClaim` в качестве тома для пода.

Пользователям часто необходимы объекты `PersistentVolumes` с различными свойствами. Администраторы кластеров Managed Service for Kubernetes могут предлагать различные объекты `PersistentVolumes` благодаря [классам хранилищ](../operations/volumes/manage-storage-class.md).

{% note alert %}

При удалении кластера Managed Service for Kubernetes диски Compute Cloud, связанные с `PersistentVolumes`, не удаляются автоматически.

{% endnote %}

## Режимы подключения постоянных томов {#volume-mode}

Managed Service for Kubernetes поддерживает два режима подключения (`volumeMode`) постоянных томов (`PersistentVolume`): с файловой системой (`Filesystem`) и без нее (`Block`).

Если `volumeMode` не указан, значение по умолчанию: `Filesystem`.

### Том с файловой системой {#filesystem}

Вы можете указать в `PersistentVolumeClaim` режим подключения `volumeMode: Filesystem`, тогда Managed Service for Kubernetes создаст файловую систему на блочном хранилище перед его первым монтированием к поду.

Как подготовить под с томом в режиме `volumeMode: Filesystem`, читайте в разделе [Динамическая подготовка тома](../operations/volumes/dynamic-create-pv.md).

### Том без файловой системы {#block}

Вы можете установить значение `volumeMode: Block`, чтобы подключить том в качестве блочного хранилища без создания файловой системы. Приложение, запущенное на поде с таким томом, должно уметь работать с хранилищем без файловой системы.

Как подготовить под с томом в режиме `volumeMode: Block`, читайте в разделе [Подключение тома в блочном режиме](../operations/volumes/mode-block.md).

## Подготовка томов {#provisioning-volumes}

В Managed Service for Kubernetes можно использовать объекты `PersistentVolumes` на основе дисков Yandex Compute Cloud. Тип используемого диска и другие параметры можно установить с помощью соответствующих [классов хранилищ](../operations/volumes/manage-storage-class.md).

В Managed Service for Kubernetes доступны следующие [типы дисков](../../compute/concepts/disk.md##disks-types): {#disks-types}

* Сетевой SSD-диск (`network-ssd`) — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
* Сетевой HDD-диск (`network-hdd`) — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
* Нереплицируемый SSD-диск (`network-ssd-nonreplicated`) — сетевой диск с повышенной производительностью без избыточности.
* Сверхбыстрое сетевое хранилище с тремя репликами (SSD) (`network-ssd-io-m3`) — высокопроизводительный диск, который обладает теми же скоростными характеристиками, что и `network-ssd-nonreplicated`, но одновременно обеспечивает избыточность.

{% note alert %}

Диски Compute Cloud создаются в определенной [зоне доступности](../../overview/concepts/geo-scope.md). Это влияет на то, где могут быть перезапущены поды.

{% endnote %}

### Динамическая подготовка тома {#dynamic-provisioning}

В большинстве случаев нет необходимости вручную создавать объекты `PersistentVolumes` и диски Compute Cloud. Вместо этого можно создать объекты `PersistentVolumeClaim`, и Managed Service for Kubernetes автоматически подготовит необходимый объект `PersistentVolume` и создаст диск.

Как динамически подготовить том, читайте в разделе [Динамическая подготовка тома](../operations/volumes/dynamic-create-pv.md).

### Статическая подготовка тома {#static-provisioning}

Помимо создания новых дисков для подготовки объектов `PersistentVolumes`, вы можете использовать уже существующие диски Yandex Cloud.

Подробнее о статической подготовке тома с использованием облачных дисков читайте в разделе [Статическая подготовка тома](../operations/volumes/static-create-pv.md).

## Увеличение размера томов {#volume-expansion}

В Managed Service for Kubernetes поддерживается «горячее» увеличение размера томов с помощью объекта `PersistentVolumeClaim` без необходимости перезапуска подов, которые эти тома используют.

Подробнее в разделе [Увеличение размера тома для подов](../operations/volumes/volume-expansion.md).

## Удаление томов {#deleting-volumes}

В зависимости от настроек объектов `PersistentVolume` и `PersistentVolumeClaim` соответствующие тома и диски могут удаляться автоматически или вручную.
* При динамической подготовке тома: после удаления объекта `PersistentVolumeClaim` на основе классов хранилищ `yc-network-hdd` или `yc-network-ssd`, соответствующие объект `PersistentVolume` и диск Compute Cloud **будут удалены**.
* При статической подготовке тома: для спецификации [PersistentVolumeSpec](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/#PersistentVolumeSpec) всегда используется значение параметра `persistentVolumeReclaimPolicy: Retain`, при этом диск Compute Cloud **не удаляется** при удалении объекта `PersistentVolumeClaim`. Значение параметра `Delete`, заданное вручную, не приведет к удалению диска.

При удалении кластера Managed Service for Kubernetes диски Compute Cloud, связанные с `PersistentVolumes`, не удаляются автоматически.

Подробнее о томах читайте в [документации Kubernetes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).

## Использование зашифрованных дисков {#encrypted-disks}

В Managed Service for Kubernetes для постоянных томов поддерживается использование дисков Compute Cloud, [зашифрованных](../../compute/concepts/encryption.md) с помощью пользовательских [симметричных ключей](../../kms/concepts/key.md) Yandex Key Management Service.

{% note info %}

Чтобы использовать зашифрованные диски, у [облачного сервисного аккаунта](index.md#service-accounts), назначенного кластеру Managed Service for Kubernetes, должна быть [роль](../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.

{% endnote %}

Для [статической подготовки тома](#static-provisioning) вы можете использовать существующий зашифрованный диск, аналогично обычному диску из Compute Cloud.

Для [динамической подготовки тома](#dynamic-provisioning) вам понадобится создать новый класс хранилища (`StorageClass`) с указанием идентификатора симметричного ключа в поле `parameters:kmsKeyId`.

Манифест для класса хранилища с шифрованием:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: <название_класса_хранилища>
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: <тип_диска>
  csi.storage.k8s.io/fstype: ext4
  kmsKeyId: <идентификатора_симметричного_ключа>
allowVolumeExpansion: true
reclaimPolicy: Delete
```

Где:
* `metadata:name` — произвольное название класса хранилища.
* `parameters:type` — [тип диска](volume.md#disks-types) в Compute Cloud. Возможные значения:
  * `network-ssd` — сетевой SSD-диск.
  * `network-hdd` — сетевой HDD-диск.
  * `network-ssd-nonreplicated` — нереплицируемый SSD-диск.
  * `network-ssd-io-m3` — сверхбыстрое сетевое хранилище с тремя репликами (SSD).
* `parameters:kmsKeyId` — идентификатор симметричного ключа.

Подробнее об использовании зашифрованных дисков смотрите на странице [Использование зашифрованных дисков для постоянных томов](../operations/volumes/encrypted-disks.md).

## Примеры использования {#examples}

* [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](../tutorials/kubernetes-backup.md)