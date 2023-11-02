# Том

Данные для работы приложений в [контейнерах](../../glossary/containerization.md#type-of-containers) можно хранить в самих контейнерах, но при этом возникают проблемы:
* Когда контейнер аварийно завершает работу, `kubelet` перезапускает его, но файлы теряются — контейнер запускается с чистым состоянием.
* Файлы в контейнере недоступны для других контейнеров, работающих в том же [поде](index.md#pod).

Эти проблемы решаются с помощью _томов_ {{ k8s }}.

_Том_ — общее хранилище для совместного использования объектов в разных контейнерах, развернутых в пределах одного или нескольких подов. Пользователь указывает в спецификации пода тома, которые будут содержать под, и путь, по которому контейнеры монтируют эти тома.

Для работы с томами {{ k8s }} оперирует объектами [API {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/): `Volume`, `PersistentVolume`, `PersistentVolumeClaim`, `StorageClass`.

Тома разделяются согласно их жизненному циклу:
* Временные (`Volume`) — имеют то же время жизни, что и содержащие их поды. Эти тома создаются при создании пода и сохраняются при перезапуске контейнера. Когда под останавливается или удаляется, его тома уничтожаются.
* Постоянные (`PersistentVolume`) — имеют свой собственный жизненный цикл. В этих томах данные сохраняются при удалении пода. Том можно размонтировать, например, для переноса данных на другой под или [узел {{ managed-k8s-name }}](index.md#node-group).

Временные и постоянные тома могут быть разных типов, в зависимости от хранилища. Ознакомьтесь с [типами томов](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes), поддерживаемых в {{ k8s }}.

## Работа с постоянными томами {#persistent-volume}

Работа с постоянными томами {{ k8s }} осуществляется с помощью объектов API `PersistentVolume` и `PersistentVolumeClaim`.
* `PersistentVolumes`, PV — это ресурсы [кластера {{ managed-k8s-name }}](index.md#kubernetes-cluster), которые существуют независимо от подов. Это означает, что [диск](../../compute/concepts/disk.md) и данные, предоставленные PV, продолжают существовать при изменении кластера {{ managed-k8s-name }}, а также при удалении и повторном создании подов.

  Ресурсы объекта `PersistentVolume` могут быть подготовлены динамически с помощью объектов `PersistentVolumeClaims` или заранее созданы администратором кластера {{ managed-k8s-name }}.
* `PersistentVolumeClaim`, PVC — используются для указания объектов `PersistentVolumes` в спецификации пода, так как объекты `PersistentVolumes` не могут быть указаны напрямую.

  Объекты `PersistentVolumeClaim` запрашивают определенный размер, режим доступа и класс хранилищ для объекта `PersistentVolume`. Если объект `PersistentVolume`, удовлетворяющий запросу, существует или может быть подготовлен, объект `PersistentVolumeClaim` связывается с необходимым объектом `PersistentVolume`. Кластер {{ managed-k8s-name }} монтирует объект `PersistentVolumeClaim` в качестве тома для пода.

Пользователям часто необходимы объекты `PersistentVolumes` с различными свойствами. Администраторы кластеров {{ managed-k8s-name }} могут предлагать различные объекты `PersistentVolumes` благодаря [классам хранилищ](../operations/volumes/manage-storage-class.md).

{% note alert %}

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

{% endnote %}

## Режимы подключения постоянных томов {#volume-mode}

{{ managed-k8s-name }} поддерживает два режима подключения (`volumeMode`) постоянных томов (`PersistentVolume`): с файловой системой (`Filesystem`) и без нее (`Block`).

Если `volumeMode` не указан, значение по умолчанию: `Filesystem`.

### Том с файловой системой {#filesystem}

Вы можете указать в `PersistentVolumeClaim` режим подключения `volumeMode: Filesystem`, тогда {{ managed-k8s-name }} создаст файловую систему на блочном хранилище перед его первым монтированием к поду.

Как подготовить под с томом в режиме `volumeMode: Filesystem`, читайте в разделе [{#T}](../operations/volumes/dynamic-create-pv.md).

### Том без файловой системы {#block}

Вы можете установить значение `volumeMode: Block`, чтобы подключить том в качестве блочного хранилища без создания файловой системы. Приложение, запущенное на поде с таким томом, должно уметь работать с хранилищем без файловой системы.

Как подготовить под с томом в режиме `volumeMode: Block`, читайте в разделе [{#T}](../operations/volumes/mode-block.md).

## Подготовка томов {#provisioning-volumes}

В {{ managed-k8s-name }} можно использовать объекты `PersistentVolumes` на основе дисков {{ compute-full-name }}. Тип используемого диска и другие параметры можно установить с помощью соответствующих [классов хранилищ](../operations/volumes/manage-storage-class.md).

В {{ managed-k8s-name }} доступны следующие [типы дисков](../../compute/concepts/disk.md##disks-types):
* Сетевой SSD-диск (`network-ssd`) — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
* Сетевой HDD-диск (`network-hdd`) — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
* Нереплицируемый SSD-диск (`network-ssd-nonreplicated`) — сетевой диск с повышенной производительностью без избыточности.
* Высокопроизводительный SSD-диск (`network-ssd-io-m3`) — обладает теми же скоростными характеристиками что и `network-ssd-nonreplicated` и одновременно обеспечивает избыточность.

{% note alert %}

Диски {{ compute-name }} создаются в определенной [зоне доступности](../../overview/concepts/geo-scope.md). Это влияет на то, где могут быть перезапущены поды.

{% endnote %}

### Динамическая подготовка тома {#dynamic-provisioning}

В большинстве случаев нет необходимости вручную создавать объекты `PersistentVolumes` и диски {{ compute-name }}. Вместо этого можно создать объекты `PersistentVolumeClaim`, и {{ managed-k8s-name }} автоматически подготовит необходимый объект `PersistentVolume` и создаст диск.

Как динамически подготовить том, читайте в разделе [{#T}](../operations/volumes/dynamic-create-pv.md).

### Статическая подготовка тома {#static-provisioning}

Помимо создания новых дисков для подготовки объектов `PersistentVolumes`, вы можете использовать уже существующие диски {{ yandex-cloud }}.

Подробнее о статической подготовке тома с использованием облачных дисков читайте в разделе [{#T}](../operations/volumes/static-create-pv.md).

## Увеличение размера томов {#volume-expansion}

Вы можете увеличить размер тома {{ k8s }} после его создания. Увеличить размер можно только после завершения работы пода с томом.

Чтобы увеличить размер тома:
1. Убедитесь, что в описании класса хранилища (`StorageClass`) указан параметр `allowVolumeExpansion: true`.
1. Удалите под с томом, для которого нужно увеличить размер.
1. Отредактируйте объект `PersistentVolumeClaim`, чтобы запросить больше места.
1. Дождитесь увеличения размера тома.
1. Создайте под, к которому будет монтирован том.

Как увеличить размер тома, читайте в разделе [{#T}](../operations/volumes/volume-expansion.md).

## Удаление томов {#deleting-volumes}

В зависимости от настроек объектов `PersistentVolume` и `PersistentVolumeClaim` соответствующие тома и диски могут удаляться автоматически или вручную.
* При динамической подготовке тома: после удаления объекта `PersistentVolumeClaim` на основе классов хранилищ `yc-network-hdd` или `yc-network-ssd`, соответствующие объект `PersistentVolume` и диск {{ compute-name }} **будут удалены**.
* При статической подготовке тома: для спецификации [PersistentVolumeSpec](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/#PersistentVolumeSpec) всегда используется значение параметра `persistentVolumeReclaimPolicy: Retain`, при этом диск {{ compute-name }} **не удаляется** при удалении объекта `PersistentVolumeClaim`. Значение параметра `Delete`, заданное вручную, не приведет к удалению диска.

{% include [about-cluster-delete](../../_includes/managed-kubernetes/note-k8s-cluster-delete.md) %}

Подробнее о томах читайте в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).