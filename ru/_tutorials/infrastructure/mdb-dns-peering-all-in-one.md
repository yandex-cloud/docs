# Настройка {{ dns-full-name }} для доступа к кластерам управляемых баз данных из других облачных сетей

{% include [mdb-peering-intro](../_tutorials_includes/mdb-dns-peering/intro.md) %}

## Перед началом работы {#before-you-begin}

### Назначьте роли {#assign-roles}

{% include [mdb-peering-check-roles](../_tutorials_includes/mdb-dns-peering/check-roles.md) %}

### Создайте кластер {#create-cluster}

1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры примера. Если такой директории нет — создайте ее.
1. Создайте кластер из нескольких хостов с помощью {{ TF }}, следуя примерам для нужного кластера:
   * [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-create.md#creating-a-multi-host-cluster).

### Создайте прочие ресурсы {#create-other-resources}

{% include [mdb-peering-create-resources](../_tutorials_includes/mdb-dns-peering/create-resources.md) %}

### Настройте маршрутизацию между облачными сетями {#configure-routing}

{% include [mdb-peering-configure-routing](../_tutorials_includes/mdb-dns-peering/configure-routing.md) %}

### Проверьте доступность кластера (необязательный шаг) {#check-cluster-availability-without-dns}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к [виртуальным машинам](../../compute/concepts/vm.md) `cluster-vm` и `other-vm` по [SSH](../../glossary/ssh-keygen.md).

   {% include [mdb-peering-vm-user](../_tutorials_includes/mdb-dns-peering/vm-user-warning.md) %}

1. Попытайтесь подключиться к кластеру:

   {% include [mdb-peering-check-availability-1](../_tutorials_includes/mdb-dns-peering/check-availability-1.md) %}

   {% include [mdb-peering-connect-all-in-one](../_tutorials_includes/mdb-dns-peering/mdb-connect-all-in-one.md) %}

## Создайте зону в {{ dns-name }} {#create-peering-zone}

{% include [mdb-peering-create-zone](../_tutorials_includes/mdb-dns-peering/create-zone.md) %}

## Обеспечьте миграцию DNS-записей в зону {#do-actions-for-migration}

{% include [mdb-peering-migrate-to-zone](../_tutorials_includes/mdb-dns-peering/migrate-to-zone.md) %}

## Проверьте доступность кластера {#check-cluster-availability}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ `cluster-vm` и `other-vm` по SSH.

   {% include [mdb-peering-vm-user](../_tutorials_includes/mdb-dns-peering/vm-user-warning.md) %}

1. Попытайтесь подключиться к кластеру:

   {% include [mdb-peering-check-availability-2](../_tutorials_includes/mdb-dns-peering/check-availability-2.md) %}

   {% include [mdb-peering-connect-all-in-one](../_tutorials_includes/mdb-dns-peering/mdb-connect-all-in-one.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [mdb-peering-destroy-resources](../_tutorials_includes/mdb-dns-peering/destroy-resources.md) %}