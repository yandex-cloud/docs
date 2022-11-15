# Настройка {{ dns-full-name }} для доступа к кластеру {{ mch-name }} из других облачных сетей

{% include [mdb-peering-intro](intro.md) %}

## Перед началом работы {#before-you-begin}

### Назначьте роли {#assign-roles}

{% include [mdb-peering-check-roles](check-roles.md) %}

### Создайте кластер {#create-cluster}

1. В командной строке перейдите в каталог, в котором будут расположены конфигурационные файлы {{ TF }} с планом инфраструктуры примера. Если такой директории нет — создайте ее.

1. Создайте кластер из нескольких хостов с помощью {{ TF }}, следуя [примеру](../../../managed-clickhouse/operations/cluster-create.md#creating-a-multi-host-cluster).

### Создайте прочие ресурсы {#create-other-resources}

{% include [mdb-peering-create-resources](create-resources.md) %}

### Настройте маршрутизацию между облачными сетями {#configure-routing}

{% include [mdb-peering-configure-routing](configure-routing.md) %}

### Проверьте доступность кластера (необязательный шаг) {#check-cluster-availability-without-dns}


1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальным машинам `cluster-vm` и `other-vm` по [SSH](../../../glossary/ssh-keygen.md).


    {% include [mdb-peering-vm-user](vm-user-warning.md) %}

1. Попытайтесь [подключиться к кластеру](../../../managed-clickhouse/operations/connect.md):

    {% include [mdb-peering-check-availability-1](check-availability-1.md) %}

## Создайте зону в {{ dns-full-name }} {#create-peering-zone}

{% include [mdb-peering-create-zone](create-zone.md) %}

## Обеспечьте миграцию DNS-записей в зону {#do-actions-for-migration}

{% include [mdb-peering-migrate-to-zone](migrate-to-zone.md) %}

## Проверьте доступность кластера {#check-cluster-availability}


1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к виртуальным машинам `cluster-vm` и `other-vm` по SSH.


    {% include [mdb-peering-vm-user](vm-user-warning.md) %}

1. Попытайтесь [подключиться к кластеру](../../../managed-clickhouse/operations/connect.md):

    {% include [mdb-peering-check-availability-2](check-availability-2.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [mdb-peering-destroy-resources](destroy-resources.md) %}
