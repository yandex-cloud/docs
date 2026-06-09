# Коннектор {{ GP }}/Cloudberry

[Коннектор](index.md#connector) {{ GP }}/Cloudberry, разработанный Яндексом на основе [коннектора {{ PG }}]({{ tr.docs }}/connector/postgresql.html), позволяет {{ mtr-name }} читать и записывать данные в кластер {{ GP }}/Cloudberry.

Коннектор поддерживает [параллельное чтение данных](#parallel-reading) сразу с нескольких сегментов {{ GP }} и [чтение данных напрямую с сегментов](#gpfdist-reading) по протоколу GPFDIST, что значительно увеличивает производительность запросов при чтении больших объемов данных. Оба способа чтения данных можно применять одновременно, чтобы наиболее эффективно использовать ресурсы кластера {{ TR }} и кластера {{ GP }}.

Коннектор {{ GP }}/Cloudberry доступен в {{ TR }} версии `476` и выше.

## Параллельное чтение данных {#parallel-reading}

При параллельном чтении из таблицы данные разделяются по значению метаколонки `gp_segment_id`.

Уровень параллелизма определяется количеством сегментов в кластере {{ GP }}. Максимальный уровень параллелизма ограничен [настройкой коннектора](#settings) `greenplum.max-read-parallelism` и соответствующим свойством сессии `max_read_parallelism`.

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

При использовании параллельного чтения коннектор выполняет только частичную фильтрацию строк при выталкивании оператора `LIMIT` ([limit pushdown]({{ tr.docs }}/optimizer/pushdown.html#limit-pushdown)). Это не влияет на корректность результатов запроса.

## Чтение данных по протоколу GPFDIST {#gpfdist-reading}

Коннектор позволяет читать данные напрямую с сегментов {{ GP }} через серверы [GPFDIST]({{ gp.docs.broadcom }}/7/greenplum-database/utility_guide-ref-gpfdist.html), созданные на воркерах {{ TR }}. Включение серверов GPFDIST контролируется [настройкой коннектора](#settings) `greenplum.gpfdist.server.enabled`.

В кластере {{ TR }} можно создать не больше восьми каталогов с включенными GPFDIST-серверами.

Чтение данных напрямую с сегментов {{ GP }} состоит из следующих этапов:

1. Коннектор создает внешнюю таблицу с указанием адреса воркера {{ TR }}, читающего данные:

    ```sql
    CREATE WRITABLE EXTERNAL TEMPORARY TABLE <имя_внешней_таблицы>
           ...
           LOCATION('gpfdist://<адрес_воркера_{{ TR }}>');
    ```

1. Коннектор выполняет запрос:

    ```sql
    INSERT INTO <имя_внешней_таблицы>
    SELECT ... FROM <имя_таблицы_в_{{ GP }}>;
    ```

1. Сегменты {{ GP }} отправляют данные воркеру {{ TR }} на указанный адрес.

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
* Не поддерживается режим обработки массивов [AS_JSON]({{ tr.docs }}/connector/postgresql.html#array-type-handling).
* При одновременном выталкивании операторов `LIMIT` и `ORDER BY` ([Top-N pushdown]({{ tr.docs }}/optimizer/pushdown.html#top-n-pushdown)) коннектор выполняет только частичную сортировку данных. Это не влияет на корректность результатов запроса.

## Настройки коннектора {#settings}

Базовые настройки коннектора и соответствующие им свойства сессии совпадают с [коннектором {{ PG }}]({{ tr.docs }}/connector/postgresql.html) соответствующей версии. Кроме этого доступны следующие настройки:

| Настройка                                  | Описание                                                                                                                                                                                                                                                                                                                                                                                                            | Значение<br/>по умолчанию     |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| `greenplum.gpfdist.server.enabled`         | Включает GPFDIST-серверы на воркерах {{ TR }}                                                                                                                                                                                                                                                                                                                                                                       | `false`                       |
| `greenplum.gpfdist.max-processing-threads` | Максимальный размер пула потоков, производящих асинхронную обработку GPFDIST-запросов                                                                                                                                                                                                                                                                                                                               | `32`                          |
| `greenplum.gpfdist.max-query-threads`      | Максимальный размер пула потоков, создающих внешние таблицы {{ GP }} и инициирующих запись данных во внешнюю таблицу                                                                                                                                                                                                                                                                                                | `32`                          |
| `greenplum.gpfdist.read.enabled`           | Включает чтение данных напрямую с сегментов {{ GP }} по протоколу GPFDIST                                                                                                                                                                                                                                                                                                                                           | `false`                       |
| `greenplum.gpfdist.read.buffer-size`       | <p>Размер буфера для чтения данных по протоколу GPFDIST в формате [data size]({{ tr.docs }}/admin/properties.html#data-size). В случае переполнения буфера коннектор приостанавливает прием данных от сегментов {{ GP }}.</p><p>Соответствует свойству сессии `gpfdist_read_buffer_size`</p>                                                                                                                        | `32MB`                        |
| `greenplum.gpfdist.retry-timeout`          | <p>Максимальное время, которое сегмент {{ GP }} будет ожидать ответа на GPFDIST-запрос, в формате [duration]({{ tr.docs }}/admin/properties.html#duration).</p><p>При значении, отличающемся от `null`, настройка переопределяет параметр {{ GP }} [gpfdist_retry_timeout]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-config_params-guc-list.html#gpfdist_retry_timeout) (по умолчанию — 300 секунд)</p> | `null`                        |
| `greenplum.max-read-parallelism`           | <p>Максимальный уровень параллелизма при чтении данных из {{ GP }}.</p><p>Соответствует свойству сессии `max_read_parallelism`</p>                                                                                                                                                                                                                                                                                  | `1` (отсутствие параллелизма) |
| `greenplum.segment-fetch-required`         | <p>Определяет поведение коннектора в случае, если ему не удается получить информацию о количестве сегментов {{ GP }}:</p><p><ul><li>При значении `true` запрос к {{ TR }} завершится ошибкой.</li><li>При значении `false` уровень параллелизма будет равен значению свойства сессии `max_read_parallelism`.</li></ul></p><p>Соответствует свойству сессии `segment_fetch_required`</p>                             | `true`                        |

#### См. также {#see-also}

* [{#T}](../operations/catalog-create.md)