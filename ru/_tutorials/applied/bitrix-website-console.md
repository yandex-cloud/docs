1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#create-network).
1. [Создайте ВМ в облаке](#create-vm).
1. [Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте сервер для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [bitrix-website-paid-resources](../_tutorials_includes/bitrix-website-paid-resources.md) %}

## Создайте и настройте облачную сеть {#create-network}

{% include [bitrix-setup-network](../_tutorials_includes/bitrix-setup-network.md) %}

## Создайте ВМ в облаке {#create-vm}

{% include [bitrix-create-vm](../_tutorials_includes/bitrix-create-vm.md) %}

## Создайте кластер БД {{ MY }} {#create-mysql}

{% include [bitrix-create-mysql-cluster](../_tutorials_includes/bitrix-create-mysql-cluster.md) %}

## Настройте сервер для работы с «1C-Битрикс» {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Настройте «1С-Битрикс» {#configure-bitrix}

{% include [bitrix-website-configure-bitrix](../_tutorials_includes/bitrix-website-configure-bitrix.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `bitrixwebsite`.
  1. [Удалите](../../managed-mysql/operations/cluster-delete.md) кластер БД `Bitrix{{ MY }}`.
  1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.

{% endlist %}