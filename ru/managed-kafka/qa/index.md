---
title: "{{ mkf-name }}. Ответы на вопросы"
description: "Как получить логи моей работы в управляемом сервисе Apache Kafka? Ответы на этот и другие вопросы в данной статье."
---

# Общие вопросы про {{ mkf-name }}

#### Как обеспечить отказоустойчивость кластера?

Выполните все [условия отказоустойчивости](../concepts/index.md#fault-tolerance).

#### Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

Ошибка вызвана тем, что сегменты логов ваших топиков занимают больше места, чем есть в хранилище брокеров. Подробнее о расчете необходимого места см. в разделе [{#T}](../concepts/storage.md#minimal-storage-size).

Для решения проблемы можно [увеличить размер дискового хранилища](../operations/cluster-update#change-disk-size) или уменьшить размер сегмента для [топиков](../operations/cluster-topics.md#update-topic) или [всего кластера](../operations/cluster-update.md#change-kafka-settings).

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Как мне перенести кластер в другую сеть?

Перенести кластер {{ mkf-name }} в другую сеть невозможно.

Альтернативное решение:

1. Создайте новый кластер аналогичной конфигурации в нужной сети.
1. Перенесите топики исходного кластера в новый кластер [с помощью MirrorMaker](../tutorials/kafka-connectors.md#kf-mirrormaker).

#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#disk-space-percentage}

[Создайте алерт](../../managed-kafka/operations/monitoring.md#monitoring-integration) с метрикой `disk.used_bytes` в сервисе {{ monitoring-full-name }}. Метрика показывает размер использованного дискового пространства в кластере {{ mkf-name }}.

Для `disk.used_bytes` используются пороги для оповещения. Их рекомендуемые значения:

* `Alarm` — 90% дискового пространства.
* `Warning` — 80% дискового пространства.

Значения порогов задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `Alarm` — `96636764160` байтов (90%).
* `Warning` — `85899345920` байтов (80%).
