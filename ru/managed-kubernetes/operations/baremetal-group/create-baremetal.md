---
title: Создание группы узлов на серверах {{ baremetal-name }}
description: Создайте группу узлов на серверах {{ baremetal-name }} в кластере {{ managed-k8s-name }}. Подготовьте сеть и выберите конфигурацию серверов.
---

# Создание группы узлов на серверах {{ baremetal-name }}

{% note info %}

Создавать, изменять и удалять группы узлов на серверах {{ baremetal-name }} можно только в консоли управления.

{% endnote %}

В кластере {{ managed-k8s-name }} можно создать [группу узлов](../../concepts/index.md#node-group) на выделенных серверах {{ baremetal-name }}. Сервис арендует серверы, автоматически настроит их и подключит к кластеру.

{% include [node-group-create-baremetal](../../../_includes/managed-kubernetes/node-group-create-baremetal.md) %}
