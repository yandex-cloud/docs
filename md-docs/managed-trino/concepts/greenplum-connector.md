[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Trino](../index.md) > [Концепции](index.md) > Коннектор Greenplum®

# Коннектор Greenplum®/Cloudberry

[Коннектор](index.md#connector) Greenplum®/Cloudberry, разработанный Яндексом на основе [коннектора PostgreSQL](https://trino.io/docs/current/connector/postgresql.html), позволяет Managed Service for Trino читать и записывать данные в кластер Greenplum®/Cloudberry.

Коннектор поддерживает [параллельное чтение данных](#parallel-reading) сразу с нескольких сегментов Greenplum® и [чтение данных напрямую с сегментов](#gpfdist-reading) по протоколу GPFDIST, что значительно увеличивает производительность запросов при чтении больших объемов данных. Оба способа чтения данных можно применять одновременно, чтобы наиболее эффективно использовать ресурсы кластера Trino и кластера Greenplum®.

Коннектор Greenplum®/Cloudberry доступен в Trino версии `476` и выше.

## Параллельное чтение данных {#parallel-reading}

При параллельном чтении из таблицы данные разделяются по значению метаколонки `gp_segment_id`.

Уровень параллелизма определяется количеством сегментов в кластере Greenplum®. Максимальный уровень параллелизма ограничен [настройкой коннектора](#settings) `greenplum.max-read-parallelism` и соответствующим свойством сессии `max_read_parallelism`.

Схематично параллельное чтение представлено на диаграмме:

```mermaid
sequenceDiagram
    participant w1 as Trino Worker 1
    participant w2 as Trino Worker 2
    participant m as Greenplum Master
    participant s1 as Greenplum Segment 1
    participant s2 as Greenplum Segment 2

    par Parallel data reading
        rect rgba(0, 128, 255, 0.25)
            w1 ->> m : SELECT WHERE gp_segment_id % 2 = 0
            activate m
            m ->> s1 : read data
            activate s1
            s1 -->> m : data
            deactivate s1
            m -->> w1 : data
            deactivate m
        end
    and
        rect rgba(0, 128, 255, 0.25)
            w2 ->> m : SELECT WHERE gp_segment_id % 2 = 1
            activate m
            m ->> s2 : read data
            activate s2
            s2 -->> m : data
            deactivate s2
            m -->> w2 : data
            deactivate m
        end
    end
```

При использовании параллельного чтения коннектор выполняет только частичную фильтрацию строк при выталкивании оператора `LIMIT` ([limit pushdown](https://trino.io/docs/current/optimizer/pushdown.html#limit-pushdown)). Это не влияет на корректность результатов запроса.

## Чтение данных по протоколу GPFDIST {#gpfdist-reading}

Коннектор позволяет читать данные напрямую с сегментов Greenplum® через серверы [GPFDIST](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/utility_guide-ref-gpfdist.html), созданные на воркерах Trino. Включение серверов GPFDIST контролируется [настройкой коннектора](#settings) `greenplum.gpfdist.server.enabled`.

В кластере Trino можно создать не больше восьми каталогов с включенными GPFDIST-серверами.

Чтение данных напрямую с сегментов Greenplum® состоит из следующих этапов:

1. Коннектор создает внешнюю таблицу с указанием адреса воркера Trino, читающего данные:

    ```sql
    CREATE WRITABLE EXTERNAL TEMPORARY TABLE <имя_внешней_таблицы>
           ...
           LOCATION('gpfdist://<адрес_воркера_Trino>');
    ```

1. Коннектор выполняет запрос:

    ```sql
    INSERT INTO <имя_внешней_таблицы>
    SELECT ... FROM <имя_таблицы_в_Greenplum®>;
    ```

1. Сегменты Greenplum® отправляют данные воркеру Trino на указанный адрес.

Схематично чтение данных с сегментов представлено на диаграмме:

```mermaid
sequenceDiagram
    participant w1 as Trino Worker
    participant m as Greenplum Master
    participant s1 as Greenplum Segment 1
    participant s2 as Greenplum Segment 2

    activate w1
    w1 ->> m : CREATE WRITABLE EXTERNAL TABLE ext_table <br>LOCATION ('gpfdist://worker1/table1')
    activate m
    m -->> w1 : OK
    deactivate m

    w1 ->> m : INSERT INTO ext_table SELECT ...
    activate m

    par Reading data from segments
    m ->> s1 : send data to LOCATION
    activate s1
    rect rgba(0, 128, 255, 0.25)
        loop Reading data from segment
            s1 ->> w1 : POST /ext_table {CSV}
            activate w1
            w1 -->> s1 : OK
            deactivate w1
        end
    end
    s1 -->> m : OK
    deactivate s1
    and
    m ->> s2 : send data to LOCATION
    activate s2
    rect rgba(0, 128, 255, 0.25)
        loop Reading data from segment
            s2 ->> w1 : POST /ext_table {CSV}
            activate w1
            w1 -->> s2 : OK
            deactivate w1
        end
    end
    s2 -->> m : OK
    deactivate s2
    end
    m -->> w1 : OK
    deactivate m
    deactivate w1
```

Использование протокола GPFDIST для чтения данных вносит следующие ограничения в работу коннектора:

* Не поддерживается чтение многомерных массивов.
* Не поддерживается чтение массивов строковых типов.
* Не поддерживается режим обработки массивов [AS_JSON](https://trino.io/docs/current/connector/postgresql.html#array-type-handling).
* При одновременном выталкивании операторов `LIMIT` и `ORDER BY` ([Top-N pushdown](https://trino.io/docs/current/optimizer/pushdown.html#top-n-pushdown)) коннектор выполняет только частичную сортировку данных. Это не влияет на корректность результатов запроса.

## Настройки коннектора {#settings}

Базовые настройки коннектора и соответствующие им свойства сессии совпадают с [коннектором PostgreSQL](https://trino.io/docs/current/connector/postgresql.html) соответствующей версии. Кроме этого доступны следующие настройки:

| Настройка                                  | Описание                                                                                                                                                                                                                                                                                                                                                                                                            | Значение<br/>по умолчанию     |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| `greenplum.gpfdist.server.enabled`         | Включает GPFDIST-серверы на воркерах Trino                                                                                                                                                                                                                                                                                                                                                                       | `false`                       |
| `greenplum.gpfdist.max-processing-threads` | Максимальный размер пула потоков, производящих асинхронную обработку GPFDIST-запросов                                                                                                                                                                                                                                                                                                                               | `32`                          |
| `greenplum.gpfdist.max-query-threads`      | Максимальный размер пула потоков, создающих внешние таблицы Greenplum® и инициирующих запись данных во внешнюю таблицу                                                                                                                                                                                                                                                                                                | `32`                          |
| `greenplum.gpfdist.read.enabled`           | Включает чтение данных напрямую с сегментов Greenplum® по протоколу GPFDIST                                                                                                                                                                                                                                                                                                                                           | `false`                       |
| `greenplum.gpfdist.read.buffer-size`       | <p>Размер буфера для чтения данных по протоколу GPFDIST в формате [data size](https://trino.io/docs/current/admin/properties.html#data-size). В случае переполнения буфера коннектор приостанавливает прием данных от сегментов Greenplum®.</p><p>Соответствует свойству сессии `gpfdist_read_buffer_size`</p>                                                                                                                        | `32MB`                        |
| `greenplum.gpfdist.retry-timeout`          | <p>Максимальное время, которое сегмент Greenplum® будет ожидать ответа на GPFDIST-запрос, в формате [duration](https://trino.io/docs/current/admin/properties.html#duration).</p><p>При значении, отличающемся от `null`, настройка переопределяет параметр Greenplum® [gpfdist_retry_timeout](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-config_params-guc-list.html#gpfdist_retry_timeout) (по умолчанию — 300 секунд)</p> | `null`                        |
| `greenplum.max-read-parallelism`           | <p>Максимальный уровень параллелизма при чтении данных из Greenplum®.</p><p>Соответствует свойству сессии `max_read_parallelism`</p>                                                                                                                                                                                                                                                                                  | `1` (отсутствие параллелизма) |
| `greenplum.segment-fetch-required`         | <p>Определяет поведение коннектора в случае, если ему не удается получить информацию о количестве сегментов Greenplum®:</p><p><ul><li>При значении `true` запрос к Trino завершится ошибкой.</li><li>При значении `false` уровень параллелизма будет равен значению свойства сессии `max_read_parallelism`.</li></ul></p><p>Соответствует свойству сессии `segment_fetch_required`</p>                             | `true`                        |

#### Полезные ссылки {#see-also}

* [Создание каталога Trino](../operations/catalog-create.md)