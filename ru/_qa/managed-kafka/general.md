#### Как обеспечить отказоустойчивость кластера? {#cluster-fault-tolerance}

Выполните все [условия отказоустойчивости](../../managed-kafka/concepts/index.md#fault-tolerance).

#### Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

Ошибка вызвана тем, что сегменты логов ваших топиков занимают больше места, чем есть в хранилище брокеров. Подробнее о расчете необходимого места см. в разделе [{#T}](../../managed-kafka/concepts/storage.md#minimal-storage-size).

Для решения проблемы можно [увеличить размер дискового хранилища](../../managed-kafka/operations/cluster-update#change-disk-size) или уменьшить размер сегмента для [топиков](../../managed-kafka/operations/cluster-topics.md#update-topic) или [всего кластера](../../managed-kafka/operations/cluster-update.md#change-kafka-settings).

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Как мне перенести кластер в другую сеть? {#move-cluster}

Перенести кластер {{ mkf-name }} в другую сеть невозможно.

Альтернативное решение:

1. Создайте новый кластер аналогичной конфигурации в нужной сети.
1. Перенесите топики исходного кластера в новый кластер [с помощью MirrorMaker](../../managed-kafka/tutorials/kafka-connectors.md#kf-mirrormaker).

#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#disk-space-percentage}

[Создайте алерт](../../managed-kafka/operations/monitoring.md#monitoring-integration) с метрикой `disk.used_bytes` в сервисе {{ monitoring-full-name }}. Метрика показывает размер использованного дискового пространства в кластере {{ mkf-name }}.

Для `disk.used_bytes` используются пороги для оповещения. Их рекомендуемые значения:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — 90% дискового пространства.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — 80% дискового пространства.

Значения порогов задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байт (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байт (80%).

#### Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела? {#throttling}

{% include [throttling](../throttling.md) %}

Чтобы увеличить максимальные значения IOPS и bandwidth и снизить вероятность троттлинга, [расширьте размер хранилища](../../managed-kafka/operations/storage-space.md#change-disk-size).
