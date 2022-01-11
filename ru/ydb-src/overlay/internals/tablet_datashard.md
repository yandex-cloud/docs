### Что это и зачем?
**Data Shard** предназначен для хранения части распределённой [пользовательской таблицы](../concepts/datamodel.md) и выполнения распределённых транзакций над этой таблицей.

### Выполнение транзакций
Поддерживаются три типа транзакций:

* Пользовательские (data manipulation)
* Схемные (data definition)
* Сканы (read table)

Инициатором схемных транзакций является SchemeShard. Инициатором пользовательских транзакций и сканов обычно является TxProxy. Транзакции могут быть одношардовыми и многошардовыми (распределенными).

Акторный интерфейс DataShard-а описан в [datashard.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard.h)
и [tx_processing.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/tx_processing.h).
Соответсвующие protobuf сообщения описаны в [tx_datashard.proto](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/tx_datashard.proto)
и [tx.proto](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/tx.proto).

#### Выполнение распределенных транзакций
См. [Пайплайн выполнения транзакций](tx_processing_graph.md)

Выполнение пользовательской или схемной распределенной транзакции с точки зрения DataShard-а сводится к следующим шагам:

1. Запрос TEvDataShard::TEvProposeTransaction на выполнение транзакции и подготовка к выполнению транзакции.
При получении этого сообщения DataShard проверяет возможность выполнения транзакции. Если выполнение возможно,
то DataShard сохраняет транзакцию в [локальную базу](localdatabase.md) и отвечает сообщением
TEvDataShard::TEvProposeTransactionResult со статусом PREPARED. Если выполнение транзакции невозможно, то ответ
будет содержать один из статусов ошибки (все статусы описаны в protobuf сообщении NKikimrTxDataShard::TEvProposeTransactionResult).
Если транзакция полностью выполняется на propose стадии, то ответ будет иметь статус COMPLETE и будет содержать результат
выполнения транзакции
2. Ожидание плана транзакций от [координатора](tablet_coordinator.md)/[медиатора](tablet_mediator.md). План приходит в сообщении
TEvTxProcessing::TEvPlanStep. При обработке плана DataShard сохраняет его в локальную базу и овтечает сообщением
TEvTxProcessing::TEvPlanStepAccepted в медиатор и TEvTxProcessing::TEvPlanStepAck в координатор. На стадии propose
для транзакции определяется ее MaxStep. Если по достижению этого шага транзакция остается без плана, то она удаляется с шарда.
также возможна ситуация, когда только часть шардов успешно провела propose стадию для транзакции. В этом случае транзакция
может быть отменена сообщением TEvDataShard::TEvCancelTransactionProposal
3. Далее при выполнении транзакций на шардах формируются исходящие ReadSet-ы. Они сохраняются в [локальную базу](localdatabase.md)
и доставляются к другим участникам распределенной транзакции в сообщении TEvTxProcessing::TEvReadSet. При получении ReadSet-а
DataShard может сохранить его в [локальную базу](localdatabase.md) и ответить сообщением TEvTxProcessing::TEvPlanStepAck.
Альтернативно DataShard может держать ReadSet в оперативной памяти и ответить сообщением TEvTxProcessing::TEvPlanStepAck
после завершения выполнения транзакции
4. Ожидание входящих ReadSet-ов для транзакции
5. Выполнение транзакции и отправка результатов в сообщении TEvDataShard::TEvProposeTransactionResult

При выполнении ReadTable не происходит обмена ReadSet-ами, но добавляются сообщения по управлению потоком данных. Первые два шага
выполнения аналогичны. Далее идут следующие шаги:

3. DataShard отправляет запрос на стрим данных TEvTxProcessing::TEvStreamClearanceRequest. В ответ ожидается сообщение
TEvTxProcessing::TEvStreamClearanceResponse, которое означает, что шард может запускать скан (данная схема используется
для упорядоченных ReadTable запросов, а также для ограничения количества одновременно стримящих шардов)
4. Запускается скан. Скан проводится отдельным актором, которы работает асинхронно с DataShard-ом.
Скан актор дклаеи запрос на квоту стрима TEvTxProcessing::TEvStreamQuotaRequest, в ответ ожидается
TEvTxProcessing::TEvStreamQuotaResponse. При получении квоты актор отправляет данные в сообщении
TEvDataShard::TEvProposeTransactionResult со статусом RESPONSE_DATA
* На шагах 3 и 4 выполнение транзакции можно прервать, отправив на DataShard сообщение (TEvTxProcessing::TEvInterruptTransaction.
Также транзакция прерывается при получении нотификации TEvTxProcessing::TEvStreamIsDead, TEvents::TEvUndelivered или
TEvInterconnect::TEvNodeDisconnected, когда теряется связь с приемником данных.
5. После отправки всех данных завершается выполнение транзакции. Отправляется ответ TEvDataShard::TEvProposeTransactionResult
со статусом COMPLETE (или со статусом ошибки, если скан завершился с ошибкой)

### Выполнение транзакций в DataShard

За выполнение транзакций на DataShard отвечает компонента Pipeline, которая описана в
[datashard_pipeline.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard_pipeline.h).
При выполнении транзакций Pipeline оперирует объектами операций и исполняющих блоков.

#### Операции

В пайплайне все исполняемые транзакции представлены объектами, реализующими интерфейс TOperation.
Данный интерфейс описан в [operation.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/operation.h).
Интерфейс операции позволяет:
 * получить базовую информацию об операции (TxId, Step, Kind, флаги и т.п)
 * управлять входящими данными операции (входящие ReadSet-ы, сообщения, результаты асинхронного скана и т.п.)
 * управлять исходящими данными операции (исходящие ReadSet-ы, лог локов, результат операции)
 * управлять планом выполнения операции. План выполнения представляет собой вектор идентификаторов исполняющих блоков,
   через которые операции необходимо пройти. Виртуальная функция BuildExecutionPlan должна быть определена в производных
   классах для построения плана выполнения перед помещением операции в Pipeline
 * складывать профиль выполнения операции. При продвижении операции по ее плану выполнения мы сохраняем в операции информацию
   о времени, проведенном на каждом из блоков
 * управлять зависимостями операций. Зависимости между операциями используются в основном для возможности out-of-order исполнения
   операций. Ряд виртуальных методов, описанных для операции в разделе DEPENDENCIES, может быть переопределен в производных классах
   для идентификации данных, которые читаются и модифицируются операцией. Также для этого могут быть использованы некоторые флаги,
   например GlobalReader, GlobalWriter, UsingSnapshot (полный список флагов операции описан в структуре TTxFlags в файле
   [datashard.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard.h))
 
 Планировалось, что для каждого типа операции будет определен свой производный класс операции, но на данный момент таких классов
 всего два:
 * [TBarrierOperation](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/barrier_operation.h) -
 псевдо-операция, которая ограничивает работу out-of-order после рестарта таблетки (подробнее о том, зачем нужен барьер описано
 в комментариях в
 [build_and_wait_dependencies_unit.cpp](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/build_and_wait_dependencies_unit.cpp)).
 * [TActiveTransaction](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard_active_transaction.h) - 
 представляет все остальные типы операции - data transaction, scheme transaction и read table. Планировалось разбить этот класс
 на несколько, но эта работа еще не была сделана.

 Также планировалось проводить через Pipeline те операции, про которые он на данный момент не знает. Примерами таких операций являются
 split, s3 listing. Перевод текущего кода в виде таблеточных транзакций на операции и исполняющие блоки позволит заиспользовать для
 таких специфичных операций функционал Pipeline-а. Например, такие операции появятся в мониторинге и получат профиль исполнения

#### Исполняющие блоки

Исполняющий блок отвечает за продвижение операции по пайплайну. Исполняющие блоки позволяют разбить код выполнения инструкции на
независимые шаги. Далее при составлении плана выполнения операции набираются необходимые для нее блоки. Интерфейс описан в
[execution_unit.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/execution_unit.h)
Блок реализует простой интерфейс:
 * IsReadyToExecute(op) - проверка, можно ли продвинуть выполнение операции 
 * FindReadyOperation() - возвращает операцию, которая в данный момент готова для исполнения на блоке
   (переопределено только в некоторых блоках, например, PlanQueue)
 * Execute(op, txc, ctx) - выполняет операцию на блоке. Возвращает статус исполнения, согласно которому операция либо остается на этом
   же блоке, либо продвигается дальше. Также через статус может быть запрошен рестарт или коммит таблеточной транзакции. Статусы
   и их значения описаны в [EExecutionStatus](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/execution_unit.h)
 * Complete(op, ctx) - если было запрошено статусом возврата Execute, то Complete вызывается после коммита транзакции

#### Жизненный цикл операции

Создаются операции в Pipeline в двух случаях - при инициализации таблетки и при обработке TEvDataShard::TEvProposeTransaction.

При инициализации таблетки в компоненте [TransQueue](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard_trans_queue.cpp)
вычитывается таблица TxMain с базовой информацией о сохраненных на шарде операциях и по ней строятся TActiveTransaction. Далее
для каждой операции строится план и она добавляется в первый в своем плане исполняющий блок.

При обработке TEvDataShard::TEvProposeTransaction эвент передается в метод TPipeline::BuildOperation, который возвращает построенную
по запросу операцию.

Далее начинается продвижение операции по ее плану выполнения. Выполнение операции происходит в рамках одной из таблеточных транзакций
[TxProposeTransactionBase](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard__propose_tx_base.cpp)
и [TxProgressTransaction](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard__progress_tx.cpp).
Если операция была только что создана для входящего TEvDataShard::TEvProposeTransaction, то это было сделано в рамках таблеточной транзакции
[TxProposeTransactionBase](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard__propose_tx_base.cpp)
и прямо там же мы начинаем продвижение операции. В TxProgressTransaction мы ищем первую готовую операцию вызовои метода
TPipeline::GetNextActiveOp. Готовая операция ищется среди операций-кандидатов на исполнение, проверяя их готовность через
вызов IsReadyToExecute текущего блока операции. Также проверяются блоки-кандидаты методом FindReadyOperation. Кандидатами операции
и блоки становятся при наступлении определенных событий, например, получение новых входных данных для операции или изменение
зависимостей операции.

После того, как определена готовая к выполнению операция, для нее запускается метод TPipeline::RunExecutionPlan.
В данном методе вызывается метод Execute текущего исполняющего блока и согласно статусу операция либо продвигается дальше,
либо остается на том же блоке. Если операция была продвинута, то опять проверяем ее на готовность и т.д. После завершения
транзакции при необходимости вызываются методы Complete исполняющих блоков.

Если операция хранится в локальной базе таблетки, то финальные исполняющие блоки в ее плане должны удалить все данные,
связанные с операцией.

#### Out-of-order выполнение транзакций

Когда операция попадает в Pipeline, он начинает ее выполнять, не обращая внимания на то, какие операции уже есть в полете.
Если операция имеет ограничения на параллельное выполнение с другими операциями (а таковыми являются почти все операции),
то в ее плане должен присутствовать исполняющий блок
[BuildAndWaitDependencies](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/build_and_wait_dependencies_unit.cpp),
который отвечает за ограничение параллельного выполнения операций

В Pipeline есть множество операций
[ExecuteBlockers](https://a.yandex-team.ru/search?search=THashSet<TOperation%3A%3ATPtr>%20ExecuteBlockers%3B,datashard_pipeline.h,,arcadia,,200),
в котором хранятся все исполняемые операции, которые могут помешать исполняться другим операциям. В блоке
[BuildAndWaitDependencies](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/build_and_wait_dependencies_unit.cpp),
операция анализируется на зависимости со всеми операциями из множества
[ExecuteBlockers](https://a.yandex-team.ru/search?search=THashSet<TOperation%3A%3ATPtr>%20ExecuteBlockers%3B,datashard_pipeline.h,,arcadia,,200)
и сама добавляется в это множество.
Далее мы смотрим, есть ли какие-нибудь зависимости, которые мешают начать исполнение операции. Если такие зависимости есть, то
операция остается в блоке
[BuildAndWaitDependencies](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/build_and_wait_dependencies_unit.cpp)
ожидать разрешения конфликтов (в коде комментарии описывают, какие зависимости могут помешать продвижению операции). При завершении
операций, связанных с ожидающей операцией, ожидающая операция будет попадать в кандидаты на выполнение и мы будем заново проверять,
можно ли ей начать выполняться. Когда все кронфликты уйдут, операция получит флаг Executing и продвинется дальше по плану выполнения.

Важной моментом является то, что анализ зависимостей проводится только с операциями из
[ExecuteBlockers](https://a.yandex-team.ru/search?search=THashSet<TOperation%3A%3ATPtr>%20ExecuteBlockers%3B,datashard_pipeline.h,,arcadia,,200),
а не со всеми операциями в Pipeline. Это значит, что для планируемых операций важен порядок их обработки в
[BuildAndWaitDependencies](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/build_and_wait_dependencies_unit.cpp).
Правильный порядок обеспечивается добавлением в план выполнения планируемых операций блока
[PlanQueue](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/plan_queue_unit.cpp), при этом мы не влозьмем из
[PlanQueue](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/plan_queue_unit.cpp) очередную операцию, пока для
предыдущей не будут построены зависимости.

### Схема данных
Схема данных описана в [datashard_impl.h](https://a.yandex-team.ru/arc/trunk/arcadia/ydb/core/tx/datashard/datashard_impl.h)
в структуре [TFlatterDataShard::Schema](https://a.yandex-team.ru/search?search=struct%20Schema%20%3A%20NIceDb%3A%3ASchema,datashard_impl.h,,arcadia,,200)

|**Sys**|**Таблица предназначена для хранения глобального состояния**||
| --- | --- | --- |
|Id|ui64 PK|идентификатор переменной|
|Bytes|string|строковое значение переменной|
|Uint64|uint64|или числовое значение переменной|

Ключи описаны в [TFlatterDataShard::Schema::ESysTableKeys](https://a.yandex-team.ru/search?search=ESysTableKeys%20,%5E.*,,arcadia,,200). На данный момент в этой таблице хранятся переменные:

1. **Sys_State** - текущее состояние таблетки
2. **Sys_LastPlannedStep** - step последней запланированной транзакции, обновляется пайплайном при получении плана
3. **Sys_LastPlannedTx** - ID последней запланированной транзакции
4. **Sys_LastCompleteStep** - step последней выполненной транзакции. При завершении транзакции, выполненной вне очереди, параметр не обновляется. Обновление произойдет только тогда, когда завершается первая по текущему плану транзакция
5. **Sys_LastCompleteTx** - ID последней выполненной транзакции
6. **Sys_LastLocalTid** - последний идентификатор, назначенный пользовательской таблице. Обновляется в базе в TFlatterDataShard::CreateUserTable, но параметр таблетки обновляется отдельно. Получается неправильное значение параметра при получении снапшота?
7. **Sys_LastSeqno** - значение инкрементируемого идентификатора для следующего исходящего read-set (RS). Обновляется при записи исходящих RS в базу. Правильнее было бы назвать NextSeqno. Параметр стоило бы выпилить после того, как все RS будут идентифицироваться по составному ключу (  KIKIMR-4008 Открыт Хранить OutReadSet-ы по составному ключу вместо Seqno  ienkovich)
8. **Sys_AliveStep** - максимальный step, на который может быть запланирована сохраненная на шарде транзакция. Обновляется при сохранении транзакций. Используется при планировании схемных транзакций. Для модифицирующих схемных транзакций (на данный момент для всех схемных, кроме CopyTable) мы разрешаем планироваться только позднее этого параметра, если в данный момент есть уже сохраненные, но еще не запланированные транзакции
9. **Sys_TxReadSizeLimit_DEPRECATED** - не используется
10. **Sys_SchemeShardId** - SchemeShard, который владеет шардом. Сохраняется при первой входящей схемной транзакции или при инициализации шарда при split/merge. Для последующих схемных транзакций делается сверка с записанным значением
11. **Sys_DstSplitDescription** - в TFlatterDataShard::TTxInitSplitMergeDestination шард-приемник хранит тут структуру NKikimrTxDataShard::TSplitMergeDescription с информацией о диапазонах ключей
12. **Sys_DstSplitOpId** - ID split транзакции на шарде-приемнике
13. **Sys_SrcSplitDescription** - в TFlatterDataShard::TTxSplit шард-источник сохраняет тут структуру NKikimrTxDataShard::TSplitMergeDescription с информацией о диапазонах ключей
14. **Sys_SrcSplitOpId** - ID split транзакции на шарде-источнике
15. **Sys_LastSchemeShardGeneration** - компонента Generation порядкового идентификатора последней сохраненной схемной транзакции. Используется для фильтра транзакций дубликтов
16. **Sys_LastSchemeShardRound** - компонента Round порядкового идентификатора последней сохраненной схемной транзакции
17. **Sys_TxReadSizeLimit** - максимальное количество байт, которое может читать одна транзакция. Заполняется при создании и альтере пользовательской таблицы
18. **Sys_SubDomainInfo** - хранит структуру NKikimrSubDomains::TProcessingParams с параметрами планирования транзакций (списки координаторов и медиаторов). Сохраняется при получении первой схемной транзакции, где этот параметр заполнен
19. **Sys_StatisticsDisabled** - включает сборку и отправку статистики. Заполняется при создании и альтере пользовательской таблицы
20. **SysPipeline_Flags** - флаги конфига пайплайна
21. **SysPipeline_LimitActiveTx** - максимальное количество исполняемых транзакций (глубина out-of-order пайплайна)
22. **SysPipeline_LimitDataTxCache** - размер кеша для тел транзакций
23. **Sys_Config** - не используется


|**UserTables**|**Таблица с информацией о пользовательских таблицах**||
| --- | --- | --- |
|Tid|ui64 PK|глобальный идентификатор таблицы|
|LocalTid|ui32|идентификатор таблицы в локальной базе|
|Path|string|путь|
|Name|string|тмя таблицы|
|Schema|string|пробобуф со схемой таблицы|

|**TxMain**|**Основная легкая информация об активных транзакциях**||
| --- | --- | --- |
|TxId|ui64 PK|Id транзакции|
|Kind|ui32|тип транзакции|
|Flags|ui32|флаги выполнения|
|State|ui32|текущее состояние|
|InRSRemain|ui64|количество недополученных ридсетов|
|MaxStep|ui64|максимальный шаг, на котором траназакция может быть выполнена (для очистки)|
|ReceivedAt|ui64|Время получения транзакции шардом|

|**TxDetails**|**Тяжелая информация об активных транзакциях**||
| --- | --- | --- |
|TxId|ui64 PK|идентификатор транзакции|
|Origin|ui64 PK|tabletId **даташарда**, на котором началась транзакция (для балансировки)|
|InReadSetState|ui64|не используется|
|Body|string|тело транзакции - minikql запрос|
|Source|actorid|идентификатор актора инициировавшего транзакцию (tx proxy)|

|**InReadSets**|**Хранилище входящих ридсетов активных транзакций**||
| --- | --- | --- | 
|TxId|ui64 PK|идентификатор транзакции|
|Origin|ui64 PK|tabletId **даташарда**|
|From|ui64 PK|tabletId **даташарда**, от которого пришёл readset|
|To|ui64 PK|tabletId **даташарда**, которому readset предназначен (для балансировки)|
|InReadSetState|ui64|не используется|
|Body|string|пересылаемые данные (ридсет)|
|BalanceTrackList|string|списки **даташардов** для отслеживания ридсетов в режиме балансировки|

|**OutReadSets**|**Хранилище исходящих ридсетов, на которые не получено подтверждение**||
| --- | --- | --- |
|Seqno|ui64 PK|порядковый номер отправленного ридсета|
|Step|ui64|шаг|
|TxId|ui64|идентификатор транзакции|
|Origin|ui64|tabletId **даташарда**|
|From|ui64|tabletId **даташарда**, от которого пришёл readset|
|To|ui64|tabletId **даташарда**, которому readset предназначен (для балансировки)|
|Body|string|пересылаемые данные (ридсет)|
|SpiltTraj|string|траектория сплита (для балансировки)|

|**PlanQueue**|**Очередь запланированных на выполнение транзакций**||
| --- | --- | --- |
|Step|ui64 PK|шаг|
|TxId|ui64 PK|идентификатор транзакции|

|**DeadlineQueue**|**Очередь для таймаута незапланированных транзакций - в данный момент таблица не используется**||
| --- | --- | --- | 
|MaxStep|ui64 PK|максимальный шаг, на котором можно выполнить транзакцию|
|TxId|ui64 PK|идентификатор транзакции|

|**SchemaOperations**|**Таблица схемных транзакций**||
| --- | --- | --- | 
|TxId|ui64 PK|ID транзакции|
|Operation|ui32|Тип операции SchemaOperations::EType|
|Source|ACTOR_ID|Источник транзакции|
|SourceTablet|ui64|Идентификатор SchemeShard|
|MinStep|ui64|Минимальный допустимый step|
|MaxStep|ui64|Максимальный допустимый step|
|PlanStep|ui64|Всегда записывается 0|
|ReadOnly|bool|Флаг RO транзакции|

|**SplitSrcSnapshots**|||
| --- | --- | --- |
|DstTabletId|ui64 PK||
|SnapshotMeta|string||

|**SplitDstReceivedSnapshots**|**Таблица для хранения всех таблеток, от которых были получены снапшоты**||
| --- | --- | --- |
|SrcTabletId|ui64 PK|ID таблетки, от которых был получен снапшот|

|**TxArtifacts**|**Таблица для дополнительных артефактов транзакции (помимо ReadSet-ов)**||
| --- | --- | --- |
|TxId|ui64 PK|ID транзакции|
|Flags|ui64|Маска артефактов, которые были сохранены для транзакции (TActiveTransaction::EArtifactFlags)|
|Locks|string|Результаты проверки локов для транзакции|

