---
editable: false
---

# Метод update
Изменяет указанный кластер MySQL.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL, который следует изменить. Чтобы получить идентификатор MySQL кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
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
    "mysqlConfig_5_7": {
      "innodbBufferPoolSize": "integer",
      "maxConnections": "integer",
      "longQueryTime": "number"
    }
  },
  "name": "string"
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Маска, которая указывает, какие атрибуты кластера MySQL должны быть изменены.</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре <code>updateMask</code> и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается <code>updateMask</code>, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
description | **string**<br><p>Новое описание кластера MySQL.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MySQL в виде пар <code>key:value</code>. Максимум 64 на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода <a href="/docs/managed-mysql/api-ref/Cluster/get">get</a>, затем отправьте запрос <a href="/docs/managed-mysql/api-ref/Cluster/update">update</a>, добавив новую метку в этот набор.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
configSpec | **object**<br><p>Новая конфигурация и ресурсы для хостов кластера.</p> 
configSpec.<br>version | **string**<br><p>Версия MySQL, используемая в кластере. Возможные значения:</p> <ul> <li>5.7</li> </ul> 
configSpec.<br>resources | **object**<br>Ресурсы, выделенные хостам MySQL.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mysql/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-nvme — сетевой SSD-диск;</li> <li>local-nvme — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Описывает время суток. Дата и часовой пояс либо не имеют значения, либо указаны другим образом. API может разрешить високосные секунды. Связанные типы: [google.type.Date][google.type.Date] и <code>google.protobuf.Timestamp</code>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Час в 24-часовом формате. Допустимые значения — от 0 до 23. API может разрешить значение &quot;24:00:00&quot; для таких сценариев, как время закрытия заведения.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минута часа. Допустимые значения — от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунда минуты. Обычно допустимые значения — от 0 до 59. API может разрешить значение 60, если поддерживаются високосные секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды, в наносекундах. Допустимые значения — от 0 до 999 999 999.</p> 
configSpec.<br>mysqlConfig_5_7 | **object**<br>Конфигурация для кластера MySQL 5.7.<br><p>Поля и структура <code>MysqlConfig5_7</code> отражает параметры конфигурации MySQL 5.7.</p> 
configSpec.<br>mysqlConfig_5_7.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Размер буфера InnoDB, который используется для кэширования данных таблиц и индексов.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>Минимальное значение — 5242880.</p> 
configSpec.<br>mysqlConfig_5_7.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает MySQL.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Допустимые значения — от 10 до 10000 включительно.</p> 
configSpec.<br>mysqlConfig_5_7.<br>longQueryTime | **number** (double)<br><p>Время, в течение которого запрос должен обрабатываться, прежде чем он начинает считаться медленным.</p> <p>Подробнее см. в <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
name | **string**<br><p>Новое имя кластера.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
 
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
id | **string**<br><p>Только для вывода. Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Только для вывода. Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 