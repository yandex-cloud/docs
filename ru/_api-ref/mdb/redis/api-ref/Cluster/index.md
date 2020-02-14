---
editable: false
---

# Cluster
Методы для управления кластерами Redis.
## JSON-представление {#representation}
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
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true
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
  "status": "string",
  "sharded": true
}
```
 
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
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-redis/concepts/instance-types">документации</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>backupWindowStart | **object**<br><p>Описывает время суток. Дата и часовой пояс либо не имеют значения, либо указаны другим образом. API может разрешить високосные секунды. Связанные типы: [google.type.Date][google.type.Date] и <code>google.protobuf.Timestamp</code>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Час в 24-часовом формате. Допустимые значения — от 0 до 23. API может разрешить значение &quot;24:00:00&quot; для таких сценариев, как время закрытия заведения.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минута часа. Допустимые значения — от 0 до 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунда минуты. Обычно допустимые значения — от 0 до 59. API может разрешить значение 60, если поддерживаются високосные секунды.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды, в наносекундах. Допустимые значения — от 0 до 999 999 999.</p> 
config.<br>access | **object**<br>
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
config.<br>redisConfig_5_0 | **object**<br>
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
status | **string**<br><p>Состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно</li> <li>CREATING: Кластер создается</li> <li>RUNNING: Кластер работает нормально</li> <li>ERROR: Кластер отказал.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
sharded | **boolean** (boolean)<br><p>Включение/выключение режима Redis Cluster.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[addHosts](addHosts.md) | Создает новые хосты для кластера.
[addShard](addShard.md) | Создает новый шард.
[backup](backup.md) | Создает резервную копию для указанного кластера Redis.
[create](create.md) | Создает кластер Redis в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер Redis.
[deleteHosts](deleteHosts.md) | Удаляет указанные хосты кластера.
[deleteShard](deleteShard.md) | Удаляет указанный шард.
[get](get.md) | Возвращает указанный кластер Redis.
[getShard](getShard.md) | Возвращает указанный шард.
[list](list.md) | Возвращает список кластеров Redis, принадлежащих указанному каталогу.
[listBackups](listBackups.md) | Получает список доступных резервных копий для указанного кластера Redis.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера.
[listLogs](listLogs.md) | Получает логи для указанного кластера Redis.
[listOperations](listOperations.md) | Возвращает список операций для указанного кластера.
[listShards](listShards.md) | Получает список шардов.
[move](move.md) | Перемещает кластер Redis в указанный каталог.
[rebalance](rebalance.md) | Перебалансирует кластер. Равномерно распределяет все хэш-слоты между шардами.
[restore](restore.md) | Создает новый кластер Redis с использованием указанной резервной копии.
[start](start.md) | Запускает указанный кластер Redis.
[startFailover](startFailover.md) | Запускает ручное переключение мастера для указанного кластера Redis.
[stop](stop.md) | Останавливает указанный кластер Redis.
[update](update.md) | Изменяет указанный кластер Redis.