---
editable: false
---

# Метод update
Изменяет указанный симметричный ключ KMS.
 

 
## HTTP-запрос {#https-request}
```
PATCH https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
keyId | Обязательное поле. Идентификатор симметричного ключа KMS, который следует изменить. Чтобы получить идентификатор симметричного ключа используйте запрос [list](/docs/kms/api-ref/SymmetricKey/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "labels": "object",
  "defaultAlgorithm": "string",
  "rotationPeriod": "string",
  "deletionProtection": true
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br><p>Обязательное поле. Маска, определяющая, какие атрибуты указанного симметричного ключа KMS будут обновлены.</p> <p>Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре ``updateMask`` и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.</p> <p>Если в запросе не передается ``updateMask``, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.</p> 
name | **string**<br><p>Новое имя симметричного ключа KMS.</p> <p>Максимальная длина строки в символах — 100.</p> 
description | **string**<br><p>Новое описание симметричного ключа KMS.</p> <p>Максимальная длина строки в символах — 1024.</p> 
status | **string**<br><p>Новый статус для симметричного ключа KMS. С помощью метода <a href="/docs/kms/api-ref/SymmetricKey/update">update</a> вы можете установить только статус ACTIVE или INACTIVE.</p> <ul> <li>CREATING: Ключ создается.</li> <li>ACTIVE: Ключ активен и может использоваться для шифрования и дешифрования. Можно установить в INACTIVE с помощью метода <a href="/docs/kms/api-ref/SymmetricKey/update">update</a>.</li> <li>INACTIVE: Ключ неактивен и не может быть использован. Можно установить в ACTIVE с помощью метода <a href="/docs/kms/api-ref/SymmetricKey/update">update</a>.</li> </ul> 
labels | **object**<br><p>Пользовательские метки для ключа в виде пар ``key:value``. Максимум 64 на ключ.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
defaultAlgorithm | **string**<br><p>Алгоритм шифрования по умолчанию, который следует использовать с новыми версиями симметричного ключа KMS.</p> <p>Поддерживаемые алгоритмы симметричного шифрования.</p> <ul> <li>AES_128: Алгоритм AES со 128-битными ключами.</li> <li>AES_192: Алгоритм AES с 192-битными ключами.</li> <li>AES_256: Алгоритм AES с 256-битными ключами.</li> <li>AES_256_HSM: Алгоритм AES с 256-битными ключами на базе HSM</li> </ul> 
rotationPeriod | **string**<br><p>Период времени между автоматическими ротациями симметричного ключа KMS.</p> 
deletionProtection | **boolean** (boolean)<br><p>Флаг, запрещающий удаление симметричного ключа KMS</p> 
 
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