---
editable: false
---

# Метод list
Возвращает список кластеров MySQL, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров MySQL. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mysql/api-ref/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mysql/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе. В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](/docs/managed-mysql/api-ref/Cluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Должен содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.  Максимальная длина строки в символах — 1000.
 
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
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "backupWindowStart": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "mysqlConfig_5_7": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
          },
          "userConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
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
clusters[] | **object**<br><p>Кластер MySQL. Подробнее см. в <a href="/docs/managed-mysql/concepts">документации</a>.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера MySQL. Этот идентификатор Managed Service for MySQL генерирует при создании.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер MySQL.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера MySQL. Имя должно быть уникальным в каталоге, соответствовать RFC 1035 и иметь длину 1-63 символа.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера MySQL. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера MySQL в виде пар <code>key:value</code>. Максимум 64 на ресурс.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера MySQL.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к данному кластеру MySQL.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера MySQL.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера MySQL.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия серверного программного обеспечения MySQL.</p> 
clusters[].<br>config.<br>resources | **object**<br>Ресурсы, выделенные хостам MySQL.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mysql/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7 | **object**<br>Конфигурация сервера MySQL 5.7.<br>
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MySQL 5.7 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MySQL 5.7.</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MySQL 5.7.</p> <p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">описании переменной в документации MySQL</a>.</p> <p>Минимальное значение — 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">описании переменной в документации MySQL</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">описании переменной в документации MySQL</a>.</p> 
clusters[].<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters[].<br>health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (<code>health</code> для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (<code>health</code> для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (<code>health</code> для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (<code>health</code> по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 