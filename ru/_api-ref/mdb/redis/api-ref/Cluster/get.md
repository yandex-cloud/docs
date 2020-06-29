---
editable: false
---

# Метод get
Возвращает указанный кластер Redis.
 
Чтобы получить список доступных резервных копий Redis, используйте запрос [list](/docs/managed-redis/api-ref/Cluster/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1alpha/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого кластера Redis. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-redis/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Описание кластера Redis. Подробнее смотрите в [документации](/docs/managed-redis/concepts/) Managed Service for Redis.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Redis.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера Redis в виде пар <code>key:value</code>. Максимум 64 на кластер.</p> 
environment | **string**<br><p>Среда развертывания кластера Redis.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к данному кластеру Redis.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Redis.</p> 
config | **object**<br><p>Конфигурация кластера Redis.</p> 
config.<br>version | **string**<br><p>Версия серверного программного обеспечения Redis.</p> 
config.<br>resources | **object**<br>Ресурсы, выделенные хостам Redis.<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-redis/concepts/instance-types">документации</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>redisConfig_5_0 | **object**<br>Конфигурация сервера Redis 5.0.<br>
config.<br>redisConfig_5_0.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера Redis 5.0 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
config.<br>redisConfig_5_0.<br>effectiveConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
config.<br>redisConfig_5_0.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера Redis 5.0.</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
config.<br>redisConfig_5_0.<br>userConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
config.<br>redisConfig_5_0.<br>userConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера Redis 5.0.</p> <p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
config.<br>redisConfig_5_0.<br>defaultConfig.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
networkId | **string**<br>
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Хост находится в неизвестном состоянии (у нас нет данных)</li> <li>ALIVE: Кластер жив и здоров (все хосты живы)</li> <li>DEAD: Кластер не работает и не может выполнять свои основные функции</li> <li>DEGRADED: Кластер частично жив (может выполнять некоторые из своих основных функций)</li> </ul> 
status | **string**<br><p>Состояние кластера</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно</li> <li>CREATING: Кластер создается</li> <li>RUNNING: Кластер работает нормально</li> <li>ERROR: Кластер отказал.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 