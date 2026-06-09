# Консоль управления BareMetal

[Консоль управления](../../console/index.md) представляет собой пользовательский [интерфейс](https://console.yandex.cloud), позволяющий управлять ресурсами сервиса Yandex BareMetal.

Консоль управления BareMetal состоит из следующих разделов:

#### ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **Серверы** {#servers}

Раздел позволяет [арендовать](../operations/servers/server-lease.md) серверы BareMetal, [изменять](../operations/servers/server-update.md) их основные настройки, [запускать, перезапускать и останавливать](../operations/servers/server-stop-and-start.md) серверы, [переустанавливать](../operations/servers/reinstall-os-from-marketplace.md) операционную систему серверов, а также [отказываться](../operations/servers/server-lease-cancel.md) от их аренды.

Кроме того, в этом разделе для каждого сервера BareMetal доступна [KVM-консоль](../operations/servers/server-kvm.md) — специальный интерфейс, позволяющий управлять сервером на уровне операционной системы, изменять [дополнительные настройки](server-advanced-settings.md) сервера, запускать его с загрузочных носителей и [устанавливать](../operations/servers/reinstall-os-from-own-image.md) на него операционные системы и другие программные продукты из [пользовательских образов](images.md#user-images).

Подробнее о серверах BareMetal читайте в разделе [Серверы](servers.md).

#### ![nodes-right](../../_assets/console-icons/nodes-right.svg) **Приватные подсети** {#subnets}

Раздел позволяет управлять [приватными подсетями](private-network.md#private-subnet) и их настройками.

Приватная подсеть — это [виртуальная сеть VLAN](https://ru.wikipedia.org/wiki/VLAN), объединяющая серверы BareMetal в одном [пуле серверов](servers.md#server-pools) на уровне L2 сетевой модели [OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI), физически изолированная от интернета и логически — от виртуальных сетей других пользователей.

Подробнее о приватных подсетях читайте в разделе [Приватная сеть](private-network.md).

#### ![vector-square](../../_assets/console-icons/vector-square.svg) **VRF** {#vrfs}

Раздел позволяет управлять [виртуальными сегментами сети](private-network.md#vrf-segment), [статическими маршрутами](private-network.md#static-routes) и [приватными соединениями](private-network.md#vrf-segment) с облачными сетями.

Виртуальные сегменты сети (VRF) используются для обеспечения сетевой связности на уровне L3 сетевой модели OSI. VRF позволяют обеспечить сетевую связность между серверами BareMetal, расположенными в разных пулах серверов, а также между серверами BareMetal и другими ресурсами Yandex Cloud.

Подробнее о виртуальных сегментах сети читайте в разделе [Виртуальный сегмент сети (VRF)](private-network.md#vrf-segment).

#### ![globe](../../_assets/console-icons/globe.svg) **Публичные адреса и подсети** {#public-ips}

Раздел позволяет [управлять](../operations/reserve-public-subnet.md) IP-адресами и подсетями в [публичной сети](public-network.md).

Публичная сеть обеспечивает доступ серверов BareMetal в интернет. Чтобы предоставить серверу доступ в интернет, назначьте ему публичный IP-адрес.

Подробнее о публичной сети и публичных подсетях читайте в разделе [Публичная сеть](public-network.md).

#### ![layers](../../_assets/console-icons/layers.svg) **Загрузочные образы** {#images}

Раздел позволяет загружать в BareMetal собственные [образы](images.md#user-images) операционных систем и программных продуктов и удалять их.

На серверы BareMetal вы можете устанавливать операционные системы и другие продукты из собственных образов. Для этого [загрузите](../operations/image-upload.md) ваш образ в Yandex BareMetal и запустите установку из этого образа с помощью KVM-консоли.

Подробнее о пользовательских образах читайте в разделе [Пользовательские образы](images.md#user-images).

#### ![list-check](../../_assets/console-icons/list-check.svg) **Операции** {#operations}

Раздел содержит информацию об [операциях](../../api-design-guide/concepts/about-async.md) с ресурсами сервиса Yandex BareMetal и их статусах.

При вызове любой операции, изменяющей состояние ресурса Yandex Cloud, создается объект `Operation`, который можно использовать для отслеживания состояния этой операции.

Подробнее об операциях в Yandex Cloud читайте в разделе [Работа с операциями](../../api-design-guide/concepts/about-async.md).