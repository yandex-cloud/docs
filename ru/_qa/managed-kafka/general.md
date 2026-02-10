#### Как обеспечить высокую доступность кластера? {#cluster-fault-tolerance}

Выполните все [условия высокой доступности](../../managed-kafka/concepts/ha-cluster.md).

#### Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

Ошибка вызвана тем, что сегменты логов ваших топиков занимают больше места, чем есть в хранилище брокеров. Подробнее о расчете необходимого места см. в разделе [{#T}](../../managed-kafka/concepts/storage.md#minimal-storage-size).

Для решения проблемы можно [увеличить размер дискового хранилища](../../managed-kafka/operations/cluster-update.md#change-disk-size) или уменьшить размер сегмента для [топиков](../../managed-kafka/operations/cluster-topics.md#update-topic) или [всего кластера](../../managed-kafka/operations/cluster-update.md#change-kafka-settings).

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

#### Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва? {#get-ssl-error}

Полный текст ошибки:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
Это означает, что при подключении к веб-сайту не удалось проверить, есть ли его сертификат в списке отозванных.

Чтобы исправить ошибку:

* убедитесь, что проверку не блокируют настройки корпоративной сети;
* выполните команду с параметром `--ssl-no-revoke`.

   ```powershell
   mkdir $HOME\.kafka; curl.exe --ssl-no-revoke -o $HOME\.kafka\{{ crt-local-file }} {{ crt-web-path }}
   ```

#### Можно ли управлять кластером с помощью скриптов из дистрибутива {{ KF }}? {#script-apache-kafka}

Да, можно, но с ограничениями.

Подробнее о том, какие виды API доступны в кластере и какие для них есть ограничения, см. в разделе [{#T}](../../managed-kafka/concepts/available-apis.md).

Пример использования скриптов см. в разделе [{#T}](../../managed-kafka/operations/connect/clients.md).

#### Что делать, если возникает ошибка kafkacat: command not found? {#kafkacat-not-found}

На Ubuntu 24.04 и выше команда `kafkacat` не работает, используйте вместо нее команду `kcat`.

#### Будет ли доступен Karapace во время технического обслуживания? {#karapace-maintenance}

{% include [karapace-maintenance](../../_includes/mdb/mkf/karapace-maintenance.md) %}

#### Эндпоинт Karapace постоянный или меняется в зависимости от брокера? {#karapace-endpoint}

{% include [karapace](../../_includes/mdb/mkf/karapace.md) %}

#### Какую часть работы по управлению и сопровождению баз данных берет на себя {{ mkf-short-name }}? {#services}

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Как отследить потерю сообщений в топике {{ KF }}? {#lost-messages}

Если в топике используется политика очистки лога `Delete` с малым временем жизни сегмента, сообщения могут удаляться раньше, чем их прочитает [группа потребителей](../../managed-kafka/concepts/producers-consumers.md#consumer-groups). Отследить потерю сообщений можно с помощью [метрик](../../managed-kafka/metrics.md) сервиса {{ mkf-name }}, поставляемых в [{{ monitoring-name }}](../../monitoring/concepts/index.md).

Чтобы отследить потерю сообщений:

1. Используя сервис [{{ monitoring-full-name }}]({{ link-monitoring }}), [отобразите на одном графике](../../monitoring/operations/metric/metric-explorer.md#add-graph) метрики `kafka_group_topic_partition_offset` и `kafka_log_Log_LogStartOffset`:
   * Для `kafka_group_topic_partition_offset` укажите метки:
       * `service = managed-kafka`,
       * `name = kafka_group_topic_partition_offset`,
       * `host = <FQDN_хоста>`,
       * `topic = <имя_топика>`,
       * `partition = <номер_раздела>`,
       * `group = <имя_группы_потребителей>`.
   * Для `kafka_log_Log_LogStartOffset` укажите метки: 
       * `service = managed-kafka`,
       * `name = kafka_log_Log_LogStartOffset`,
       * `host = <FQDN_хоста>`,
       * `topic = <имя_топика>`,
       * `partition = <номер_раздела>`.
1. Подождите, пока в топик будет записано достаточно сообщений для анализа.
1. Перейдите в сервис [{{ monitoring-full-name }}]({{ link-monitoring }}) и проанализируйте поведение созданных ранее метрик:
   * Если значение `kafka_log_Log_LogStartOffset` больше `kafka_group_topic_partition_offset` на всем периоде наблюдения, выбранная группа потребителей успевает вычитывать все новые сообщения из указанного сегмента топика.
   * Если есть моменты времени, когда значение `kafka_group_topic_partition_offset` становится меньше `kafka_log_Log_LogStartOffset`, это указывает на потерю сообщений.

Подробнее см. в разделе [{#T}](../../managed-kafka/tutorials/retention-policy.md).

#### Какой размер блока используется на дисках кластера? {#block-size}

{% include [disk-block-size](../../_includes/mdb/disk-block-size.md) %}
