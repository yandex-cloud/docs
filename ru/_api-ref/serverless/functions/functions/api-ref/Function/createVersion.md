---
editable: false
---

# Метод createVersion
Создает версию для указанной функции.
 

 
## HTTP-запрос {#https-request}
```
POST https://serverless-functions.api.cloud.yandex.net/functions/v1/versions
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "functionId": "string",
  "runtime": "string",
  "description": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "environment": "object",

  //  включает только одно из полей `package`, `content`
  "package": {
    "bucketName": "string",
    "objectName": "string",
    "sha256": "string"
  },
  "content": "string",
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
functionId | **string**<br><p>Обязательное поле. Идентификатор функции для создания версии.</p> <p>Чтобы получить идентификатор функции, используйте запрос <a href="/docs/functions/functions/api-ref/Function/list">list</a> .</p> 
runtime | **string**<br><p>Обязательное поле. Среда выполнения для версии.</p> 
description | **string**<br><p>Описание версии.</p> <p>Длина строки в символах должна быть от 0 до 256.</p> 
entrypoint | **string**<br><p>Обязательное поле. Точка входа для версии.</p> 
resources | **object**<br>Обязательное поле. Ресурсы, выделенные для версии.<br><p>Ресурсы, выделенные для версии.</p> 
resources.<br>memory | **string** (int64)<br><p>Объем памяти в байтах, доступный для версии.</p> <p>Допустимые значения — от 33554432 до 1073741824 включительно.</p> 
executionTimeout | **string**<br><p>Обязательное поле. Таймаут для выполнения версии.</p> <p>Если время ожидания будет превышено, Cloud Functions возвращает 504 HTTP-код.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта, который нужно связать с версией.</p> 
environment | **object**<br><p>Параметры среды выполнения для версии.</p> <p>Каждый ключ должен соответствовать регулярному выражению `` [a-zA-Z][a-zA-Z0-9_]* ``. Максимальная длина строки в символах для каждого значения — 4096.</p> 
package | **object**<br>Пакет развертывания функций. <br> включает только одно из полей `package`, `content`<br><br><p>Пакет развертывания версий.</p> 
package.<br>bucketName | **string**<br><p>Обязательное поле. Имя бакета, в котором хранится код версии.</p> 
package.<br>objectName | **string**<br><p>Обязательное поле. Имя объекта в корзине, в которой хранится код версии.</p> 
package.<br>sha256 | **string**<br><p>SHA256-хэш пакета развертывания для версии.</p> 
content | **string** (byte) <br> включает только одно из полей `package`, `content`<br><br><p>Содержимое пакета развертывания.</p> <p>Максимальная длина строки в символах — 52428800.</p> 
 
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