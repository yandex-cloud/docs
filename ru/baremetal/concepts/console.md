---
title: Консоль управления {{ baremetal-full-name }}
description: В этом разделе вы узнаете о возможностях, которые предоставляет консоль управления {{ yandex-cloud }} при работе с серверами {{ baremetal-full-name }}.
---

# Консоль управления {{ baremetal-name }}

[Консоль управления](../../console/index.yaml) представляет собой пользовательский [интерфейс]({{ link-console-main }}), позволяющий управлять ресурсами сервиса {{ baremetal-full-name }}.

Консоль управления {{ baremetal-name }} состоит из следующих разделов:

#### ![objects-align-justify-horizontal](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.baremetal.label_servers_sCNgb }}** {#servers}

Раздел позволяет [арендовать](../operations/servers/server-lease.md) серверы {{ baremetal-name }}, [изменять](../operations/servers/server-update.md) их основные настройки, [запускать, перезапускать и останавливать](../operations/servers/server-stop-and-start.md) серверы, [переустанавливать](../operations/servers/reinstall-os-from-marketplace.md) операционную систему серверов, а также [отказываться](../operations/servers/server-lease-cancel.md) от их аренды.

Кроме того, в этом разделе для каждого сервера {{ baremetal-name }} доступна [KVM-консоль](../operations/servers/server-kvm.md) — специальный интерфейс, позволяющий управлять сервером на уровне операционной системы, изменять [дополнительные настройки](./server-advanced-settings.md) сервера, запускать его с загрузочных носителей и [устанавливать](../operations/servers/reinstall-os-from-own-image.md) на него операционные системы и другие программные продукты из [пользовательских образов](./images.md#user-images).

Подробнее о серверах {{ baremetal-name }} читайте в разделе [{#T}](./servers.md).

#### ![nodes-right](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks_uU4LH }}** {#subnets}

Раздел позволяет управлять [приватными подсетями](./private-network.md#private-subnet) и их настройками.

Приватная подсеть — это [виртуальная сеть VLAN](https://ru.wikipedia.org/wiki/VLAN), объединяющая серверы {{ baremetal-name }} в одном [пуле серверов](./servers#server-pools) на уровне L2 сетевой модели [OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI), физически изолированная от интернета и логически — от виртуальных сетей других пользователей.

Подробнее о приватных подсетях читайте в разделе [{#T}](./private-network.md).

#### ![vector-square](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** {#vrfs}

Раздел позволяет управлять [виртуальными сегментами сети](./private-network.md#vrf-segment), [статическими маршрутами](./private-network.md#static-routes) и [приватными соединениями](./private-network.md#vrf-segment) с облачными сетями.

Виртуальные сегменты сети (VRF) используются для обеспечения сетевой связности на уровне L3 сетевой модели OSI. VRF позволяют обеспечить сетевую связность между серверами {{ baremetal-name }}, расположенными в разных пулах серверов, а также между серверами {{ baremetal-name }} и другими ресурсами {{ yandex-cloud }}.

Подробнее о виртуальных сегментах сети читайте в разделе [{#T}](./private-network.md#vrf-segment).

#### ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets_v16CV }}** {#public-ips}

Раздел позволяет [управлять](../operations/reserve-public-subnet.md) IP-адресами и подсетями в [публичной сети](./public-network.md).

Публичная сеть обеспечивает доступ серверов {{ baremetal-name }} в интернет. Чтобы предоставить серверу доступ в интернет, назначьте ему публичный IP-адрес.

Подробнее о публичной сети и публичных подсетях читайте в разделе [{#T}](./public-network.md).

#### ![layers](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images_duoXD }}** {#images}

Раздел позволяет загружать в {{ baremetal-name }} собственные [образы](./images.md#user-images) операционных систем и программных продуктов и удалять их.

На серверы {{ baremetal-name }} вы можете устанавливать операционные системы и другие продукты из собственных образов. Для этого [загрузите](../operations/image-upload.md) ваш образ в {{ baremetal-full-name }} и запустите установку из этого образа с помощью KVM-консоли.

Подробнее о пользовательских образах читайте в разделе [{#T}](./images.md#user-images).

#### ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** {#operations}

Раздел содержит информацию об [операциях](../../api-design-guide/concepts/about-async.md) с ресурсами сервиса {{ baremetal-full-name }} и их статусах.

При вызове любой операции, изменяющей состояние ресурса {{ yandex-cloud }}, создается объект `Operation`, который можно использовать для отслеживания состояния этой операции.

Подробнее об операциях в {{ yandex-cloud }} читайте в разделе [{#T}](../../api-design-guide/concepts/about-async.md).