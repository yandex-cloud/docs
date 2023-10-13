---
title: "Как перенести виртуальную машину в другую зону доступности"
description: "Следуя данной инструкции, вы сможете перенести виртуальную машину в другую зону доступности."
---

# Перенести виртуальную машину в другую зону доступности

{% include [instance-az](../../_includes_service/instance-az.md) %}

## Создайте снимок каждого из дисков виртуальной машины {#create-snapshot}

### Подготовьте диски {#prepare-disks}

{% include [prepare-snapshots](../../../_includes/compute/prepare-snapshots.md) %}

### Создайте снимки {#create}

Чтобы [создать](../disk-control/create-snapshot.md) снимок диска:

{% include [create-snapshot](../../../_includes/compute/create-snapshot.md) %}

Аналогичным образом создайте снимки всех дисков.

## Создайте виртуальную машину в другой зоне доступности с дисками из снимков {#create-vm}

Чтобы [создать](../vm-create/create-from-snapshots.md) виртуальную машину в другой зоне доступности с дисками из снимков:

{% include [create-from-snapshot](../../../_includes/compute/create-from-snapshot.md) %}

## Удалите исходную виртуальную машину {#delete-vm}

Чтобы [удалить](vm-delete.md) исходную виртуальную машину:

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}
