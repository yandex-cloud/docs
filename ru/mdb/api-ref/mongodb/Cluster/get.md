# Метод get
Возвращает указанный ресурс Cluster для MongoDB.
 
Чтобы получить список доступных ресурсов Cluster для MongoDB,
отправьте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).
 
## HTTP-запрос
`GET /managed-mongodb/v1/clusters/{clusterId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Cluster для MongoDB. Подробнее см. раздел [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts) в
руководстве разработчика.
 
Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании.
folderId | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB.
createdAt | **string** (date-time)<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
name | **string**<br>Имя кластера MongoDB. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.
labels | **object**<br>Пользовательские метки для кластера MongoDB в виде пар ключ-значение. Максимум 64 на ресурс.
environment | **string**<br>Среда развертывания кластера MongoDB.  Среда развертывания.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
monitoring | **object**<br>Система мониторинга.
monitoring.<br>name | **string**<br>Название системы мониторинга.
monitoring.<br>description | **string**<br>Описание системы мониторинга.
monitoring.<br>link | **string**<br>Ссылка на графики системы мониторинга для данного кластера MongoDB.
config | **object**<br>Конфигурация кластера MongoDB.
config.<br>version | **string**<br>Версия серверного программного обеспечения MongoDB.
config.<br>mongodb_3_6 | **object** <br>`config` включает только одно из полей `mongodb_3_6`<br><br>
config.<br>mongodb_3_6.<br>mongod | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6.
config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br>Конфигурация сервера MongoDB 3.6.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br>Действующие параметры для кластера MongoDB 3.6 (сочетание параметров, определенных в userConfig и [default_config]).  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br>`net` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br>Пользовательские настройки для кластера MongoDB 3.6.  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br>`net` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br>Конфигурация по умолчанию для кластера MongoDB 3.6.  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br>`net` section of mongod configuration.
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br>Ресурсы, выделенные хостам MongoDB.
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
networkId | **string**<br>Идентификатор сети, к которой принадлежит кластер.
health | **string**<br>Агрегированная работоспособность кластера.   - HEALTH_UNKNOWN: Состояние кластера неизвестно ([Host.health] для каждого хоста в кластере — UNKNOWN).  - ALIVE: Кластер работает нормально ([Host.health] для каждого хоста в кластере — ALIVE).  - DEAD: Кластер не работает ([Host.health] для каждого узла в кластере — DEAD).  - DEGRADED: Кластер работает неоптимально ([Host.health] по крайней мере для одного узла в кластере не ALIVE).<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
status | **string**<br>Текущее состояние кластера.   - STATUS_UNKNOWN: Состояние кластера неизвестно.  - CREATING: Кластер создается.  - RUNNING: Кластер работает нормально.  - ERROR: На кластере произошла ошибка, блокирующая работу.<br>`STATUS_UNKNOWN`<br>`CREATING`<br>`RUNNING`<br>`ERROR`<br>