#### Какие существуют особенности работы с дисковым хранилищем при размещении БД ({{ MY }}, {{ PG }} и т. д.) в кластере {{ k8s }}? {#bd}

При размещении БД в кластере {{ k8s }} используйте контроллеры [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). Мы не рекомендуем запускать в {{ k8s }} stateful-сервисы с постоянными томами. Для работы с базами данных stateful-сервисов используйте [управляемые базы данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), например {{ mmy-name }} или {{ mpg-name }}.

#### Как подключить под к управляемым базам данных {{ yandex-cloud }}? {#mdb}

Чтобы подключиться к [управляемой базе данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), расположенной в той же [сети](../../vpc/concepts/network.md#network), укажите [имя ее хоста и FQDN](../../compute/concepts/network.md#hostname).

Для подключения сертификата базы данных к [поду](../../managed-kubernetes/concepts/index.md#pod) используйте объекты типа `secret` или `configmap`.

#### Как правильно подключить постоянный том к контейнеру? {#persistent-volume}

Вы можете выбрать режим для подключения [дисков](../../compute/concepts/disk.md) {{ compute-name }} в зависимости от ваших нужд:
* Чтобы {{ k8s }} автоматически подготовил объект `PersistentVolume` и настроил новый диск, создайте под с [динамически подготовленным](../../managed-kubernetes/operations/volumes/dynamic-create-pv.md) томом.
* Чтобы использовать уже существующие диски {{ compute-name }}, создайте под со [статически подготовленным](../../managed-kubernetes/operations/volumes/static-create-pv.md) томом.

Подробнее читайте в разделе [Работа с постоянными томами](../../managed-kubernetes/concepts/volume.md#persistent-volume).

#### Какие типы томов поддерживает {{ managed-k8s-name }}? {#supported-volumes}

{{ managed-k8s-name }} поддерживает работу с временными (`Volume`) и постоянными (`PersistentVolume`) томами. Подробнее читайте в разделе [{#T}](../../managed-kubernetes/concepts/volume.md).

#### Почему возникает ошибка `Multi-Attach error for volume`? {#multi-attach}

Сетевой диск, на котором основан постоянный том, можно подключить только к одному узлу одновременно. Ошибка `Multi-Attach error for volume` возникает, когда {{ k8s }} пытается подключить том к узлу, пока том еще подключен к другому узлу. Например, это происходит, если поды используют один PVC, но размещены на разных узлах. Несколько подов на одном узле могут использовать один том в режиме `ReadWriteOnce`.

Проверьте размещение подов, использующих PVC, и события подключения тома. Если приложению нужен доступ с нескольких узлов в режиме `ReadWriteMany`, выберите хранилище с поддержкой этого режима, например [{{ objstorage-name }} через CSI](../../managed-kubernetes/operations/volumes/s3-csi-integration.md). Также доступна [установка CSI для S3 из {{ marketplace-name }} или с помощью Helm](../../managed-kubernetes/operations/applications/csi-s3.md).

Подробнее о [режимах доступа к томам](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).
