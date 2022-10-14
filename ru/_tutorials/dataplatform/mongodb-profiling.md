# Анализ производительности и оптимизация {{ MG }}

В этом руководстве вы узнаете:

* как использовать [инструменты диагностики производительности](../../managed-mongodb/operations/tools.md) и [мониторинга](../../managed-mongodb/operations/monitoring.md) для диагностики производительности кластера {{ mmg-name }};
* как устранять обнаруженные проблемы.

Снижение производительности кластера {{ mmg-name }} чаще всего происходит по одной из следующих причин:

* [высокая утилизация CPU и дискового I/O](#cpu-io-deficit),
* [неэффективное выполнение запросов в {{ MG }}](#inefficient-queries),
* [блокировки](#locks),
* [недостаток дискового пространства](#disk-deficit).

Ниже приводятся советы по диагностике и решению этих проблем.

## Перед началом работы {#before-start}

1. Установите на внешнем хосте, имеющем сетевой доступ к хосту {{ MG }} (см. [{#T}](../../managed-mongodb/operations/connect/index.md)), [утилиты](../../managed-mongodb/operations/tools.md#monitoring-tools) получения данных о производительности {{ MG }} `mongostat` и `mongotop`.
1. Определите, для каких баз данных нужно выполнить поиск проблем.
1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) {{ MG }} с ролью [`mdbMonitor`](../../managed-mongodb/concepts/users-and-roles.md#mdbMonitor) для этих баз. Это необходимо для использования утилит `mongostat` и `mongotop`.

## Диагностика дефицита ресурсов {#cpu-io-deficit}

Если какой-то из ресурсов CPU и дискового I/O «вышел на плато» — постоянно росший до этого момента [график](../../managed-mongodb/operations/monitoring.md) остановился на одном уровне — скорее всего, соответствующий ресурс стал дефицитным и это привело к падению производительности. Чаще всего это происходит потому, что использование ресурса достигло [лимита](../../managed-mongodb/concepts/limits.md).

В большинстве случаев высокая утилизация CPU и высокие Disk IO связаны с неоптимальными индексами или большой нагрузкой на хосты.

Начните диагностику с выяснения характера нагрузки и определения проблемных коллекций. Воспользуйтесь встроенными [утилитами мониторинга {{ MG }}](../../managed-mongodb/operations/tools.md#monitoring-tools). Далее проанализируйте производительность конкретных запросов с помощью [логов](../../managed-mongodb/operations/tools.md#explore-logs) или [данных профилировщика](../../managed-mongodb/operations/tools.md#explore-profiler).

Обратите внимание на следующие операции:

* Запросы, не использующие индексы (`planSummary: COLLSCAN`). Такие запросы могут увеличивать как потребление I/O (чтений с диска будет больше), так и CPU (данные сжаты по умолчанию, для них требуется декомпрессия). Если необходимый индекс есть, но БД его не использует, можно форсировать использование индекса с помощью [hint](https://docs.mongodb.com/manual/reference/operator/meta/hint/index.html).
* Запросы с большими значениями параметра `docsExamined` (количества просканированных документов). Это может означать, что текущие индексы неэффективны или требуются дополнительные.

В момент падения производительности проблему можно диагностировать в реальном времени с помощью [списка текущих запросов](../../managed-mongodb/operations/tools.md#list-running-queries):
  * Долгие операции, например, исполняющиеся более секунды:

    ```javascript
    db.currentOp({"active": true, "secs_running": {"$gt": 1}})
    ```

  * Операции по созданию индексов:

    ```javascript
    db.currentOp({ $or: [{ op: "command", "query.createIndexes": { $exists: true } }, { op: "none", ns: /\.system\.indexes\b/ }] })
    ```

См. также примеры в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/db.currentOp/#examples).

## Устранение проблем с дефицитом ресурсов {#solving-deficit}

[Попробуйте оптимизировать](#optimize) найденные запросы. Если нагрузка все еще высокая или оптимизировать нечего, остается только [поднять класс хостов](../../managed-mongodb/operations/update.md#change-resource-preset).

## Диагностика неэффективного выполнения запросов {#inefficient-queries}

Чтобы выявить проблемные запросы в {{ MG }}:

* Изучите [логи](../../managed-mongodb/operations/tools.md#explore-logs). Особое внимание обратите на:
   * Для операций чтения — на поле `responseLength` (в логах отображается как `reslen`).
   * Для операций записи — на количество затронутых документов.
       В логах кластера они выводятся в полях `nModified`, `keysInserted`, `keysDeleted`. На странице [мониторинга кластера](../../managed-mongodb/operations/monitoring.md#cluster) изучите графики **Documents affected on primary**, **Documents affected on secondaries**, **Documents affected per host**.
* Изучите данные [профилировщика](../../managed-mongodb/operations/tools.md#explore-profiler). Выведите долго выполняемые запросы (регулируется [настройкой СУБД `slowOpThreshold`](../../managed-mongodb/concepts/settings-list.md#setting-slow-op-threshold)).

## Устранение проблем с неэффективными запросами {#optimize}

Каждый отдельный запрос можно проанализировать с точки зрения его плана (query plan). Подробнее об этом можно прочитать в документации {{ MG }}:

* [Руководство по анализу запросов](https://docs.mongodb.com/manual/tutorial/analyze-query-plan/).
* [Справка по функции `db.collection.explain`](https://docs.mongodb.com/manual/reference/method/db.collection.explain/#db.collection.explain).

Изучите графики на странице [мониторинга кластера](../../managed-mongodb/operations/monitoring.md#cluster):

* **Index size on primary, top 5 indexes**,
* **Scan and order per host**,
* **Scanned / returned**.

Для ускорения выборок используйте [индексы](https://docs.mongodb.com/manual/indexes).

{% note warning %}

Каждый новый индекс замедляет запись. Большое количество индексов может негативно влиять на производительность при записи.

{% endnote %}

Возможной оптимизацией операций чтения может быть использование частичного извлечения ([projection](https://docs.mongodb.com/manual/tutorial/project-fields-from-query-results/)). Во многих случаях доставать документ целиком не нужно, достаточно нескольких его полей.

Если не удается ни оптимизировать найденные запросы, ни отказаться от них, можно [поднять класс хостов](../../managed-mongodb/operations/update.md#change-resource-preset).

## Диагностика наличия блокировок (locks) {#localize-locking-issues}

Причиной низкой производительности запросов могут быть блокировки (locks).

{{ MG }} не предоставляет подробной информации по блокировкам. В частности, есть только косвенные способы узнать, чем заблокирован конкретный запрос:

* Большие или растущие значения `db.serverStatus().metrics.operation.writeConflicts` могут говорить о высоком write contention на каких-то документах.

* Большие или растущие значения на графике **Write conflicts per hosts** на странице [мониторинга кластера](../../managed-mongodb/operations/monitoring.md#cluster).

* В момент падения производительности внимательно изучите [список текущих запросов](../../managed-mongodb/operations/tools.md#list-running-queries):
  * Найдите операции, которые удерживают эксклюзивные блокировки, например:

    ```javascript
    db.currentOp({'$or': [{'locks.Global': 'W'}, {'locks.Database': 'W'}, {'locks.Collection': 'W'} ]}).inprog
    ```

  * Найдите операции, ожидающие блокировок (в поле `timeAcquiringMicros` будет видно время ожидания):

    ```javascript
    db.currentOp({'waitingForLock': true}).inprog
    db.currentOp({'waitingForLock': true, 'secs_running' : { '$gt' : 1 }}).inprog
    ```

* В [логах](../../managed-mongodb/operations/tools.md#explore-logs) и [профилировщике](../../managed-mongodb/operations/tools.md#explore-profiler) обратите внимание на следующее:
  * операции, долго ожидавшие получения блокировок, будут иметь большие значения `timeAcquiringMicros`;
  * операции, которые конкурировали за одни и те же документы, будут иметь большие значения `writeConflicts`.

Обратитесь к официальной документации {{ MG }} за информацией о том, какие блокировки выполняют стандартные [клиентские](https://docs.mongodb.com/manual/faq/concurrency/#what-locks-are-taken-by-some-common-client-operations-) и [административные](https://docs.mongodb.com/manual/faq/concurrency/#which-administrative-commands-lock-a-database-) команды.

## Устранение проблем с блокировками {#solve-locks}

Найденные блокировки указывают на неоптимизированные запросы. Попробуйте [оптимизировать проблемные запросы](#optimize).

## Диагностика недостатка дискового пространства {#disk-deficit}

Если кластер демонстрирует низкую производительность в сочетании с малым объемом свободного дискового пространства, возможно, для одного или нескольких хостов кластера [активировался режим read-only](../../managed-mongodb/concepts/storage.md#manage-storage-space).

Объем занятого пространства в хранилище отображается на странице [мониторинга кластера](../../managed-mongodb/operations/monitoring.md#cluster) на графиках **Disk space usage per host, top 5 hosts**.

Чтобы отслеживать степень заполнения хранилища на хостах кластера, [настройте алерт](../../managed-mongodb/operations/monitoring.md#read-only-alert).

## Устранение проблем с дисковым пространством {#solve-disk-deficit}

Рекомендации по устранению проблем приведены в разделе [{#T}](../../managed-mongodb/concepts/storage.md#read-only-solutions).
