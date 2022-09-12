---
editable: false
---

# Метод create
Создает пользовательский сертификат в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://certificate-manager.api.cloud.yandex.net/certificate-manager/v1/certificates
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "certificate": "string",
  "chain": "string",
  "privateKey": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором создается сертификат.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя сертификата. Имя должно быть уникальным в каталоге.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Описание сертификата.</p> <p>Максимальная длина строки в символах — 1024.</p> 
labels | **object**<br><p>Метки сертификата в формате ``ключ:значение``.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
certificate | **string**<br><p>Содержимое сертификата в PEM-encoded формате. Можно пропустить, если сертификат включен в цепочку доверия.</p> <p>Максимальная длина строки в символах — 32768.</p> 
chain | **string**<br><p>Содержимое цепочки сертификатов доверия сертификата в PEM-encoded формате.</p> <p>Максимальная длина строки в символах — 2097152.</p> 
privateKey | **string**<br><p>Обязательное поле. Содержимое закрытого ключа сертификата в PEM-encoded формате.</p> <p>Длина строки в символах должна быть от 1 до 524288.</p> 
 
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