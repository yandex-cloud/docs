---
editable: false
---

# Метод upsertRecordSets
Метод без строгого контроля за изменением состояния зоны. Если удаленная запись не существует, ничего не происходит. Удаляет записи, соответствующие всем
указанным полям, что позволяет удалять только указанные записи из набора записей.
 

 
## HTTP-запрос {#https-request}
```
POST https://dns.api.cloud.yandex.net/dns/v1/zones/{dnsZoneId}:upsertRecordSets
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
dnsZoneId | Идентификатор зоны DNS, в которую нужно добавить новую запись или обновить существующую.  Чтобы получить идентификатор зоны DNS, выполните запрос [list](/docs/dns/api-ref/DnsZone/list).  Длина строки в символах должна быть равна 20.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "deletions": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "replacements": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "merges": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ]
}
```

 
Поле | Описание
--- | ---
deletions[] | **object**<br><p>Набор записей. Подробнее см. в разделе <a href="/docs/dns/concepts/resource-record">Ресурсные записи</a>.</p> 
deletions[].<br>name | **string**<br><p>Доменное имя.</p> <p>Длина строки в символах должна быть от 1 до 254.</p> 
deletions[].<br>type | **string**<br><p>Тип записи.</p> <p>Длина строки в символах должна быть от 1 до 20.</p> 
deletions[].<br>ttl | **string** (int64)<br><p>Время жизни записи в секундах.</p> <p>Допустимые значения — от 0 до 2147483647 включительно.</p> 
deletions[].<br>data[] | **string**<br><p>Обязательное поле. Значение набора записей.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.</p> 
replacements[] | **object**<br><p>Набор записей. Подробнее см. в разделе <a href="/docs/dns/concepts/resource-record">Ресурсные записи</a>.</p> 
replacements[].<br>name | **string**<br><p>Доменное имя.</p> <p>Длина строки в символах должна быть от 1 до 254.</p> 
replacements[].<br>type | **string**<br><p>Тип записи.</p> <p>Длина строки в символах должна быть от 1 до 20.</p> 
replacements[].<br>ttl | **string** (int64)<br><p>Время жизни записи в секундах.</p> <p>Допустимые значения — от 0 до 2147483647 включительно.</p> 
replacements[].<br>data[] | **string**<br><p>Обязательное поле. Значение набора записей.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.</p> 
merges[] | **object**<br><p>Набор записей. Подробнее см. в разделе <a href="/docs/dns/concepts/resource-record">Ресурсные записи</a>.</p> 
merges[].<br>name | **string**<br><p>Доменное имя.</p> <p>Длина строки в символах должна быть от 1 до 254.</p> 
merges[].<br>type | **string**<br><p>Тип записи.</p> <p>Длина строки в символах должна быть от 1 до 20.</p> 
merges[].<br>ttl | **string** (int64)<br><p>Время жизни записи в секундах.</p> <p>Допустимые значения — от 0 до 2147483647 включительно.</p> 
merges[].<br>data[] | **string**<br><p>Обязательное поле. Значение набора записей.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 100. Длина строки в символах для каждого значения должна быть от 1 до 255.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 