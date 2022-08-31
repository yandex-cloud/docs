# История изменений в {{ mkf-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.08.2022 {#01.08.2022}

* Ускорены операции по изменению прав пользователей при большом количестве топиков.
* Добавлена поддержка настроек `message.max.bytes`, `offsets.retention.minutes`, `replica.fetch.max.bytes` и `ssl.cipher.suites`. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Добавлена возможность создания кластера на локальных дисках на платформе Intel Ice Lake.
* Исправлен расчет метрики `kafka_group_topic_partition_lag`. {% if audience != "internal" %} Подробнее см. в [справочнике метрик {{ monitoring-full-name }}](https://cloud.yandex.ru/docs/monitoring/metrics-ref/#managed-kafka). {% endif %}
* Новая версия {{ KF }} 3.2 доступна в окружении `PRODUCTION`. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## 01.07.2022 {#01.07.2022}

* Доступен новый коннектор: [S3 Sink](concepts/connectors.md#s3-sink). {{ tag-con }}
* Новая версия {{ KF }} 3.1 доступна в окружении `PRODUCTION`. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

## 01.06.2022 {#01.06.2022}

* Новая версия {{ KF }} 3.1 доступна в окружении `PRESTABLE`. {{ tag-con }} {{ tag-cli }} {{ tag-tf }}
* Добавлена возможность загружать SSL-сертификат для соединения с кластером через коннектор MirrorMaker. {{ tag-con }}
* Добавлена поддержка офлайн-обслуживания.

## 01.05.2022 {#01.05.2022}

* Добавлена возможность изменять настройку публичного доступа в CLI. {{ tag-cli }}.
* Запрещено использование флага `preallocate`, провоцирующего `CorruptRecordException` (см. тикет [KAFKA-13664](https://issues.apache.org/jira/browse/KAFKA-13664)).
* Добавлена поддержка стандартного сжатия (zstd) для реестра схем (schema registry).

## 01.04.2022 {#01.04.2022}

* Доступна новая версия {{ KF }} 3.0.
