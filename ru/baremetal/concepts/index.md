# Обзор сервиса {{ baremetal-full-name }}

{{ baremetal-full-name }} предоставляет возможность полностью [арендовать](../operations/servers/server-lease.md) физический сервер, выбрав его среди готовых, доступных к заказу, конфигураций.

Сервис позволяет удаленно установить операционную систему на сервер из заранее подготовленных [образов](./images.md) c {{ marketplace-short-name }} или [загрузить](../operations/image-upload.md) в {{ objstorage-full-name }} собственный образ и использовать его для установки. Доступ к серверу может осуществляться с помощью [KVM-консоли](../operations/servers/server-kvm.md) или через [SSH](../../glossary/ssh-keygen.md).

Все серверы имеют подключение к [публичной сети](./network.md#public-network) интернет и к [приватной сети](./network.md#private-network). В публичной сети можно резервировать [выделенные публичные подсети](./network.md#public-subnet). В приватной сети можно создавать [приватные подсети](./network.md#private-subnet) и [VRF](./network.md#vrf-segment), в которые можно объединять серверы, предназначенные для выполнения определенных типов задач.

## Серверы и сети {#concepts}

* [{#T}](./servers.md)
* [{#T}](./server-configurations.md)
* [{#T}](./smart-disk-analysis.md)
* [{#T}](./network.md)
* [{#T}](./dhcp.md)
* [{#T}](./network-restrictions.md)