---
title: "{{ mkf-name }}. Ответы на вопросы"
description: "Как получить логи моей работы в управляемом сервисе Apache Kafka? Ответы на этот и другие вопросы в данной статье."
---

# Общие вопросы про {{ mkf-name }}

#### Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

Ошибка вызвана тем, что сегменты логов ваших топиков занимают больше места, чем есть в хранилище брокеров. Подробнее о расчете необходимого места см. в разделе [{#T}](../concepts/storage.md#minimal-storage-size).

Для решения проблемы можно [увеличить размер дискового хранилища](../operations/cluster-update#change-disk-size) или уменьшить размер сегмента для [топиков](../operations/cluster-topics.md#update-topic) или [всего кластера](../operations/cluster-update.md#change-kafka-settings).

{% include [logs](../../_qa/logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}
