# Общие вопросы про Managed Service for Apache Kafka®

* [Как обеспечить высокую доступность кластера?](#cluster-fault-tolerance)

* [Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."?](#disk-size)

* [Я могу получить логи моей работы в сервисах?](#logs)

* [Как долго хранятся логи?](#log-keeping)

* [Как мне перенести кластер в другую сеть?](#move-cluster)

* [Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства?](#disk-space-percentage)

* [Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела?](#throttling)

* [Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя?](#connect-ssh)

* [Что делать, если при получении SSL-сертификата через PowerShell возникает ошибка проверки отзыва?](#get-ssl-error)

* [Можно ли управлять кластером с помощью скриптов из дистрибутива Apache Kafka®?](#script-apache-kafka)

* [Что делать, если возникает ошибка kafkacat: command not found?](#kafkacat-not-found)

* [Что делать, если возникает ошибка аутентификации при подключении через kafkacat?](#kafkacat-authentication-error)

* [Будет ли доступен Karapace во время технического обслуживания?](#karapace-maintenance)

* [Эндпоинт Karapace постоянный или меняется в зависимости от брокера?](#karapace-endpoint)

* [Какую часть работы по управлению и сопровождению баз данных берет на себя Managed Service for Apache Kafka®?](#services)

* [Как отследить потерю сообщений в топике Apache Kafka®?](#lost-messages)

* [Какой размер блока используется на дисках кластера?](#block-size)

* [Какая версия коннектора MirrorMaker поддерживается в Managed Service for Apache Kafka®?](#mirrormaker-version)

#### Как обеспечить высокую доступность кластера? {#cluster-fault-tolerance}

Выполните все [условия высокой доступности](../concepts/ha-cluster.md).

#### Что делать, если я получаю ошибку вида "disk size must be at least ... according to topics partitions number and replication factor, but size is ..."? {#disk-size}

Ошибка вызвана тем, что сегменты логов ваших топиков занимают больше места, чем есть в хранилище брокеров. Подробнее о расчете необходимого места см. в разделе [Минимальный размер хранилища](../concepts/storage.md#minimal-storage-size).

Для решения проблемы можно [увеличить размер дискового хранилища](../operations/cluster-update.md#change-disk-size) или уменьшить размер сегмента для [топиков](../operations/cluster-topics.md#update-topic) или [всего кластера](../operations/cluster-update.md#change-kafka-settings).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Как долго хранятся логи? {#log-keeping}

Логи кластера хранятся 45 дней.

#### Как мне перенести кластер в другую сеть? {#move-cluster}

Перенести кластер Managed Service for Apache Kafka® в другую сеть невозможно.


Альтернативное решение:

1. Создайте новый кластер аналогичной конфигурации в нужной сети.
1. Перенесите топики исходного кластера в новый кластер [с помощью MirrorMaker](../tutorials/kafka-connectors.md#kf-mirrormaker).


#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#disk-space-percentage}

[Создайте алерт](../operations/monitoring.md#monitoring-integration) с метрикой `disk.used_bytes` в сервисе Yandex Monitoring. Метрика показывает размер использованного дискового пространства в кластере Managed Service for Apache Kafka®.

Для `disk.used_bytes` используются пороги для оповещения. Их рекомендуемые значения:

* `Alarm` — 90% дискового пространства.
* `Warning` — 80% дискового пространства.

Значения порогов задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `Alarm` — `96636764160` байт (90%).
* `Warning` — `85899345920` байт (80%).

#### Почему кластер работает медленно, хотя вычислительные ресурсы использованы не до предела? {#throttling}

Вероятно, максимальные значения [IOPS и пропускной способности (bandwidth)](../../compute/concepts/storage-read-write.md) хранилища недостаточны для обработки текущего количества запросов. В этом случае срабатывает [троттлинг](../../compute/concepts/storage-read-write.md#throttling) и быстродействие всего кластера падает.

Максимальные IOPS и bandwidth прирастают на фиксированную величину при увеличении размера хранилища на определенный шаг. Шаг и прирост зависят от типа дисков:

| Тип дисков                  | Шаг, ГБ | Прирост макс. IOPS (чтение/запись) | Прирост макс. bandwidth (чтение/запись), МБ/с |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-hdd`               | 256     | 300/300                            | 30/30                                         |
| `network-ssd`               | 32      | 1000/1000                          | 15/15                                         |
| `network-ssd-nonreplicated`, `network-ssd-io-m3` | 93      | 28000/5600                         | 110/82                                        |

Чтобы увеличить максимальные значения IOPS и bandwidth и снизить вероятность троттлинга, [расширьте размер хранилища](../operations/storage-space.md#change-disk-size).

#### Можно ли подключиться к хостам кластера по SSH или получить на хостах права суперпользователя? {#connect-ssh}

Подключиться к хостам через SSH не получится. Это сделано в целях безопасности и отказоустойчивости пользовательских кластеров, так как прямые изменения внутри хоста могут привести к его полной неработоспособности.

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
   mkdir $HOME\.kafka; curl.exe --ssl-no-revoke -o $HOME\.kafka\YandexInternalRootCA.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
   ```

#### Можно ли управлять кластером с помощью скриптов из дистрибутива Apache Kafka®? {#script-apache-kafka}

Да, можно, но с ограничениями.

Подробнее о том, какие виды API доступны в кластере и какие для них есть ограничения, см. в разделе [API в Managed Service for Apache Kafka®](../concepts/available-apis.md).

Пример использования скриптов см. в разделе [Подключение к кластеру Apache Kafka® из приложений](../operations/connect/clients.md).

#### Что делать, если возникает ошибка kafkacat: command not found? {#kafkacat-not-found}

На Ubuntu 24.04 и выше команда `kafkacat` не работает, используйте вместо нее команду `kcat`.

#### Что делать, если возникает ошибка аутентификации при подключении через kafkacat? {#kafkacat-authentication-error}

Текст ошибки:

```text
SASL authentication error: Authentication failed during authentication due to invalid credentials with SASL mechanism SCRAM-SHA-512
```

Ошибка возникает при попытке подключиться через `kafkacat` к кластеру с версией Apache Kafka® 4.0 и выше. Утилита `kafkacat` устарела и не работает с новыми версиями. Если ваш кластер с версией Apache Kafka® 4.0 или выше, используйте утилиту [kafkactl](../operations/connect/clients.md#kafkactl).

#### Будет ли доступен Karapace во время технического обслуживания? {#karapace-maintenance}

Сервис [Karapace](https://github.com/Aiven-Open/karapace) недоступен во время технического обслуживания и автоматически запускается после его завершения. При этом данные схем сохраняются, так как они размещены в [служебном топике](../concepts/topics.md#service-topics) `__schema_registry`.

#### Эндпоинт Karapace постоянный или меняется в зависимости от брокера? {#karapace-endpoint}

Karapace разворачивается на каждом хосте-брокере на отдельном порте, при этом ему доступен собственный эндпоинт для подключения. При удалении брокера соответствующий эндпоинт становится недоступен.

#### Какую часть работы по управлению и сопровождению баз данных берет на себя Managed Service for Apache Kafka®? {#services}

При работе необходимо учитывать, что контролирует сервис, а что — клиент Yandex Cloud. Понимание этих зон контроля помогает эффективно использовать облачные ресурсы и избегать возможных проблем при работе с базами данных. Подробнее в разделе [Разграничение зон контроля пользователей сервисов управляемых баз данных (MDB) и Yandex Cloud](../../overview/concepts/mdb-responsibilities.md).

#### Как отследить потерю сообщений в топике Apache Kafka®? {#lost-messages}

Если в топике используется политика очистки лога `Delete` с малым временем жизни сегмента, сообщения могут удаляться раньше, чем их прочитает [группа потребителей](../concepts/producers-consumers.md#consumer-groups). Отследить потерю сообщений можно с помощью [метрик](../metrics.md) сервиса Managed Service for Apache Kafka®, поставляемых в [Monitoring](../../monitoring/concepts/index.md).

Чтобы отследить потерю сообщений:

1. Используя сервис [Yandex Monitoring](https://monitoring.yandex.cloud), [отобразите на одном графике](../../monitoring/operations/metric/metric-explorer.md#add-graph) метрики `kafka_group_topic_partition_offset` и `kafka_log_Log_LogStartOffset`:
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
1. Перейдите в сервис [Yandex Monitoring](https://monitoring.yandex.cloud) и проанализируйте поведение созданных ранее метрик:
   * Если значение `kafka_log_Log_LogStartOffset` больше `kafka_group_topic_partition_offset` на всем периоде наблюдения, выбранная группа потребителей успевает вычитывать все новые сообщения из указанного сегмента топика.
   * Если есть моменты времени, когда значение `kafka_group_topic_partition_offset` становится меньше `kafka_log_Log_LogStartOffset`, это указывает на потерю сообщений.

Подробнее см. в разделе [Отслеживание потери сообщений в топике Apache Kafka®](../tutorials/retention-policy.md).

#### Какой размер блока используется на дисках кластера? {#block-size}

Размер [блока](https://en.wikipedia.org/wiki/Block_(data_storage)) всех типов дисков — 4 КБ.

#### Какая версия коннектора MirrorMaker поддерживается в Managed Service for Apache Kafka® {#mirrormaker-version}

В сервисе Managed Service for Apache Kafka® поддержан **MirrorMaker** версии 2.