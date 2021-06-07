---
editable: false
---

# Метод create
Создает кластер SQL Server в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
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
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    }
  },
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором будет создан кластер SQL Server.</p> <p>Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Имя кластера SQL Server. Имя должно быть уникальным в рамках каталога.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Описание кластера SQL Server.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера SQL Server в виде пар ``key:value``. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Среда развертывания кластера SQL Server.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Конфигурация SQL Server и хостов для кластера.</p> 
configSpec.<br>version | **string**<br><p>Версия SQL Server, используемая в кластере.</p> <p>Возможные значения:</p> <ul> <li>2016sp2</li> </ul> 
configSpec.<br>resources | **object**<br>Ресурсы, выделенные хостам SQL Server.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-sqlserver/concepts/instance-types">документации</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> <p>Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
configSpec.<br>sqlserverConfig_2016Sp2 | **object**<br>Конфигурация кластера SQL Server 2016 SP2.<br><p>Здесь перечислены поддерживаемые параметры конфигурации SQL Server 2016 SP2.</p> <p>Подробное описание всех параметров доступно в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">документации SQL Server</a>.</p> <p>Любые параметры, не перечисленные здесь, не поддерживаются.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Ограничивает число процессоров, задействованных для параллельного выполнения плана для каждой задачи.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 1 до 99 включительно.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>costThresholdForParallelism | **integer** (int64)<br><p>Задает пороговое значение, при котором SQL Server создает и выполняет параллельные планы для запросов.</p> <p>SQL Server создает и выполняет параллельный план для запроса только в том случае, если расчетная стоимость выполнения последовательного плана для того же запроса превышает значение этого параметра.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 5 до 32767 включительно.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>auditLevel | **integer** (int64)<br><p>Настройки аудита входа, необходимого для мониторинга активности подключения к компоненту SQL Server Database Engine.</p> <p>Возможные значения:</p> <ul> <li>0 — не регистрировать попытки входа в систему,</li> <li>1 — регистрировать только неудачные попытки входа в систему,</li> <li>2 — регистрировать только успешные попытки входа в систему (не рекомендуется),</li> <li>3 — регистрировать все попытки входа в систему (не рекомендуется).</li> </ul> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 3 включительно.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>fillFactorPercent | **integer** (int64)<br><p>Задает коэффициент заполнения. Когда индекс создается или перестраивается, коэффициент заполнения отображает процент заполнения пространства каждой страницы конечного уровня, что позволяет зарезервировать оставшееся пространство как свободное — для будущего расширения.</p> <p>Значения 0 и 100 означают полное заполнение страницы (свободное место не резервируется).</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> <p>Допустимые значения — от 0 до 100 включительно.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Определяет, следует ли кэшировать планы запросов только после второго выполнения. Позволяет избежать раздувания кэша SQL из-за одноразовых планов.</p> <p>См. подробное описание в <a href="https://docs.microsoft.com/ru-ru/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">документации SQL Server</a>.</p> 
databaseSpecs[] | **object**<br><p>Одна или несколько конфигураций баз данных, создаваемых в кластере SQL Server.</p> 
databaseSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя базы данных.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_-]*``.</p> 
userSpecs[] | **object**<br><p>Одна или несколько конфигураций пользователей баз данных, создаваемых в кластере SQL Server.</p> 
userSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя пользователя SQL Server.</p> <p>Максимальная длина строки в символах — 32. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_]*``.</p> 
userSpecs[].<br>password | **string**<br><p>Обязательное поле. Пароль пользователя SQL Server.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Набор разрешений, которые следует предоставить пользователю.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, для которой предоставляется разрешение.</p> 
userSpecs[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Члены этой роли могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных SQL Server.</li> <li>DB_SECURITYADMIN: Члены этой роли могут управлять разрешениями и членством в пользовательских ролях. Они потенциально могут повысить свои привилегии, поэтому их действия должны контролироваться.</li> <li>DB_ACCESSADMIN: Члены этой роли могут управлять доступом к базе данных для пользователей Windows, групп Windows и пользователей SQL Server.</li> <li>DB_BACKUPOPERATOR: Члены этой роли могут создавать резервные копии базы данных.</li> <li>DB_DDLADMIN: Члены этой роли могут выполнять в базе данных любую команду языка описания данных (DDL).</li> <li>DB_DATAWRITER: Члены этой роли могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li> <li>DB_DATAREADER: Члены этой роли могут читать все данные из всех пользовательских таблиц.</li> <li>DB_DENYDATAWRITER: Члены этой роли не могут добавлять, изменять или удалять никакие данные в пользовательских таблицах базы данных. Подобное ограничение привилегий имеет более высокий приоритет, чем предоставление, поэтому вы можете использовать эту роль для быстрого ограничения привилегий без явного отзыва разрешений или ролей.</li> <li>DB_DENYDATAREADER: Члены этой фиксированной роли базы данных не могут читать никакие данные из пользовательских таблиц в базе данных. Подобное ограничение привилегий имеет более высокий приоритет, чем предоставление, поэтому вы можете использовать эту роль для быстрого ограничения привилегий без явного отзыва разрешений или ролей.</li> </ul> 
hostSpecs[] | **object**<br><p>Одна или несколько конфигураций хостов, создаваемых в кластере SQL Server.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост.</p> <p>Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле <a href="/docs/managed-sqlserver/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля ``assignPublicIp``.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — назначить хосту публичный IP-адрес.</li> </ul> 
networkId | **string**<br><p>Идентификатор сети, в которой нужно создать кластер SQL Server.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 