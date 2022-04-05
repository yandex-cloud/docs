## Хранилище данных

#### Какие существуют особенности работы с дисковым хранилищем при размещении БД (MySQL, PostgreSQL и т. п.) в кластере {{ k8s }}? {#bd}

При размещении БД в кластере {{ k8s }} используйте контроллеры [StatefullSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). Мы не рекомендуем запускать в {{ k8s }} statefull-сервисы в постоянными томами. Для работы с базами данных statefull-сервисов используйте [управляемые базы данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), например {{ mmy-name }} или {{ mpg-name }}.

#### Как подключить под к управляемым базам данных {{ yandex-cloud }}? {#mdb}

Чтобы подключиться к [управляемой базе данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), расположенной в той же [сети](../../vpc/concepts/network.md#network), укажите [имя ее хоста и FQDN](../../compute/concepts/network.md#hostname).

Для подключения сертификата базы данных к [поду](../concepts/index.md#pod) используйте объекты типа `secret` или `configmap`.

#### Как правильно подключить постоянный том к контейнеру? {#persistent-volume}

Вы можете выбрать режим для подключения [дисков](../../compute/concepts/disk.md) {{ compute-name }} в зависимости от ваших нужд:
* Чтобы {{ k8s }} автоматически подготовил объект `PersistentVolume` и настроил новый диск, создайте под с [динамически подготовленным](../operations/volumes/dynamic-create-pv.md) томом.
* Чтобы использовать уже существующие диски {{ compute-name }}, создайте под со [статически подготовленным](../operations/volumes/static-create-pv.md) томом.

Подробнее читайте в разделе [Работа с постоянными томами](../concepts/volume.md#persistent-volume).

#### Какие типы томов поддерживает {{ managed-k8s-name }}? {#supported-volumes}

{{ managed-k8s-name }} поддерживает работу с временными (`Volume`) и постоянными (`PersistentVolume`) томами. Подробнее читайте в разделе [{#T}](../concepts/volume.md).