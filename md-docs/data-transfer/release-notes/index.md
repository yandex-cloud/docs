<!-- Changelog begin -->

{% changelog %}
```
date: 2025-12
index: 2
```

### Удобный фильтр трансферов

![image](../../_assets/data-transfer/changelogs/transfer-filter.png)

Длинный список трансферов? Отфильтруйте только нужные по доступным параметрам:
* имя эндпоинта или трансфера;
* тип базы данных источника и приёмника;
* тип трансфера;
* стадия, на которой находится трансфер.

{% endchangelog %}

{% changelog %}
```
date: 2025-11
index: 1
```

### Трансфер данных из Managed Service for YDB в PostgreSQL

Воспользуйтесь новой комбинацией эндпоинтов для передачи данных из Managed Service for YDB в PostgreSQL. Больше информации о поддерживаемых парах источников и приёмников данных в [матрице трансферов](../transfer-matrix.md).

{% endchangelog %}

<!-- Changelog end -->


# История изменений Data Transfer

## 2026 год {#2026}

### Май {#may26}

#### Новые возможности и улучшения {#new-features-may26}

* Поддержан новый [эндпоинт приемник Apache Iceberg™](../operations/endpoint/target/iceberg.md).

* В эндпоинтах ![greenplum](../../_assets/data-transfer/icons/greenplum-icon.svg) Greenplum® поддержана работа с СУБД [Apache Cloudberry™](https://cloudberry.apache.org/).

### Апрель {#apr26}

#### Новые возможности и улучшения {#new-features-apr26}

* Поддержан перенос нетабличных объектов [Greenplum®](../operations/endpoint/source/greenplum.md) (функции, последовательности, индексы).

* Поддержано сжатие на уровне формата данных для Parquet при записи в приемник [Object Storage](../operations/endpoint/target/object-storage.md).


* Поддержана запись из [Data Streams](../operations/endpoint/source/data-streams.md) в [OpenSearch](../operations/endpoint/target/opensearch.md).


### Март {#mar26}

#### Новые возможности и улучшения {#new-features-mar26}

* Поддержан формат данных nginx для источника данных [Object Storage](../operations/endpoint/source/object-storage.md).

* Изменен формат имени создаваемого объекта в приемнике [Object Storage](../operations/endpoint/target/object-storage.md): part-<таймстамп>-<хеш(partID)>.<счетчик>.<тип_файла>.

  * таймстамп — `timestamp` по идентификатору операции;
  * хеш(partID) — `UUID`, сгенерированный на основе `partID`;
  * счетчик — инкрементируемый счетчик;
  * тип_файла — расширение файла (`csv`, `parquet`, `json`, `proto` и `nginx`).

* Для трансферов типа **Копирование** из источников [PostgreSQL](../operations/endpoint/source/postgresql.md) всегда поддержано чтение данных из родительской таблицы, если она присутствует в списке таблиц на эндпоинте или трансфере.

* Для источников YDB, Apache Kafka® и YDS поддержан новый тип конвертации данных `Raw-to-table`, позволяет поставлять сырые данные из очереди сообщений.


### Февраль {#feb26}

#### Новые возможности {#new-features-feb26}

* Ускорен в несколько раз перенос данных при копировании из [PostgreSQL](../operations/endpoint/source/postgresql.md) в [PostgreSQL](../operations/endpoint/target/postgresql.md).
* Улучшен перенос схемы БД для трансферов из [PostgreSQL](../operations/endpoint/source/postgresql.md) в [PostgreSQL](../operations/endpoint/target/postgresql.md). Сущности переносятся в порядке зависимости друг от друга.


* Для стадии копирования будет выделяться не более 64 виртуальных машин.


#### Решенные проблемы {#problems-solved-feb26}

* Улучшена стабильность трансферов из [Apache Kafka®](../operations/endpoint/source/kafka.md).
* Исправлена отправка метрик в Monitoring для [источника Oracle](../operations/endpoint/source/oracle.md).
* Исправлена проблема передачи данных из [PostgreSQL](../operations/endpoint/source/postgresql.md) в [PostgreSQL](../operations/endpoint/target/postgresql.md), когда при указании списка таблиц на уровне трансфера (не в эндпоинте) переносилась вся схема целиком.
* Устранен множественный перезапуск трансфера при одновременном изменении настроек эндпоинтов и трансфера через API и Terraform.
* Для [приемника Managed Service for YDB](../operations/endpoint/target/yandex-database.md) исправлена проблема с очисткой таблиц.
* Исправлена проблема с зависанием или повторной поставкой большого количества данных в репликациях из [Managed Service for YDB](../operations/endpoint/source/ydb.md).
* Исправлена проблема с переносом удалений в ClickHouse® при наличии некоторых специфичных типов в колонках (например, UUID).



### Январь {#jan26}

 В настройках источников данных [Apache Kafka®](../operations/endpoint/source/kafka.md) и [Data Streams](../operations/endpoint/source/data-streams.md) теперь можно указывать параметры подключения к [Schema Registry](../../metadata-hub/concepts/schema-registry.md).

{% cut "2025 год" %}{#2025}

- [Декабрь 2025](2512.md)
- [Ноябрь 2025](2511.md)
- [Октябрь 2025](2510.md)
- [Сентябрь 2025](2509.md)
- [Август 2025](2508.md)
- [Июль 2025](2507.md)
- [Июнь 2025](2506.md)
- [Май 2025](2505.md)
- [Апрель 2025](2504.md)
- [Март 2025](2503.md)
- [Февраль 2025](2502.md)
- [Январь 2025](2501.md)

{% endcut %}

{% cut "2024 год" %}{#2024}

- [Декабрь 2024](2412.md)
- [Ноябрь 2024](2411.md)
- [Октябрь 2024](2410.md)
- [Сентябрь 2024](2409.md)
- [Август 2024](2408.md)
- [Июль 2024](2407.md)
- [Июнь 2024](2406.md)
- [Май 2024](2405.md)
- [Апрель 2024](2404.md)
- [Март 2024](2403.md)
- [Февраль 2024](2402.md)
- [Январь 2024](2401.md)

{% endcut %}

{% cut "2023 год" %}{#2023}

- [Декабрь 2023](2312.md)
- [Ноябрь 2023](2311.md)
- [Октябрь 2023](2310.md)
- [Сентябрь 2023](2309.md)
- [Август 2023](2308.md)

{% endcut %}