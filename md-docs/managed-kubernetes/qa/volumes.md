[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Вопросы и ответы > Хранилище данных

# Хранилище данных

* [Какие существуют особенности работы с дисковым хранилищем при размещении БД (MySQL®, PostgreSQL и т. д.) в кластере Kubernetes?](#bd)

* [Как подключить под к управляемым базам данных Yandex Cloud?](#mdb)

* [Как правильно подключить постоянный том к контейнеру?](#persistent-volume)

* [Какие типы томов поддерживает Managed Service for Kubernetes?](#supported-volumes)

* [Почему возникает ошибка Multi-Attach error for volume?](#multi-attach)

#### Какие существуют особенности работы с дисковым хранилищем при размещении БД (MySQL®, PostgreSQL и т. д.) в кластере Kubernetes? {#bd}

При размещении БД в кластере Kubernetes используйте контроллеры [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). Мы не рекомендуем запускать в Kubernetes stateful-сервисы с постоянными томами. Для работы с базами данных stateful-сервисов используйте [управляемые базы данных Yandex Cloud](https://yandex.cloud/ru/services#data-platform), например Managed Service for MySQL® или Managed Service for PostgreSQL.

#### Как подключить под к управляемым базам данных Yandex Cloud? {#mdb}

Чтобы подключиться к [управляемой базе данных Yandex Cloud](https://yandex.cloud/ru/services#data-platform), расположенной в той же [сети](../../vpc/concepts/network.md#network), укажите [имя ее хоста и FQDN](../../compute/concepts/network.md#hostname).

Для подключения сертификата базы данных к [поду](../concepts/index.md#pod) используйте объекты типа `secret` или `configmap`.

#### Как правильно подключить постоянный том к контейнеру? {#persistent-volume}

Вы можете выбрать режим для подключения [дисков](../../compute/concepts/disk.md) Compute Cloud в зависимости от ваших нужд:
* Чтобы Kubernetes автоматически подготовил объект `PersistentVolume` и настроил новый диск, создайте под с [динамически подготовленным](../operations/volumes/dynamic-create-pv.md) томом.
* Чтобы использовать уже существующие диски Compute Cloud, создайте под со [статически подготовленным](../operations/volumes/static-create-pv.md) томом.

Подробнее читайте в разделе [Работа с постоянными томами](../concepts/volume.md#persistent-volume).

#### Какие типы томов поддерживает Managed Service for Kubernetes? {#supported-volumes}

Managed Service for Kubernetes поддерживает работу с временными (`Volume`) и постоянными (`PersistentVolume`) томами. Подробнее читайте в разделе [Том](../concepts/volume.md).

#### Почему возникает ошибка `Multi-Attach error for volume`? {#multi-attach}

Сетевой диск, на котором основан постоянный том, можно подключить только к одному узлу одновременно. Ошибка `Multi-Attach error for volume` возникает, когда Kubernetes пытается подключить том к узлу, пока том еще подключен к другому узлу. Например, это происходит, если поды используют один PVC, но размещены на разных узлах. Несколько подов на одном узле могут использовать один том в режиме `ReadWriteOnce`.

Проверьте размещение подов, использующих PVC, и события подключения тома. Если приложению нужен доступ с нескольких узлов в режиме `ReadWriteMany`, выберите хранилище с поддержкой этого режима, например [Object Storage через CSI](../operations/volumes/s3-csi-integration.md). Также доступна [установка CSI для S3 из Cloud Marketplace или с помощью Helm](../operations/applications/csi-s3.md).

Подробнее о [режимах доступа к томам](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).