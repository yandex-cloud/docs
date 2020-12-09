---
editable: false
---

# Метод list
Получает список кластеров SQL Server, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров SQL Server.  Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную. В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](/docs/managed-sqlserver/api-ref/Cluster#representation). 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.  Пример фильтра: `name NOT IN 'test,beta'`.  Максимальная длина строки в символах — 1000.
 
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
        "sqlserverConfig_2016Sp2": {
          "effectiveConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
          },
          "userConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
          },
          "defaultConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
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
clusters[] | **object**<br><p>Кластер SQL Server. Для получения дополнительной информации см. раздел документации <a href="/docs/managed-sqlserver/concepts">Взаимосвязь ресурсов сервиса</a>.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера SQL Server. Этот идентификатор Managed Service for SQL Server генерирует при создании.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер SQL Server.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера SQL Server.</p> <p>Имя должно быть уникальным в каталоге, соответствовать RFC 1035 и иметь длину 1-63 символа.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера SQL Server. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера SQL Server в виде пар `key:value`. Максимум 64 на ресурс.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера SQL Server.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к кластеру SQL Server.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера SQL Server.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера SQL Server.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия SQL Server.</p> 
clusters[].<br>config.<br>resources | **object**<br>Ресурсы, выделенные хостам SQL Server.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-sqlserver/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> <p>Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2 | **object**<br>Конфигурация экземпляра SQL Server 2016sp2.<br>
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера SQL Server 2016 SP2 (сочетание параметров, определенных в `userConfig` и `defaultConfig`).</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа `FILESTREAM` для экземпляра SQL Server. Технология `FILESTREAM` позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает `FILESTREAM`,</li> <li>1 — включает `FILESTREAM` для доступа с помощью Transact-SQL,</li> <li>2 — включает `FILESTREAM` для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>Пользовательские параметры для кластера SQL Server 2016 SP2.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа `FILESTREAM` для экземпляра SQL Server. Технология `FILESTREAM` позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает `FILESTREAM`,</li> <li>1 — включает `FILESTREAM` для доступа с помощью Transact-SQL,</li> <li>2 — включает `FILESTREAM` для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Конфигурация кластера SQL Server 2016 SP2 по умолчанию.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа `FILESTREAM` для экземпляра SQL Server. Технология `FILESTREAM` позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает `FILESTREAM`,</li> <li>1 — включает `FILESTREAM` для доступа с помощью Transact-SQL,</li> <li>2 — включает `FILESTREAM` для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
clusters[].<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters[].<br>health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (`health` всех хостов в кластере — `UNKNOWN`).</li> <li>ALIVE: Кластер работает нормально (`health` всех хостов в кластере — `ALIVE`).</li> <li>DEAD: Кластер не работает (`health` всех хостов в кластере — `DEAD`).</li> <li>DEGRADED: Кластер находится в состоянии деградации (`health` по крайней мере одного из хостов в кластере — не `ALIVE`).</li> </ul> 
clusters[].<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: В кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageSize</a>, используйте `next_page_token` в качестве значения параметра <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов.</p> 