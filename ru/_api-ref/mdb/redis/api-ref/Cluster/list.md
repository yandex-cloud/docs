---
editable: false
---

# Метод list
Возвращает список кластеров Redis, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1alpha/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Redis. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-redis/api-ref/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-redis/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-redis/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-redis/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации кластеров в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](/docs/managed-redis/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "version": "string",
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string"
        },
        "redisConfig_5_0": {
          "effectiveConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "integer",
            "password": "string"
          },
          "userConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "integer",
            "password": "string"
          },
          "defaultConfig": {
            "maxmemoryPolicy": "string",
            "timeout": "integer",
            "password": "string"
          }
        }
      },
      "networkId": "string",
      "health": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Описание кластера Redis. Подробнее смотрите в <a href="/docs/managed-redis/concepts/">документации</a> Managed Service for Redis.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Redis.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера Redis в виде пар <code>key:value</code>. Максимум 64 на кластер.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера Redis.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к данному кластеру Redis.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Redis.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера Redis.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия серверного программного обеспечения Redis.</p> 
clusters[].<br>config.<br>resources | **object**<br>Ресурсы, выделенные хостам Redis.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-redis/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
clusters[].<br>config.<br>redisConfig_5_0 | **object**<br>Конфигурация сервера Redis 5.0.<br>
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера Redis 5.0 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>effectiveConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера Redis 5.0.</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>userConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера Redis 5.0.</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
clusters[].<br>config.<br>redisConfig_5_0.<br>defaultConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
clusters[].<br>networkId | **string**<br>
clusters[].<br>health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Хост находится в неизвестном состоянии (у нас нет данных)</li> <li>ALIVE: Кластер жив и здоров (все хосты живы)</li> <li>DEAD: Кластер не работает и не может выполнять свои основные функции</li> <li>DEGRADED: Кластер частично жив (может выполнять некоторые из своих основных функций)</li> </ul> 
clusters[].<br>status | **string**<br><p>Состояние кластера</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно</li> <li>CREATING: Кластер создается</li> <li>RUNNING: Кластер работает нормально</li> <li>ERROR: Кластер отказал.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-redis/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-redis/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-redis/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-redis/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 