---
editable: false
---

# Метод create
Создает секрет в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://lockbox.api.cloud.yandex.net/lockbox/v1/secrets
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "kmsKeyId": "string",
  "versionDescription": "string",
  "versionPayloadEntries": [
    {
      "key": "string",

      // `versionPayloadEntries[]` включает только одно из полей `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // конец списка возможных полей`versionPayloadEntries[]`

    }
  ],
  "deletionProtection": true
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором создается секрет.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя секрета.</p> <p>Максимальная длина строки в символах — 100.</p> 
description | **string**<br><p>Описание секрета.</p> <p>Максимальная длина строки в символах — 1024.</p> 
labels | **object**<br><p>Пользовательские метки для секрета в виде пар `key:value`. Максимум 64 на ключ. Например, `&quot;project&quot;: &quot;mvp&quot;` или `&quot;source&quot;: &quot;dictionary&quot;`.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
kmsKeyId | **string**<br><p>(опционально) Идентификатор ключа KMS. Используется для шифрования и расшифровки секрета.</p> <p>Максимальная длина строки в символах — 50.</p> 
versionDescription | **string**<br><p>Описание первой версии.</p> <p>Максимальная длина строки в символах — 256.</p> 
versionPayloadEntries[] | **object**<br><p>Содержимое первой версии секрета.</p> <p>Максимальное количество элементов — 32.</p> 
versionPayloadEntries[].<br>key | **string**<br><p>Обязательное поле. Неконфиденциальный ключ содержимого версии.</p> <p>Максимальная длина строки в символах — 256. Значение должно соответствовать регулярному выражению `` [.-_0-9a-zA-Z]+ ``.</p> 
versionPayloadEntries[].<br>textValue | **string** <br>`versionPayloadEntries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Используйте это поле для задания текстового значения.</p> <p>Максимальная длина строки в символах — 65536.</p> 
versionPayloadEntries[].<br>binaryValue | **string** (byte) <br>`versionPayloadEntries[]` включает только одно из полей `textValue`, `binaryValue`<br><br><p>Используйте это поле для установки двоичного значения.</p> <p>Максимальная длина строки в символах — 65536.</p> 
deletionProtection | **boolean** (boolean)<br><p>Флаг, запрещающий удаление секрета.</p> 
 
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