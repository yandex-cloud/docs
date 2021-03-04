## Необходимые этапы настройки кластера KiKiMR

Настройка кластера KiKiMR может быть разбита на несколько этапов:

 1. Сбор информации о ресурсах будущего кластера;
 2. Создание статической конфигурации кластера;
 3. Выполнение деплоя с использованием системы деплоя заказчика;
 4. Динамическая конфигурация кластера после выполнения деплоя.

### Сбор информации о ресурсах и описание будущего кластера

Для выполнения этапа создания статической конфигурации кластера нужно **собрать и описать** необходимую информацию о будущем кластере. Для этого нужно создать конфигурационный YAML файл, который мы будем называть **описанием кластера**. Файл с описанием кластера нужен для **KiKiMRConfigurator**, который умеет подготавливать файлы статической конфигурации. Для этого важно определить, на каких хостах KiKiMR будет запущен, в каких дата-центрах находятся хосты и в каких стойках. Кроме того, необходимо указать путь до бинарного файла KiKiMR. Нужно описать диски, которые имеются в распоряжении, указать их тип и путь до них. 

### Настройка кластера с использованием инструмента по конфигурации

#### Собрать программу kikimr_configure

Чтобы собрать программу: `cd arcadia/kikimr/ydb/cfg/bin && ya make -r --checkout`. В результате будет собран исполняемый файл `kikimr_configure`

#### Описать данные кластера в YAML

Необходимо перечислить все сервера выделенные под кластер, описать диски, которые будут отданы для нужд кластера. Для этого следует создать шаблон с описанием кластера в YAML формате. Нужно указать следующее: 

  * Erasure Coding для статической BlobStorage группы. Например `static_erasure: block-4-2`, `static_erasure: mirror-3-dc`, `static_erasure: none`
  * Список нод в кластере в следующем формате:
``` python
hosts:  # начало описание хостов, далее следует список, содержащий описания каждого хоста.
  - name: "some_hostname" - # hostname, обязательное поле.
    datecenter_id: 231 - # число, ID датацентра, можно не указывать, если это хост зарегистрирован в Golem 
    rack_id: 23  # число, ID стойки, можно не указывать, если это хост зарегистрирован в Golem 
    address: "localhost"  # ip адрес хоста, можно не указывать, если это хост зарегистрирован в Golem
    drives: # начало описания дисков, содержащий описания каждого хоста.
      - path: '/dev/disk/by-partlabel/kikimr-hdd-1' # путь до диска
        type: 'ROT' # тип диска
      - path: '/dev/disk/by-partlabel/kikimr-ssd-1'
        type: 'SSD'
  - name: "hostname"
    datecenter_id: 5
    rack_id: 2
    address: "localhost"
    drives:
      - path: '/dev/disk/by-partlabel/kikimr-hdd-1'
        type: 'ROT'
...        
```  
* Описать динамическую конфигурацию BlobStorage следующим образом:

``` python
storage_pools:
  - storage_pool_id: 1 # ID пула, различные числа.
    num_groups: 2 # количество групп
    erasure: block-4-2
    filter_properties:
      type: ROT
  - storage_pool_id: 2
    num_groups: 2 # количество групп
    erasure: mirror-3
    filter_properties:
      type: SSD
```
  * Примеры готовых шаблонов описаны здесь: [раз](https://a.yandex-team.ru/arc/diff/trunk/arcadia/kikimr/scripts/man_slice_2/cluster.yaml), [два](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/ydb/cfg/ut/resources/erasure_none/cluster.yaml), [три](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/ydb/cfg/ut/resources/erasure_mirror_3_dc/cluster.yaml) (часть из них тестовые и не содержат актуальных и правдивых данных о кластерах и нодах, эти данные заменены случайными числами / строками)

#### Создание конфигурации

Чтобы создать статическую конфигурацию нужно выполнить команду: `./kikimr_configure cfg cluster.yaml /full/path/to/kikimr/binary/kikimr /full/path/to/output/dir `. В результате выполнения команды в директории `/full/path/to/output/dir` будет лежать статическая конфигурация кластера.

После выполнения выполнения деплоя кластера нужно выполнить `./kikimr_configure cfg cluster.yaml /full/path/to/kikimr/binary/kikimr /full/path/to/output/dir --dynamic ` в результате чего в директории /full/path/to/output/dir/ будут находиться набор скриптов, которые необходимо выполнить для динамической конфигурации кластера. Скрипты будут находится в файлах `*.bash`

PS:

  1. чтобы задеплоить кластер на своем слайсе я пользуюсь довольно простой автоматизацией: ((https://a.yandex-team.ru/arc/trunk/arcadia/junk/gvit/scripts/deployOnSlice.sh deployOnSlice.sh ))
  2. По умолчанию, информация об идентификаторе дата-центра `datacenter_id` и идентификаторе стойки `rack_id` берется из сервиса [Golem](https://ro.admin.yandex-team.ru/api/host_query.sbml), иначе её необходимо задать пользователю вручную в описании кластера или зарегистрировать его в [Golem](https://ro.admin.yandex-team.ru/api/host_query.sbml).

### Процесс создания статической конфигурации по описанию кластера

#### Создание names.txt

Исходя из YAML описания кластера будет создан конфигурационный файл **names.txt**, в котором будут описаны все серверы кластера: их расположение с учетом дата-центра и стойки, адреса и порта, который будет использоваться для Interсonnect. Этот файл будет в виде `.proto`-файла и может выглядеть следующим образом:

``` python
Node {
    NodeId: 1
    Port: 19001
    Address: "2a02:6b8:b000:6702:feaa:14ff:fe65:c90c"
    Host: "kikimr0507.search.yandex.net"
    InterconnectHost: "kikimr0507.search.yandex.net"
    Location {
        DataCenter: 11156
        Rack: 11332
        Body: 1915343
    }
}
Node {
    NodeId: 2
    Port: 19001
    Address: "2a02:6b8:b000:6701:feaa:14ff:fe65:c982"
    Host: "kikimr0555.search.yandex.net"
    InterconnectHost: "kikimr0555.search.yandex.net"
    Location {
        DataCenter: 11156
        Rack: 11441
        Body: 1915588
    }
}
... /* few more hosts to describe */ ...
```
#### Создание bs\_format.txt

В дальнейшем с использованием **names.txt** и информации о дисках будет сформирован конфигурационный файл **bs_format.txt**. В нем собирается информация о всех дисках в кластере, из части которых будет выделена статическая BlobStorage группа. В **bs_format.txt** описываются все диски в следующем виде:

``` python
Drive { RackId: $rack_id NodeId: $node_id Hostname: "kikimrXXXX.search.yandex.net" Type: "SSD" Path: "/dev/disk/by-partlabel/kikimr_ssd_01" Guid: $guid PDiskId: $pdiskid DataCenterId: $dc_id }
```
где,

* `$rack_id` - id стойки;
* `$pdisk_id` - порядковый номер pdisk, от 1 до количества доступных дисков;
* `$node_id`  - порядковый номер ноды кластера, можно узнать с помощью команды:
  * `$ ./kikimr node-by-host --naming-file names.txt --hostname $HOSTNAME`
* `$guid` - случайное 8 байтное число. Например, можно получить так
  * `$ od --read-bytes=8 --address-radix=n --format=u8 /dev/urandom `

#### Создание описания статической группы BlobStorage bs.txt

С использованием уже полученных конфигурационных файлов можно получить конфигурацию статической BlobStorage группы **bs.txt**:

``` bash
$ ./kikimr admin bs genconfig static --bs-format-file bs_format.txt --erasure $STATIC_ERASURE \
   --avdomain 1 --faildomains $STATIC_FAIL_DOMAINS --vdisks 1 --pdisktype $STATIC_TYPE \
   --vdiskkind Default --dx $DX > bs.txt
```
Если параметры выполнения не указаны в описании кластера, то будут взяты параметры по умолчанию:

*  `$STATIC_ERASURE`: нет значения по умолчанию // какое erasure нужно использовать для статической группы, обязательно должен быть указан в описании кластера
*  `$STATIC_TYPE`: ROT // диски каго типа нужно использовать для статической BlobStorage группы.
*  `$STATIC_FAIL_DOMAINS`: 1 // единицы отказа, которые учитываются при создании кластера.
*  `$DX`: rack // определение единицы отказа

#### Создание log.txt

Файл, который задает настройки логирования в кластере. По умолчанию, файл содержит следующие записи:

``` python
Entry { Component: "BS_PROXY" Level: 4 }
Entry { Component: "BS_QUEUE" Level: 6 }
Entry { Component: "LOCAL" Level: 7 }
Entry { Component: "HIVE" Level: 7 }
```
В этот конфигурационный файл можно добавить отдельный компонент и определить уровень логирования для него. Список доступных сервисов описан в ((https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/protos/services.proto proto файле))
Уровни описываются следующим образом:

0. PRI_EMERG
1. PRI_ALERT
2. PRI_CRIT
3. PRI_ERROR
4. PRI_WARN
5. PRI_NOTICE
6. PRI_INFO
7. PRI_DEBUG

Кроме этого, есть отдельная опция, которая передается кластеру при запуске и задает общий уровень логирования для всех сервисов кластера. По умолчанию, он равен 3.
Не рекомендуется  ставить слишком большой уровень логирования из-за слишком большого количества шума в логах.

Пример описания настроек в описании кластера:

``` python
logs:
  global: 3
  entries:
    - name: BS_PROXY
      level: 4
    - name: KQP_WORKER
      level: 7
```
#### Создание boot.txt

Описывает системные таблетки, необходимые для старта кластера, описывает конфигурацию ResourceBroker

Пример конфигурации ResourceBroker. Здесь описаны задачи Compaction, и очереди, в которых они будут выполняться. Так же описываются лимиты на по ресурсам на каждую очередь и общие ресурсы.

``` python
ResourceBroker {
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
            Resource: 10
        }
    }
    Queues {
        Name: "queue_compaction_gen1"
        Weight: 100
        Limit {
            Resource: 6
        }
    }
    Queues {
        Name: "queue_compaction_gen2"
        Weight: 100
        Limit {
            Resource: 3
        }
    }
    Queues {
        Name: "queue_compaction_gen3"
        Weight: 100
        Limit {
            Resource: 3
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
        Resource: 20
        Resource: 17179869184
    }
}
```
Примеры описания системной таблетки:

``` python
Tablet {
    Type: FLAT_BS_CONTROLLER
    Node: [1, 2, 3, 4, 5, 6, 7, 8]  // список нод или нода, на которой можно запустить таблетку
    Info {
        TabletID: $tablet_id - специальным образом определенное число: алгоритм записан здесь https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/core/base/tabletid.h и https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/ydb/cfg/types.py?rev=3250107#L108
        Channels { Channel: 0 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
        Channels { Channel: 1 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
        Channels { Channel: 2 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
    }
}
Tablet {
    Type: TX_ALLOCATOR
    Node: 1  // список нод или нода, на которой можно запустить таблетку
    Info {
        TabletID: $tablet_id
        Channels { Channel: 0 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
        Channels { Channel: 1 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
        Channels { Channel: 2 ChannelErasureName: "$STATIC_ERASURE" History { FromGeneration: 0 GroupID: 0 } }
    }
}
```
Системные таблетки должны присутствовать в следующем количестве:

1. FLAT_BS_CONTROLLER - 1
2. FLAT_SCHEMESHARD - 1
3. FLAT_HIVE - 1
3. FLAT_TX_COORDINATOR по формуле: `min(16, max(1, NODE_COUNT / 4 + 1))`
4. TX_MEDIATOR по формуле `min(16, max(1, NODE_COUNT / 4 + 1))`
5. TX_ALLOCATOR - по формуле `min(16, max(1, NODE_COUNT / 4 + 1))`

#### Создание ic.txt

Обычно используются следующие конфигурации по умолчанию:

``` python
##################################################################
# Default configuration values
##################################################################
# SelfKickDelay { Microseconds: 0 }
# HandshakeTimeout { Milliseconds: 100 }
# HeartbeatInterval { Seconds: 1 }
# DeadPeerTimeout { Seconds: 10 }
# SendBufferDieLimitInMB: 512             # 512 Mb
# CloseOnIdleTimeout { Seconds: 0 }
# MaxInflightAmountOfDataInKB: 256        # 256 Kb
# MergePerPeerCounters: false
# TCPSocketBufferSize: 16777216           # 16Mb
```
#### Создание grpc.txt

Обычно используются следующие значения по умолчанию:

``` python
StartGRpcProxy: true
Host: "[::]"
Port: 2135  // порт
GRpcMemoryQuotaBytes: 1000000000  // квота памяти в байтах для GRPC Proxy
```
#### Создание kqp.txt

``` python
Enable: true // включает KiKiMR Query Processor, нужно для выполнения YQL over KiKiMR запросов.
```
#### Создание channels.txt

``` python
Profile {
    ProfileId: 0
    Channel { ErasureSpecies: "$STATIC_ERASURE" PDiskCategory: 0 VDiskCategory: Default}
    Channel { ErasureSpecies: "$STATIC_ERASURE" PDiskCategory: 0 VDiskCategory: Default}
    Channel { ErasureSpecies: "$STATIC_ERASURE" PDiskCategory: 0 VDiskCategory: Default}
}
```
#### Создание DefaultDataShardConfig

Задает настройки DataShard. Используется следующая конфигурация по умолчанию.

``` python
DefaultDataShardConfig {
    Init {
        DisableSnapshots: true
    }
    SnapshotPolicy {
        SnapshotCountLimit: 1
        StartStep: 1
        DeltaStep: 60000
    }
    FlowControl {
        LocalBaseInFlyLimit: 500
        PreparedInFlyMax: 100
        PreparedInFlyUpFactor: 1.0000
        PreparedInFlyDownFactor: 1.0000
    }
    ExecutorSettings {
        DatabasePolicy {
            MainCacheSize: 15
            CompactionPolicy {
                InMemForceSizeToSnapshot: 6400000
                InMemForceStepsToSnapshot: 5000
                Generation {
                    GenerationId: 1
                    SizeToCompact: 64000000
                    CountToCompact: 5
                    ForceCountToCompact: 10
                    ForceSizeToCompact: 640000000
                }
            }
        }
    }
}
```
#### Создание vdisks.txt

Описывает типы VDisk. Значение по умолчанию следующее:

``` python
VDiskKinds {
    Kind: Log
    BaseKind: Default
    Config {
        FreshUseDreg: true
        AllowKeepFlags: false
    }
}
VDiskKinds {
    Kind: LocalMode
    BaseKind: Default
    Config {
        HullCompLevel0MaxSstsAtOnce: 2
        HullCompSortedPartsNum: 1
    }
}
```
#### Создание sys.txt

На данный момент используется следующие значения по умолчанию:

``` python
Executor {
    Type: BASIC
    Threads: 9
    SpinThreshold: 1
    Name: "System"
}
SysExecutor: 0

Executor {
    Type: BASIC
    Threads: 16
    SpinThreshold: 1
    Name: "User"
}
UserExecutor: 1

Executor {
    Type: BASIC
    Threads: 7
    SpinThreshold: 1
    Name: "Batch"
}
BatchExecutor: 2

Executor {
    Type: IO
    Threads: 1
    Name: "IO"
}
IoExecutor: 3

Executor {
    Type: BASIC
    Threads: 3
    SpinThreshold: 10
    Name: "IC"
    TimePerMailboxMicroSecs: 100
}

Scheduler {
    Resolution: 64
    SpinThreshold: 0
    ProgressThreshold: 10000
}

ServiceExecutor {
    ServiceName: "Interconnect"
    ExecutorId: 4
}
```
#### Создание memlog.txt

``` python
LogBufferSize: 1073741824
LogGrainSize: 1048576
```
#### Создание feature\_flags.txt

Позволяет включать некоторые новые опциональные возможности. Следует уточнить у разработчиков, нужно ли включать дополнительные возможности.

#### Создание domains.txt

Имеет следующий формат:

``` python
Domain {
    DomainId: 1
$COORDINATOR_LIST // список координаторов
$MEDIATOR_LIST // список медиаторов
$PROXY_LIST // список проксей, обычно все ноды домена.
    SSId: 1
    HiveUid: 1

    PlanResolution: 10

    SchemeRoot: 0x01001000008401F0
    Name: "Root"
}

StateStorage {
    SSId: 1
    Ring {
        NToSelect: $N_TO_SELECT
        Node: 1
        ...
        Node: $NODE_CONT
    }
}

HiveConfig {
    HiveUid: 1
    Hive: 0x010000000000A001
}
```
`$N_TO_SELECT` нечетное число. Если в кластере больше 5 нод, то рекомендуется использовать значение 5. В случае mirror-3* кластеров рекомендуется 9.
Ноды в StateStorage должны быть выбраны с точки зрения FailDomainType. Если FailDomainType это Rack, то не должно быть нод из одной стойки в StateStorage.