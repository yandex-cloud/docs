<!-- Refactored to concepts/scan_query + CLI article on scan query command -->

# Инструкция по использованию Scan Queries запросов
## Введение
Данная статья описывает стримминговый интерфейс доступа к данным *Scan Queries*.

## Назначение
Основное назначение *Scan Queries* - это выполнение аналитических ad-hoc запросов над базой данных. Результатом выполнения запроса является поток данных (stream).

Так же через интерфейс *Scan Queries* можно выполнять запросы к [системным таблицам](https://cloud.yandex.ru/docs/ydb/troubleshooting/system_views).

Данный способ выполнения запросов отличается тем, что:
* работа с данными идёт на снапшотах, поэтому влияние на поток OLTP-транзакций минимальное (только снятие снапшота);
* внутри используется стриминг данных, вместо request-response подхода;
* по-необходимости используется спиллинг данных на диск;
* для запросов безусловно применяется LLVM-компиляция;
* результат запроса - это стрим данных.

Ограничения *Scan Queries*:
* только read-only запросы;
* длительность запроса ограничена 5 минутами;
* многие операции (включая сортировку) выполняются целиком в памяти, поэтому на сложных запросах можно получить ошибку нехватки ресурсов;
* для джойнов на текущий момент используется только одна стратегия - *MapJoin* (aka *Broadcast Join*), где "правая" таблица конвертится в карту, поэтому она должна быть не более единиц гигабайт;
* не поддерживается prepared-форма.

{% note info %}

Несмотря на то, что *Scan Queries* явно не мешают выполнению OLTP-транзакций, они всё же используют общие ресурсы базы: СPU, память, диск, сеть. Поэтому выполнение тяжелых запросов **может привести к голоданию по ресурсам**, что скажется на производительности всей базы.

{% endnote %}

## Как воспользоваться
Как и другие виды запросов, *Scan Queries* доступны через Web UI, CLI и SDK.

### Web UI
Запуск запроса через интерфейс *Scan Query* возможен как через [web-интерфейс YQL](https://yql.yandex-team.ru), так и через *YQL Kit* в [web-интерфейсе YDB](https://ydb.yandex-team.ru).

В запросе требуется указать прагму `PRAGMA Kikimr.ScanQuery = "true";`.

{% note info %}

Для запросов, выполняемых через Web UI неявным образом устанавливается ограничение на 1000 строк.

Если в результате выполнения запроса было превышение, то клиенту отдаётся только первые 1000 строк и в интерфейсе отображается комментарий 
```
Table data is truncated.
```

{% endnote %}

### YDB Cli
Запуск запроса через *Scan Queries* посредством YDB Cli осуществляется добавлением флага `-t scan` в `{{ ydb-cli }} table exec` команду.

Дополнительных прагм указывать не нужно.

```
$ {{ ydb-cli }} -e <endpoint> -d <database> table query execute -t scan -f query.sql
```

### SDK

#### C++ SDK
Для запуска запроса через механизм *Scan Queries* предназначены 2 метода в классе `Ydb::TTableClient`
```cpp
class TTableClient {
    ...
    TAsyncScanQueryPartIterator StreamExecuteScanQuery(const TString& query,
        const TStreamExecScanQuerySettings& settings = TStreamExecScanQuerySettings());

    TAsyncScanQueryPartIterator StreamExecuteScanQuery(const TString& query, const TParams& params,
        const TStreamExecScanQuerySettings& settings = TStreamExecScanQuerySettings());
    ...
};
```

Эти методы возвращают итератор на часть стрима данных. Пример использования можно посмотреть в basic_example.