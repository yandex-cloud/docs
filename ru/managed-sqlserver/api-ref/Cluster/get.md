---
editable: false
---

# Метод get
Возвращает указанный кластер SQL Server.
 
Чтобы получить список доступных кластеров SQL Server, выполните запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера SQL Server.  Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
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
```
Кластер SQL Server.
Для получения дополнительной информации см. раздел документации [Взаимосвязь ресурсов сервиса](/docs/managed-sqlserver/concepts).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера SQL Server. Этот идентификатор Managed Service for SQL Server генерирует при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер SQL Server.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера SQL Server.</p> <p>Имя должно быть уникальным в каталоге, соответствовать RFC 1035 и иметь длину 1-63 символа.</p> 
description | **string**<br><p>Описание кластера SQL Server. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера SQL Server в виде пар <code>key:value</code>. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера SQL Server.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Описание систем мониторинга, относящихся к кластеру SQL Server.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера SQL Server.</p> 
config | **object**<br><p>Конфигурация кластера SQL Server.</p> 
config.<br>version | **string**<br><p>Версия SQL Server.</p> 
config.<br>resources | **object**<br>Ресурсы, выделенные хостам SQL Server.<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-sqlserver/concepts/instance-types">документации</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> <p>Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
config.<br>sqlserverConfig_2016Sp2 | **object**<br>Конфигурация экземпляра SQL Server 2016sp2.<br>
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Действующие настройки для кластера SQL Server 2016 SP2 (сочетание параметров, определенных в <code>userConfig</code> и <code>defaultConfig</code>).</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа <code>FILESTREAM</code> для экземпляра SQL Server. Технология <code>FILESTREAM</code> позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает <code>FILESTREAM</code>,</li> <li>1 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL,</li> <li>2 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>Пользовательские параметры для кластера SQL Server 2016 SP2.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа <code>FILESTREAM</code> для экземпляра SQL Server. Технология <code>FILESTREAM</code> позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает <code>FILESTREAM</code>,</li> <li>1 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL,</li> <li>2 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Конфигурация кластера SQL Server 2016 SP2 по умолчанию.</p> <p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>Набор правил сортировки, используемых базами данных экземпляра. Определяет, являются ли базы данных экземпляра чувствительными к регистру, акценту и т. д.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Определяет уровень доступа <code>FILESTREAM</code> для экземпляра SQL Server. Технология <code>FILESTREAM</code> позволяет приложениям на базе SQL Server хранить BLOB-объекты, такие как документы и изображения, в файловой системе за пределами базы данных.</p> <p>Возможные значения:</p> <ul> <li>0 — выключает <code>FILESTREAM</code>,</li> <li>1 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL,</li> <li>2 — включает <code>FILESTREAM</code> для доступа с помощью Transact-SQL и потокового доступа Win32.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Определяет результат по умолчанию для распределенных транзакций, которые не удалось разрешить координатору распределенных транзакций Microsoft (MS DTC). Такие транзакции называются сомнительными распределенными транзакциями.</p> <p>Возможные значения:</p> <ul> <li>0 — нет автоматического разрешения. Восстановление завершится неуспешно, если MS DTC не сможет разрешить какую-либо сомнительную транзакцию.</li> <li>1 — сомнительные транзакции считаются подтвержденными,</li> <li>2 — сомнительные транзакции считаются неподтвержденными и будут откачены.</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Включает цепочку владения между базами данных.</p> <p>Пример: имея явный доступ к хранимой процедуре в одной базе данных, которая ссылается на объект в другой базе данных, к которой у вас нет явного доступа, вы сможете выполнить процедуру без ошибки, связанной с разрешением.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (<code>health</code> всех хостов в кластере — <code>UNKNOWN</code>).</li> <li>ALIVE: Кластер работает нормально (<code>health</code> всех хостов в кластере — <code>ALIVE</code>).</li> <li>DEAD: Кластер не работает (<code>health</code> всех хостов в кластере — <code>DEAD</code>).</li> <li>DEGRADED: Кластер находится в состоянии деградации (<code>health</code> по крайней мере одного из хостов в кластере — не <code>ALIVE</code>).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: В кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 