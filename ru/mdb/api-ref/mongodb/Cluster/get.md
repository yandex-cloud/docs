# Метод get
Возвращает указанный ресурс Cluster для MongoDB.
 
Чтобы получить список доступных ресурсов Cluster для MongoDB,
отправьте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).
 
## HTTP-запрос {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Cluster для MongoDB. Подробнее см. [документацию MDB](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер MongoDB.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера MongoDB. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MongoDB как пары <code>key:value</code>. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера MongoDB.</p> <p>Среда развертывания.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring | **object**<br><p>Система мониторинга.</p> 
monitoring.<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring.<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring.<br>link | **string**<br><p>Ссылка на графики системы мониторинга для данного кластера MongoDB.</p> 
config | **object**<br><p>Конфигурация кластера MongoDB.</p> 
config.<br>version | **string**<br><p>Версия серверного программного обеспечения MongoDB.</p> 
config.<br>mongodb_3_6 | **object** <br>`config` включает только одно из полей `mongodb_3_6`<br><br>
config.<br>mongodb_3_6.<br>mongod | **object**<br><p>Конфигурация и распределение ресурсов для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br><p>Конфигурация сервера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MongoDB 3.6 (сочетание параметров, определенных в userConfig и [default_config]).</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>Раздел <code>storage</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">журнала</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>Раздел <code>operationProfiling</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Раздел <code>net</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MongoDB 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>Раздел <code>storage</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">журнала</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>Раздел <code>operationProfiling</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>Раздел <code>net</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MongoDB 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>Раздел <code>storage</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">журнала</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>Раздел <code>operationProfiling</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Раздел <code>net</code> конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные хостам MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/mdb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-nvme — сетевой SSD-диск;</li> <li>local-nvme — локальное SSD-хранилище.</li> </ul> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно ([Host.health] для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально ([Host.health] для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает ([Host.health] для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально ([Host.health] по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> </ul> 