---
sourcePath: overlay/internals/resource_broker.md
---
Resource Broker появился как результат развития сервиса Compaction Broker, который использовался для ограничения количества одновременно запущенных таблеточных компакшенов. Resource Broker решает более общую задачу распределения ресурсов между задачами, в том числе и просто ограничивая количество запускаемых задач определенного типа. Resource Broker является локальным сервисом и создается по одному на каждую ноду.

### Ресурсы
На данный момент Resource Broker управляет двумя ресурсам: CPU и Memory. Они перечислены в интерфейсе Resource Broker-а.

``` cpp
enum EResourceType {
    CPU    = 0;
    MEMORY = 1;
};

message TResources {
    // Index is EResourceType.
    repeated uint64 Resource = 1;
};
```
### Задачи
Чтобы получить ресурсы, мы должны отправить в Resource Broker задачу. Задача при создании описывается следующей структурой:
``` cpp
struct TTask {
    ui64 TaskId;
    TString Name;
    TResourceValues RequiredResources;
    TString Type;
    ui64 Priority;
    TIntrusivePtr<TThrRefBase> Cookie;
};
```

* **TaskId** - уникальный идентификатор задачи клиента. Resource Broker в качестве уникального идентификатора задачи использует пару <TActorId, ui64> идентификаторов клиента и задачи соответственно. Данное поле может быть равно 0. В этом случае Resource Broker сам назначит уникальный идентификатор, но клиент его не узнает до момента получения ресурсов на нее. Т.е. модифицировать или удалить задачу, пока она лежит в очереди, не получится, а идентифицировать задачу при получении ресурсов можно будет по Cookie
* **Name** - имя задачи используется для удобства в логировании и интроспекции
* **RequiredResources** - необходимые для задачи ресурсы
* **Type** - тип задачи – см. [Типы задач](#task-types). Определяет очередь – см. [Очереди задач](#task-queues), в которую эта задача попадет
* **Priority** - приоритет задачи влияет на ее положение в очереди. Задачи с меньшим значением приоритета всегда стоят в очереди раньше. Задачи с одинаковым приоритетом располагаются в очереди по времени создания
* **Cookie** - пользовательские данные. При аллокации ресурсов для задачи пользователь получит сообщение с копией Cookie

При получении задачи Resource Broker помещает ее в одну из своих очередей. Очередь выбирается в соответствии с типом задачи.

### Очереди задач {#task-queues}
Resource Broker управляет несколькими очередями задач. Очередь описывается следующей структурой:
``` cpp
message TQueueConfig {
    optional string Name = 1;
    optional uint32 Weight = 2;
    optional TResources Limit = 3;
};
```

* **Name** - имя очереди используется для привязки типа задачи к очереди. Также используется в мониторинге
* **Weight** - вес очереди определяет долю получаемых ресурсов
* **Limit** - ограничение на потребление ресурсов задает максимальное потребление ресурсов всеми одновременно запущенными в этой очереди задачами. Единственное условие, при котором это ограничение может быть нарушено - одна задача требует ресурсов больше установленных лимитов (она может быть запущена только при отсутствии других запущенных задач из этой очереди).

### Типы задач {#task-types}
Тип задачи определяет, в какую очередь попадет задача. Также по каждому типу ведется статистика времени выполнения задачи, которая используется при планировании задач, так что полезно разделять по типам те задачи, время исполнения которых может сильно отличаться. Тип задачи описывается следующей структурой:
``` cpp
message TTaskConfig {
    optional string Name = 1;
    optional string QueueName = 2;
    optional uint64 DefaultDuration = 3;
};
```

* **Name** - имя типа задачи
* **QueueName** - имя очереди, в которую отправятся все задачи данного типа
* **DefaultDuration** - время исполнения задачи, которое используется до сбора достаточной статистики

### Конфигурация Resource Broker
Конфигурация задает предопределенный набор очередей и типов задач. Специальный тип задачи "unknown" используется для всех задач, которые имеют тип, не описанный в конфигурации. Также определяется общий лимит на потребление ресурсов всеми очередями. Как и в случае очереди, этот лимит может быть превышен, если у нас есть задача, которой требуется больше ресурсов (эта задача при этом будет единственной активной). Конфигурация описывается следующей структурой:
``` cpp
message TResourceBrokerConfig {
    repeated TQueueConfig Queues = 1;
    repeated EQueue TaskAssignments = 2;
    optional TResources ResourceLimit = 3;
};
```
Имена типов задач Resource Broker-а используются в других конфигах и для нормальной работы кластера важна согласованность всех конфигов. В противном случае важные задачи могут быть обработаны как "unknown" задачи и попасть в очередь с маленьким лимитом ресурсов.
На данный момент такими конфигами являются CompactionPolicy таблицы и ResourceProfile таблеток.
Дефолтный конфиг Resource Broker-а представлен ниже, он согласован с дефолтными CompactionPolicy и ResourceProfile. Лимиты по ресурсам у очередей были унаследованы от Compaction Broker. Как правило, на продуктовых кластерах используются конфиги с увеличенными лимитами.

{% list details %}

- Дефолтный конфиг Resource Broker

  ``` cpp
  Queues {
    Name: "queue_default"
    Weight: 30
    Limit {
      Resource: 2
    }
  }
  Queues {
    Name: "queue_compaction_gen0"
    Weight: 100
    Limit {
      Resource: 2
    }
  }
  Queues {
    Name: "queue_compaction_gen1"
    Weight: 100
    Limit {
      Resource: 2
    }
  }
  Queues {
    Name: "queue_compaction_gen2"
    Weight: 100
    Limit {
      Resource: 1
    }
  }
  Queues {
    Name: "queue_compaction_gen3"
    Weight: 100
    Limit {
      Resource: 1
    }
  }
  Queues {
    Name: "queue_transaction"
    Weight: 100
    Limit {
      Resource: 4
    }
  }
  Queues {
    Name: "queue_background_compaction"
    Weight: 10
    Limit {
      Resource: 1
    }
  }
  Tasks {
    Name: "unknown"
    QueueName: "queue_default"
    DefaultDuration: 60000000
  }
  Tasks {
    Name: "compaction_gen0"
    QueueName: "queue_compaction_gen0"
    DefaultDuration: 10000000
  }
  Tasks {
    Name: "compaction_gen1"
    QueueName: "queue_compaction_gen1"
    DefaultDuration: 30000000
  }
  Tasks {
    Name: "compaction_gen2"
    QueueName: "queue_compaction_gen2"
    DefaultDuration: 120000000
  }
  Tasks {
    Name: "compaction_gen3"
    QueueName: "queue_compaction_gen3"
    DefaultDuration: 600000000
  }
  Tasks {
    Name: "transaction"
    QueueName: "queue_transaction"
    DefaultDuration: 600000000
  }
  Tasks {
    Name: "background_compaction"
    QueueName: "queue_background_compaction"
    DefaultDuration: 60000000
  }
  Tasks {
    Name: "background_compaction_gen0"
    QueueName: "queue_background_compaction"
    DefaultDuration: 10000000
  }
  Tasks {
    Name: "background_compaction_gen1"
    QueueName: "queue_background_compaction"
    DefaultDuration: 20000000
  }
  Tasks {
    Name: "background_compaction_gen2"
    QueueName: "queue_background_compaction"
    DefaultDuration: 60000000
  }
  Tasks {
    Name: "background_compaction_gen3"
    QueueName: "queue_background_compaction"
    DefaultDuration: 300000000
  }
  ResourceLimit {
    Resource: 10
    Resource: 17179869184
  }
  ```

{% endlist %}

На данный момент драйвер может принимать как конфиг для Resource Broker, так и старый конфиг для Compaction Broker (оба лежат в boot.txt). При их отсутствии используется дефолтный конфиг.

#### Переход с конфигов Compaction Broker на конфиги Resource Broker
Самый простой способ заменить Compaction Broker конфиг на соответствующий ему Resource Broker конфиг - это запустить Kikimr с конфигом Compaction Broker и взять соответствующий Resource Broker конфиг с его страницы мониторинга. Имена очередей в полученном конфиге можно изменять по желанию. Имена типов задач необходимо сохранить для совместимости со старыми ComapctionPolicy таблиц.

{% list details %}

- Пример Compaction Boker конфига и соответствующего ему Resource Broker конфига

  ``` cpp
  CompactionBroker {
      Queue {
          QueueID: 0
          Quota: 10
      }
      Queue {
          QueueID: 1
          Quota: 6
      }
      Queue {
          QueueID: 2
          Quota: 3
      }
      Queue {
          QueueID: 3
          Quota: 3
      }
  }

  ResourceBroker {
      Queues {
          Name: "queue_legacy0"
          Weight: 100
          Limit {
              Resource: 10
          }
      }
      Queues {
          Name: "queue_legacy1"
          Weight: 100
          Limit {
              Resource: 6
          }
      }
      Queues {
          Name: "queue_legacy2"
          Weight: 100
          Limit {
              Resource: 3
          }
      }
      Queues {
          Name: "queue_legacy3"
          Weight: 100
          Limit {
              Resource: 3
          }
      }
      Queues {
          Name: "queue_default"
          Weight: 30
          Limit {
              Resource: 2
          }
      }
      Tasks {
          Name: "compaction_gen0"
          QueueName: "queue_legacy0"
          DefaultDuration: 30000000
      }
      Tasks {
          Name: "compaction_gen1"
          QueueName: "queue_legacy1"
          DefaultDuration: 30000000
      }
      Tasks {
          Name: "compaction_gen2"
          QueueName: "queue_legacy2"
          DefaultDuration: 30000000
      }
      Tasks {
          Name: "compaction_gen3"
          QueueName: "queue_legacy3"
          DefaultDuration: 30000000
      }
      Tasks {
          Name: "unknown"
          QueueName: "queue_default"
          DefaultDuration: 30000000
      }
      ResourceLimit {
          Resource: 24
      }
  ```

{% endlist %}

Рекомендуется добавить очереди и типы задач для фонового компакшена (по умолчанию фоновый компакшн в Compaction Policy выключен, но для возможности его включения полезно иметь готовые типы задач и очередь; пример можно увидеть в дефолтном конфиге) и транзакций (тип задачи "transaction" используется в Resource Profile таблеток по умолчанию).

### Мониторинг
Актор Resource Broker-а регистрирует свою страницу мониторинга /actors/rb, на которой можно посмотреть текущий конфиг, счетчики, а также состояния всех очередей и задач.
Resource Broker репортит в Solomon статистику по задачам, включая ожидающие, исполняющиеся и завершенные задачи. Как и для Compaction Broker-а сервисом для сенсоров выбран сервис tablets.
Большинство сенсоров отправляют статистику как по очередям, так и по типам задач. Сенсоры очередей снабжены меткой "queue" с именем очереди, а сенсоры   типов задач снабжены меткой "task" с именем типа задачи. Ниже приведен доступный набор сенсоров:

* **EnqueuedTasks** - количество ожидающих в очереди задач. Позволяет определить, насколько перегружена очередь. Для неперегруженной очереди этот сенсор почти всегда равен нулю
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.host=cluster&l.sensor=EnqueuedTasks&l.queue=total&graph=auto) количества ожидающих задач во всех очередях_
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.task=compaction_gen0&l.host=cluster&l.sensor=EnqueuedTasks&graph=auto) количества ожидающих задач с типом compaction_gen0_
* **InFlyTasks** - количество исполняемых задач
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.host=cluster&l.queue=queue_legacy0&l.sensor=InFlyTasks&graph=auto) исполняемых задач в очереди queue_legacy0_
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.task=compaction_gen1&l.host=cluster&l.sensor=InFlyTasks&graph=auto) исполняемых задач типа compaction_gen1_
* **FinishedTasks** - инкрементальный сенсор количества завершившихся задач
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.host=cluster&l.sensor=FinishedTasks&l.queue=queue_legacy0&graph=auto) завершившихся задач в очереди queue_legacy0_
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.task=compaction_gen1&l.host=cluster&l.sensor=FinishedTasks&graph=auto) завершившихся задач типа compaction_gen1_
* **CPUConsumption**, **MemoryConsumption** - потребление ресурсов. Уровень потребления ресурса в сравнении с общим лимитом или лимитом очереди позволяет определить не израсходованный потенциал. Стоит отметить, что это не реальные значения потребления CPU и Memory задачами, а те ресурсы, которые были им выделены Resource Broker-ом
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.host=cluster&l.sensor=MemoryConsumption&l.queue=total&graph=auto) общего потребления ресурса Memory задачами во всех очередях_
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.task=compaction_gen0&l.host=cluster&l.sensor=CPUConsumption&graph=auto) график потребления ресурса CPU задачами типа compaction_gen0_
* **InQueueTime** - время ожидания задачи в очереди
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=slice05&service=tablets&host=cluster&range=*&sensor=InQueueTime&queue=total&graph=auto&checks=-total&b=1h&e=) времен ожидания задач во всех очередях_
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=slice05&service=tablets&task=compaction_gen0&host=cluster&range=*&sensor=InQueueTime&graph=auto&checks=-total) времен ожидания задач типа compaction_gen0_
* **ExecutionTime** - время исполнения задачи. Репортится только для типов задач, не репортится для очередей
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=slice05&service=tablets&l.task=compaction_gen0&l.host=cluster&l.range=*&l.sensor=ExecutionTime&graph=auto&checks=-total) время исполнения задач типа compaction_gen0_ы_
* **MissingTaskTypeCounter** - инкрементальный счетчик количества задач, тип которых не содержится в конфиге. Ненулевое значение данного сенсора указывает на проблемы в конфигурации кластера
  * _[График](https://solomon.yandex-team.ru/?project=kikimr&cluster=kikimr_ugc_prod&service=tablets&l.host=cluster&l.sensor=MissingTaskType&graph=auto) количества задач с неизвестным типом_

### Планирование задач
В каждый момент в очереди есть известный набор исполняемых задач, а у каждой задачи известно потребление ею ресурсов, обозначим его за **c**. Общее количество ресурсов, потребляемых в очереди вычисляется суммой **С = SUM(cvvivv)**. Так как мы работаем с несколькими ресурсами, то **С** является вектором. Для сравнения потребления разнородных ресурсов в разных задачах и очередях удобно использовать понятие доминантного ресурса. Для вычисления текущего доминантного ресурса мы берем отношение **CvvNvv = C / L""""vvTotalvv** (где **LvvTotalvv** - количество всех доступных ресурсов) и выбираем в полученном векторе **CvvNvv** максимальную компоненту **CvvDvv**, которая и будет являться текущим потреблением доминантного ресурса для очереди. Аналогично потребление доминантного ресурса можно посчитать и для задачи (**сvvDvv**).

Для каждой очереди мы считаем две величины потребления ресурсов: реальное потребление и планируемое потребление. Реальное потребление **CvvRvv** считается как интеграл от **CvvDvv** по времени. Планируемое потребление **CvvPvv** считается как сумма **сvvDvv * t** для всех запущенных в очереди задач, где **t** - фактическое или планируемое время исполнения задачи. Для уже завершенных задач используется фактическое время исполнения. Для текущих задач используется планируемое время исполнения. Планируемое время вычисляется как среднее время работы исполненных задач того же типа.

При запуске очередной задачи выбирается очередь с минимальным отношением **MAX(CvvRvv,CvvPvv) / Weight** (**Weight** - вес очереди) и запускается первая задача из этой очереди (если не превышен лимит по использованию ресурсов в очереди). После этого обновляются значения **CvvRvv**, **CvvPvv** и процесс повторяется.

### Неактивные очереди
Если в очереди нет ни одной ожидающей или исполняемой задачи, то очередь становится неактивной. Очевидно, что неактивные очереди могут сильно отстать от других очередей в потреблении ресурсов. Для избежания перекоса в распределении ресурсов после того, как такая очередь вновь станет активной, при активации очереди ее значения потребления ресурсов корректируются. Если очередь становится активной и есть другие активные очереди, то **CvvRvv / Weight**, **CvvPvv / Weight** активируемой очереди не могут быть меньше соответствующих значений какой либо из активных очередей. При необходимости значения корректируются.

### Интерфейс с Resource Broker
Для управления задачами в Resource Broker используется следующий набор сообщений:
``` cpp
struct TEvResourceBroker {
  enum EEv {
    EvSubmitTask = EventSpaceBegin(TKikimrEvents::ES_RESOURCE_BROKER),
    EvUpdateTask,
    EvUpdateTaskCookie,
    EvRemoveTask,
    EvFinishTask,
    EvNotifyActorDied,
    EvConfigure,

    EvTaskOperationError = EvSubmitTask + 512,
    EvResourceAllocated,
    EvConfigureResult
  };
};
```
#### TEvSubmitTask
Это сообщение используется для добавления задачи в очередь. Идентификатор задачи может использоваться для дальнейшего управления задачей. Идентификаторы должны быть уникальны среди запланированных задач от одного клиента. В случае ошибки Resource Broker присылает TEvTaskOperationError.
``` cpp
struct TEvSubmitTask : TEventLocal<TEvSubmitTask, EvSubmitTask> {
    TTask Task;
};

struct TStatus {
    enum ECode {
        // Cannot submit task with already used ID.
        ALREADY_EXISTS,
        // Cannot update/remove/finish task with unknown ID.
        UNKNOWN_TASK,
        // Cannot remove task in-fly.
        TASK_IN_FLY,
        // Cannot finish task which is still in queue.
        TASK_IN_QUEUE
    };

    ECode Code;
    TString Message
};

struct TEvTaskOperationError : public TEventLocal<TEvTaskOperationError, EvTaskOperationError> {
    ui64 TaskId;
    TStatus Status;
    TIntrusivePtr<TThrRefBase> Cookie;
};
```
#### TEvUpdateTask
Это сообщение позволяет изменить приоритет, тип и потребляемые ресурсы задачи. Если задача находится в исполнении, то она может быть возвращена назад в очередь с помощью флага Resubmit.
``` cpp
struct TEvUpdateTask : TEventLocal<TEvUpdateTask, EvUpdateTask> {
    ui64 TaskId;
    TResourceValues RequiredResources;
    TString Type;
    ui64 Priority;
    bool Resubmit;
};
```
#### TEvUpdateTaskCookie
Это сообщение позволяет изменить Cookie задачи. В случае ошибки Resource Broker присылает TEvTaskOperationError.
``` cpp
struct TEvUpdateTaskCookie : TEventLocal<TEvUpdateTaskCookie, EvUpdateTaskCookie> {
    ui64 TaskId;
    TIntrusivePtr<TThrRefBase> Cookie;
};
```
#### TEvRemoveTask
Это сообщение удаляет задачу из очереди. Не может применяться к уже запущенным задачам. В случае ошибки Resource Broker присылает TEvTaskOperationError.

``` cpp
struct TEvRemoveTask : TEventLocal<TEvRemoveTask, EvRemoveTask> {
    ui64 TaskId;
};
```
#### TEvFinishTask
Это сообщение используется для завершения задачи и освобождения используемых ею ресурсов. В случае ошибки Resource Broker присылает TEvTaskOperationError.

``` cpp
struct TEvFinishTask : TEventLocal<TEvFinishTask, EvFinishTask> {
    ui64 TaskId;
};
```
#### TEvNotifyActorDied
Сообщение используется для удаления всех задач актора.
``` cpp
struct TEvNotifyActorDied : public TEventLocal<TEvNotifyActorDied, EvNotifyActorDied> {
};
```#### TEvResourceAllocated
Это сообщение отправляется клиенту Resource Broker-а после аллокации ресурсов для его задачи.
``` cpp
struct TEvResourceAllocated : TEventLocal<TEvResourceAllocated, EvResourceAllocated> {
    ui64 TaskId;
    TIntrusivePtr<TThrRefBase> Cookie;
};
```
#### TEvConfigure
Это сообщение используется для изменения конфигурации Resource Broker-а. При этом все текущие задачи перераспределяются по новым очередям. В ответ отправляется сообщение TEvConfigureResult. При перезагрузке ноды будет снова использован конфиг из статического конфига.
``` cpp
struct TEvConfigure : public TEventPB<TEvConfigure,
                                      NKikimrResourceBroker::TResourceBrokerConfig,
                                      EvConfigure> {
};

message TResourceBrokerConfigResult {
    optional bool Success = 1;
    optional string Message = 2;
};

struct TEvConfigureResult : public TEventPB<TEvConfigureResult,
                                            NKikimrResourceBroker::TResourceBrokerConfigResult,
                                            EvConfigureResult> {
};
```
