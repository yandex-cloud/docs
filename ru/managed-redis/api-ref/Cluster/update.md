---
editable: false
---

# Метод update
Изменяет указанный кластер Redis.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/managed-redis/v1alpha/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Redis, который следует обновить. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-redis/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
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
      "diskSize": "string"
    },
    "redisConfig_5_0": {
      "maxmemoryPolicy": "string",
      "timeout": "integer",
      "password": "string"
    }
  },
  "name": "string"
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Маска, которая указывает, какие поля кластера Redis должны быть изменены.</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре <code>updateMask</code> и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается <code>updateMask</code>, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
description | **string**<br><p>Новое описание кластера Redis.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера Redis как <code>key:value</code> pairs. Maximum 64 per cluster. For example, `project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода <a href="/docs/managed-redis/api-ref/Cluster/get">get</a>, затем отправьте запрос <a href="/docs/managed-redis/api-ref/Cluster/update">update</a>, добавив новую метку в этот набор.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
configSpec | **object**<br><p>Новая конфигурация и ресурсы для хостов кластера.</p> 
configSpec.<br>version | **string**<br><p>Версия Redis, используемая в кластере. Единственное возможное значение — <code>5.0</code>.</p> 
configSpec.<br>resources | **object**<br>Ресурсы, выделенные хостам Redis.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-redis/concepts/instance-types">документации</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>redisConfig_5_0 | **object**<br><p>Поля и структура <code>RedisConfig</code> отражает параметры файла конфигурации Redis.</p> 
configSpec.<br>redisConfig_5_0.<br>maxmemoryPolicy | **string**<br><p>Политика Redis для отбрасывания ключей из набора данных, который достиг максимального объема памяти, доступного на хосте. Параметр maxmemory зависит от <a href="/docs/managed-redis/concepts/instance-types">host class</a> Managed Service for Redis.</p> <p>Все политики подробно описаны в <a href="https://redis.io/topics/lru-cache">документации Redis</a>.</p> <ul> <li>VOLATILE_LRU: Пытаться удалять менее востребованные (LRU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LRU: Удалять менее востребованные (LRU) ключи.</li> <li>VOLATILE_LFU: Пытаться удалять наименее часто используемые (LFU) ключи с <code>expire set</code>.</li> <li>ALLKEYS_LFU: Удалять наименее часто используемые (LFU) ключи.</li> <li>VOLATILE_RANDOM: Пытаться удалять ключи с <code>expire set</code> в случайном порядке.</li> <li>ALLKEYS_RANDOM: Удалять ключи случайным образом.</li> <li>VOLATILE_TTL: Пытаться сначала удалять менее востребованные (LRU) ключи с <code>expire set</code> и более коротким сроком жизни (TTL).</li> <li>NOEVICTION: Возвращать ошибки, когда память заполнена, и заданные команды могут потребовать больше памяти.</li> </ul> 
configSpec.<br>redisConfig_5_0.<br>timeout | **integer** (int64)<br><p>Время, в течение которого Redis сохраняет подключение открытым, пока клиент бездействует. Если в течение этого времени не получена команда, соединение закрывается.</p> 
configSpec.<br>redisConfig_5_0.<br>password | **string**<br><p>Пароль для аутентификации.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9@=+?*.,!&amp;#$^&lt;&gt;_-]{8,128}</code>.</p> 
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
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 