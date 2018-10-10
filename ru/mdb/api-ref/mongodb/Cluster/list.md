# Метод list
Получает список ресурсов Cluster для MongoDB, принадлежащих
указанному каталогу.
 

 
## HTTP-запрос
`GET /managed-mongodb/v1/clusters`
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
folderId | Обязательное поле. Идентификатор каталога для вывода списка кластеров MongoDB. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/mongodb/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](/docs/mdb/api-ref/mongodb/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина — 1000 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
clusters | **object**<br>Ресурс Cluster для MongoDB. Подробнее см. раздел [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts) в руководстве разработчика.
clusters.<br>id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании.
clusters.<br>folderId | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB.
clusters.<br>createdAt | **string** (date-time)<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
clusters.<br>name | **string**<br>Имя кластера MongoDB. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.
clusters.<br>description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.
clusters.<br>labels | **object**<br>Пользовательские метки для кластера MongoDB в виде пар ключ-значение. Максимум 64 на ресурс.
clusters.<br>environment | **string**<br>Среда развертывания кластера MongoDB.  Среда развертывания.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
clusters.<br>monitoring | **object**<br>Система мониторинга.
clusters.<br>monitoring.<br>name | **string**<br>Название системы мониторинга.
clusters.<br>monitoring.<br>description | **string**<br>Описание системы мониторинга.
clusters.<br>monitoring.<br>link | **string**<br>Ссылка на графики системы мониторинга для данного кластера MongoDB.
clusters.<br>config | **object**<br>Конфигурация кластера MongoDB.
clusters.<br>config.<br>version | **string**<br>Версия серверного программного обеспечения MongoDB.
clusters.<br>config.<br>mongodb_3_6 | **object** <br>`clusters.config` включает только одно из полей `mongodb_3_6`<br><br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br>Конфигурация сервера MongoDB 3.6.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br>Действующие параметры для кластера MongoDB 3.6 (сочетание параметров, определенных в userConfig и [default_config]).  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br>`net` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br>Пользовательские настройки для кластера MongoDB 3.6.  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br>`net` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br>Конфигурация по умолчанию для кластера MongoDB 3.6.  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br>`storage` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br>`net` section of mongod configuration.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br>Ресурсы, выделенные хостам MongoDB.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
clusters.<br>config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
clusters.<br>networkId | **string**<br>Идентификатор сети, к которой принадлежит кластер.
clusters.<br>health | **string**<br>Агрегированная работоспособность кластера.   - HEALTH_UNKNOWN: Состояние кластера неизвестно ([Host.health] для каждого хоста в кластере — UNKNOWN).  - ALIVE: Кластер работает нормально ([Host.health] для каждого хоста в кластере — ALIVE).  - DEAD: Кластер не работает ([Host.health] для каждого узла в кластере — DEAD).  - DEGRADED: Кластер работает неоптимально ([Host.health] по крайней мере для одного узла в кластере не ALIVE).<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
clusters.<br>status | **string**<br>Текущее состояние кластера.   - STATUS_UNKNOWN: Состояние кластера неизвестно.  - CREATING: Кластер создается.  - RUNNING: Кластер работает нормально.  - ERROR: На кластере произошла ошибка, блокирующая работу.<br>`STATUS_UNKNOWN`<br>`CREATING`<br>`RUNNING`<br>`ERROR`<br>
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Cluster/list#query_params), используйте [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/list#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/mongodb/Cluster/list#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/list#responses) для перебора страниц результатов.